# encoding=utf-8

"""

@author: qhg

@contact: sxxzqhg@163.com

@file: csv2txt.py

@time: 2020/9/18 13:23

@desc:
把从mysql导出的csv文件按照jieba外部词典的格式转为txt文件。
nc代表元数据传感器名。
nq代表情境名。

"""
import pandas as pd

if __name__ == '__main__':
    df = pd.read_csv('./metadata_sensor_name.csv')
    title = df['metadata_sensor_name'].values

    with open('./metadata_sensor_name.txt', 'a', encoding='UTF-8') as f:
        for t in title[0:]:
            f.write(t + ' ' + 'nc' + '\n')

    df = pd.read_csv('./situation_name.csv')
    title = df['situation_name'].values

    with open('./situation_name.txt', 'a', encoding='UTF-8') as f:
        for t in title[0:]:
            f.write(t + ' ' + 'nq' + '\n')

