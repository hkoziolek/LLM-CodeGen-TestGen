class Coverage_Reporter:
    def __init__(self):
        pass
   
    def create_report(self, test_case_generator):
        print(f"Printing coverage report...\n")
        test_case_generator.run('gcov', ['Res0.c'], False)
        # coverage_report = f"POUS.c.gcov"
        # with open(coverage_report, 'r') as file:
        #     print(file.read())

    def create_html_report(self, test_case_generator):
        # gcovr -r . --html -o coverage.html
        args = [
            "-r", ".",  # Root directory for coverage data
            "--html",  # Generate HTML report
            "-o", "coverage.html",  # Output filename for the report
            "--exclude", "matiec/*",  # Exclude matiec folder
            "--exclude", "plc.c",  # Exclude plc.c file
            "--exclude", "main.c",  # Exclude main.c file
            "--exclude", "Res0.c",  # Exclude Res0.c file
            "--exclude", "Config0.c",  # Exclude Config0.c file
        ]
        test_case_generator.run('gcovr', args)

    def calculate_statement_coverage(self, program_to_test):
        program = program_to_test.split("/")[1][:-3]
        coverage_file = "Output/"+program+"_FullTest.st.gcov" 
        coverage = 0

        with open(coverage_file, 'r') as file:
            start_line = 0
            end_line = 0
            lines_uncovered_counter=0
            for i, line in enumerate(file, start=1):
                if "FUNCTION_BLOCK " + program in line:
                    start_line = i
                    continue
                if start_line > 0 and end_line == 0 and "END_FUNCTION_BLOCK" in line:
                    end_line = i
                    break
                if start_line > 0 and end_line == 0 and "####" in line:
                    lines_uncovered_counter += 1
            
            total_lines = end_line - start_line
            lines_covered = total_lines - lines_uncovered_counter
            coverage = (lines_covered / total_lines) * 100

        with open("Output/output.txt", 'a') as file:
            file.write(f"Statement coverage for {program}: {coverage}%\n")
            
            
            
        