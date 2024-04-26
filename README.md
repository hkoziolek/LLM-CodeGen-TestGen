# LLM-based Control Logic Test Case Generator
This repository contains a [LangChain](https://www.langchain.com/) program (Test_Case_Generator.py) to generate test cases for function blocks written in 
[IEC 61131-3](https://en.wikipedia.org/wiki/IEC_61131-3) ST control logic. LLM-Prompts ask for test cases formulated as CSV files, which the test case generator converts to ST-code, transpiles it to C-code, compiles the C-code, executes it, and calculates coverage metrics. How to use it: 

* Enter your API key in LLM_Manager.py.
* Have [gcc](https://gcc.gnu.org/) installed and accessible.
* Download [MATIEC](https://github.com/nucleron/matiec), build it, and place its executables and source in the subfolder "/matiec".
* Configure the code to test within the source code (line 59, Test_Case_Generator.py)
* Check the prompts that shall be used in the subfolder "/Prompts". Modify them if needed, and edit the source code (line 82ff, Test_Case_Generator.py) to include any of them.
* Run "python Test_Case_Generator.py" from the command line, output of the LLM should stream to stdout.
* After a succesfull execution, check the generated files in the subfolder "/Tests". Output.txt contains the output of running the soft-controller, as well as the statement coverage. A CSV file contains the LLM-generated test case, and the ST-program created from it is in a file with the suffix "FullTest.st". The file with the suffix "FullTest.st.gcov" contains a coverage report from gcov.

Functions blocks in "/Tests" are from [OSCAT](https://www.oscat.de) or self-implemented. Check the subfolders in "/Tests" which contain the results from several experiment runs.

