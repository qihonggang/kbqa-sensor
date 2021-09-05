# encoding=utf-8
from kg_sensor.KB_query.query_main import QAInterface
import streamlit as st


@st.cache(allow_output_mutation=True)
def get_interface():
    interface = QAInterface()
    return interface


qa_interface = get_interface()

st.title("基于物联网传感情境的智能问答系统")

st.text_area('支持的问题类型',
"""
1. 某传感器表达了什么情境？
2. 某情境包含哪些元数据？
3. 某元数据的预测模型是什么？
4. 某元数据的内容是什么？
5. 某情境的内容是什么？
6. 某预测模型的内容是什么？
""", height=220)

question = st.text_input("请输入你的问题：")
if question != "":
    st.text("回答：" + qa_interface.answer(question))
    # st.write(qa_interface.answer(question))
