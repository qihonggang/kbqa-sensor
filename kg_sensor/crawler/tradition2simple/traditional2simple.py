# encoding=utf-8

"""

@author: qhg

@contact: sxxzqhg@163.com

@file: traditional2simple.py

@time: 2020/9/18 13:23

@desc: 繁体中文转为简体中文

"""
from kg_sensor.crawler.tradition2simple.langconv import *


def tradition2simple(line):
    line = Converter('zh-hans').convert(line)
    return line
