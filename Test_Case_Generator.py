import subprocess
import sys
import time
import os
from langchain_core.messages import HumanMessage, SystemMessage
from langchain_community.callbacks import get_openai_callback
from langchain_core.messages import HumanMessage
from LLM_Manager import LLM_Manager
from File_Manager import File_Manager
from Coverage_Reporter import Coverage_Reporter

class Test_Case_Generator:

    def __init__(self):
        pass

    def run(self, executable_path, args, bStore_output = False):
        try:
            command = [executable_path] + args
            print(" ".join(command))
            currentWorkingDir = os.getcwd()
            with subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1, cwd = currentWorkingDir + "/Output") as proc:
                if bStore_output:
                    with open(currentWorkingDir + "/Output/output.txt", 'w') as file:
                        for line in proc.stdout:
                            file.write(line)
                            print(line, end='')
                            sys.stdout.flush()
                else:
                    for line in proc.stdout: 
                        print(line, end='')
                        sys.stdout.flush()
            if proc.returncode != 0:
                print(f"Command exited with code {proc.returncode}")
                if proc.returncode == 1:
                    print(f"Problem occurred in subprocess. Exiting Test Case Generator.")
                    sys.exit()
        except subprocess.CalledProcessError as e:
            print(f'Error occurred: {e}')

    def prompt_llm_for_test_cases(self, prompt, program_test_runner):
        print("Creating test program via LLM...\n")
        llm = LLM_Manager().get_llm()
        messages = [SystemMessage(content="You are a helpful assistant."),
                    HumanMessage(content=prompt),
        ]
        with get_openai_callback() as cb:
            response = llm.invoke(messages)
            print("\n")
            print(cb)
            print("\n")
            with open(program_test_runner, 'w') as file:
                file.write(response.content)

    def main(self):
        USING_OSCAT = True   # flag for OSCAT specific dependancy handling

        # Input files (must be available)
        program_to_test = "Tests/DEC_TO_HEX.st" # code to test
        program_template = "Tests/template.st" # contains the program task configuration
        program_includes = "Tests/INCLUDE.st" # contains the includes for the OSCAT library

        # Output files (will be generated):
        program_test_runner_csv = program_to_test[:-3] + "_TestCases.csv" 
        program_test_runner = program_to_test[:-3] + "_TestCases.st" 
        st_file = program_to_test[:-3] + "_FullTest.st" 

        # Executables and Paths:
        iec2c = 'matiec/iec2c' # need to have matiec installed
        gcc = 'gcc' # need to have gcc installed
        iec2c_lib = 'matiec/lib'
        iec2c_lib2 = 'matiec/lib/C'

        start_time = time.time()
       
        fm = File_Manager()
        
        fm.delete_files(['LOCATED_VARIABLES.h', 'POUS.h', 'POUS.c', 'STD_CONF.c', 'STD_CONF.h', 'STD_RESSOURCE. c', 'VARIABLES.csv', 'plc.o', 'main.o', 'softplc', 'STD_CONF.o', 'STD_RESSOURCE.o'])
        fm.delete_coverage_files()

        # Load prompt templates from disk:
        prompts = []
        with open('Prompts/prompt_testgen-simple.txt', 'r') as file: prompt = file.read()
        prompts.append(prompt)
        with open('Prompts/prompt_testgen-enhanced.txt', 'r') as file: prompt = file.read()
        prompts.append(prompt)
        
        promptCounter = 0
        for p in prompts:
            promptCounter += 1
            prompt = fm.prepare_LLM_prompt(p, program_to_test)
            self.prompt_llm_for_test_cases(prompt, program_test_runner_csv)
            fm.test_case_CSV_to_ST(program_test_runner_csv,program_test_runner)
            fm.create_st_file(st_file,program_includes,program_to_test,program_test_runner,program_template,USING_OSCAT)

            print("Transpiling test program to C source code...\n")
            self.run("../"+iec2c, ['-Ol', '-I', "../"+iec2c_lib, "../"+st_file],False)
            print("\nCompiling test program executable...\n")
            self.run(gcc, ['-I', "../"+iec2c_lib2, '-fprofile-arcs', '-ftest-coverage', 'Config0.c', 'Res0.c', 'plc.c', 'main.c', '-o', 'softplc', '-lm'], False)
            print("\nExecuting tests...\n")
            self.run('stdbuf', ['-oL', './softplc'], True)

            fm.rename_files()
            cr = Coverage_Reporter()
            cr.create_report(self)
            cr.calculate_statement_coverage(program_to_test)

            fm.move_files_to_result_subfolder(promptCounter, program_to_test)       

        end_time = time.time()
        print(f"Test finished. Execution time: {round((end_time - start_time),1)} seconds.")

if __name__ == "__main__":
    obj = Test_Case_Generator()
    obj.main()






