from langchain_openai import ChatOpenAI
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
from langchain_community.callbacks import get_openai_callback

class LLM_Manager:
    def __init__(self):
        pass

    def get_llm(self):
        my_openai_api_key = "" # Add your OpenAI API key here

        return ChatOpenAI(
            openai_api_key=my_openai_api_key,
            model_name="gpt-4",
            callbacks=[StreamingStdOutCallbackHandler()],
            streaming=True,
            verbose=True, 
            temperature=0.7
        )
