import os
import glob
import csv
import collections
import shutil

class File_Manager:
    def __init__(self):
        pass
   
    def delete_files(self, filenames):
        for filename in filenames:
            try:
                os.remove("Output/" + filename)
            except FileNotFoundError:
                pass
            except PermissionError:
                print(f'Permission denied for deleting {filename}')
            except Exception as e:
                print(f'Error occurred while deleting {filename}: {e}')

    def delete_coverage_files(self):
        directory_path = os.getcwd() + "/Output/"
        pattern = os.path.join(directory_path, '*.gcda')
        del_files = glob.glob(pattern)
        pattern = os.path.join(directory_path, '*.gcno')
        del_files = del_files + glob.glob(pattern)
        pattern = os.path.join(directory_path, '*.gcov')
        del_files = del_files + glob.glob(pattern)
        for file_path in del_files:
            try:
                os.remove(file_path)
            except Exception as e:
                pass

    def prepare_LLM_prompt(self, prompt, program_to_test):
        print ("Preparing LLM prompt...\n")
        with open(program_to_test, 'r') as file:
            file_content = file.read()
        return prompt + file_content

    def prepare_LLM_prompt_function(self, prompt_function, program_to_test):
        with open(program_to_test, 'r') as file:
            file_content = file.read()
        return prompt_function + file_content

    def create_st_file(self, st_file, program_includes, program_to_test, program_test_runner, program_template, USING_OSCAT=False):
        print("\n\nCombining test program with source code to test and configuration...\n")
        if USING_OSCAT:
            filenames = [program_includes,program_to_test,program_test_runner,program_template]
        else:
            filenames = [program_to_test,program_test_runner,program_template]
        with open(st_file, "w") as outfile:
            for fname in filenames:
                with open(fname) as infile:
                    outfile.write(infile.read())
                    outfile.write("\n\n")

    def rename_files(self):
        directory_path = os.getcwd() + "/Output/"
        for filename in os.listdir(directory_path):
            if os.path.isfile(os.path.join(directory_path, filename)) and filename.startswith("softplc-"):
                new_filename = filename[8:]
                old_file = os.path.join(directory_path, filename)
                new_file = os.path.join(directory_path, new_filename)
                os.rename(old_file, new_file)


    def move_files_to_result_subfolder(self, promptCounter, program_to_test):
        destination_folder = os.getcwd() + "/" + program_to_test[:-3] + "_" + str(promptCounter)
        os.makedirs(destination_folder, exist_ok=True)

        program_name = program_to_test.split("/")[1][:-3]

        shutil.move(program_to_test[:-3] + "_TestCases.csv" , destination_folder + "/" + program_name + "_TestCases.csv")
        shutil.move(program_to_test[:-3] + "_TestCases.st" , destination_folder + "/" + program_name + "_TestCases.st")
        shutil.move(program_to_test[:-3] + "_FullTest.st" , destination_folder + "/" + program_name + "_FullTest.st")

        program = program_to_test.split("/")[1]
        coverage_file = program[:-3] + "_FullTest.st.gcov" 
        shutil.move("Output/"+coverage_file , destination_folder + "/" + program_name + "_FullTest.st.gcov")
        shutil.move("Output/output.txt", destination_folder + "/output.txt")

    def test_case_CSV_to_ST(self, input_file, output_file):
        tests = collections.defaultdict(dict)
        fb_name = ""

        # Read the input CSV file
        with open(input_file, mode='r', newline='') as csvfile:
            reader = csv.reader(csvfile)
            for row in reader:
                # Skip blank lines
                if not row or all(x.strip() == '' for x in row):
                    continue
                # Skip rows that do not have 4 entries (sometimes LLM generates text into the CSV)
                if len(row) != 5:
                    continue
                modified_row = [cell.replace('"', "'") for cell in row]
                test_id, test_state, io_type, variable, value = [x.strip() for x in modified_row]
                parts = variable.split('.')
                fb_name2, variable_name = parts[0], parts[1]
                fb_name = fb_name2
                
                test_id = int(test_id.replace("test",""))
                if test_state.startswith("----"): test_state = "state0" # for simple prompt
                test_state = int(test_state.replace("state",""))
                
                if test_id not in tests:
                    tests[test_id][test_state] = {'inputs': [], 'outputs': []}
                else:
                    if test_state not in tests[test_id]:
                        tests[test_id][test_state] = {'inputs': [], 'outputs': []}
                if io_type == 'i':
                    tests[test_id][test_state]['inputs'].append(f"{variable_name} := {value}")
                else:  # io_type == 'o'
                    tests[test_id][test_state]['outputs'].append(f"TestBlock.{variable_name} = {value}")

        # Write the output
        with open(output_file, mode='w', newline='') as st_file:
            
            # *** FUNCTION BLOCKS ***
            for test_id in sorted(tests.keys()):
                test_number = str(test_id)
                st_file.write(f"FUNCTION_BLOCK FB_TEST_"+test_number)                
                function_block_def=f"""
  VAR_OUTPUT
    Finished : BOOL;
    Failed : BOOL;
  END_VAR
  VAR
    TestBlock : {fb_name};
    TestState : INT;
    Timer : TON;
  END_VAR

  Timer(IN:=TRUE, PT:= T#0s); (* placeholder for later usage *)
  
  CASE testState OF
"""
                st_file.write(function_block_def)
                for test_state in sorted(tests[test_id].keys()):
                    state_number = str(test_state)
                    test = tests[test_id][test_state]
                    inputs = ', '.join(test['inputs'])
                    
                    if(test_state != 0):
                        test = tests[test_id][test_state-1]
                    
                    outputs = ' AND '.join(test['outputs'])
                    
                    if(state_number == "0"): # do not check outputs for state 0 directly, only in next state
                        st_file.write(f"    "+state_number+":\n")
                        st_file.write(f"      IF (Timer.Q) THEN\n")
                        st_file.write(f"        TestBlock({inputs});\n")
                        st_file.write(f"        TestState:=TestState+1;\n")
                        st_file.write(f"      END_IF;\n")
                        st_file.write(f"      Timer(IN:=TRUE, PT:=T#0s);\n")
                        continue
                    st_file.write(f"    "+state_number+":\n") # regular code for any other state
                    st_file.write(f"      IF (Timer.Q) THEN\n")
                    for op in test['outputs']:
                        output_var = op.split('=')[0].strip().upper()
                        st_file.write("      {printf(\""+test_number+","+str(test_state-1)+": "+op+"  actual=%lf\\n\", (double)__GET_VAR(data__->"+output_var+",));}\n")
                    #st_file.write("      {printf(\""+test_number+","+str(test_state-1)+": "+outputs+"  actual=%lf\\n\", (double)__GET_VAR(data__->TESTBLOCK.Y,));}\n")                    
                    st_file.write(f"        IF NOT ({outputs}) THEN Failed := TRUE; END_IF;\n")
                    st_file.write(f"        TestBlock({inputs});\n")
                    st_file.write(f"        TestState:=TestState+1;\n")
                    st_file.write(f"      END_IF;\n")
                    st_file.write(f"      Timer(IN:=TRUE, PT:=T#0s);\n")

                largest_state = len(tests[test_id].keys())
                test = tests[test_id][test_state]
                outputs = ' AND '.join(test['outputs'])
                st_file.write(f"    {largest_state}:\n")
                st_file.write(f"      IF (Timer.Q) THEN\n")
                for op in test['outputs']:
                    output_var = op.split('=')[0].strip().upper()
                    st_file.write("      {printf(\""+test_number+","+str(largest_state-1)+": "+op+"  actual=%lf\\n\", (double)__GET_VAR(data__->"+output_var+",));}\n")
                #st_file.write("      {printf(\""+test_number+","+str(largest_state-1)+": "+outputs+"  actual=%lf\\n\", (double)__GET_VAR(data__->TESTBLOCK.Y,));}\n")  
                st_file.write(f"        IF NOT({outputs}) THEN Failed := TRUE; END_IF;\n")
                st_file.write(f"      END_IF;\n")
                st_file.write(f"      Finished:=TRUE;\n")
                
                st_file.write("  END_CASE;\n")
                st_file.write("END_FUNCTION_BLOCK\n\n")

            # *** PROGRAM ***
            header = f"""
PROGRAM TestRunnerProgram
VAR
  testResult AT %QX0.0 : BOOL := FALSE;
END_VAR
VAR
  totalTests AT %QW0 : INT := 0;
  passedTests AT %QW1 : INT := 0;
END_VAR
VAR
  i: INT := 0;
  testOutcomeArray : ARRAY [0..{len(tests)-1}] OF BOOL;
"""
            st_file.write(header)         
            
            for test_id in sorted(tests.keys()):
                test_number = str(test_id)
                st_file.write(f"  Test_" + test_number + ": FB_TEST_"+test_number+";\n")
            st_file.write("END_VAR\n\n")         

            
            for test_id in sorted(tests.keys()):
                test_number = str(test_id)
                st_file.write(f"  IF NOT Test_" + test_number + ".Finished AND NOT Test_"+test_number+".FAILED THEN totalTests := totalTests + 1; Test_"+test_number+"(); END_IF;\n")
                st_file.write("  IF Test_" + test_number + ".Finished THEN testOutcomeArray["+test_number+"] := TRUE; END_IF;\n")

            st_file.write("\n")
            st_file.write("  passedTests := 0;\n")
            st_file.write(f"  FOR i:=0 TO {len(tests)-1} DO\n")
            st_file.write(f"    IF testOutcomeArray[i]=TRUE THEN passedTests := passedTests+1; END_IF;\n")
            st_file.write(f"  END_FOR;\n")
            st_file.write("END_PROGRAM\n\n")    