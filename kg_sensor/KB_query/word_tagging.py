# encoding=utf-8

"""

@author: qhg

@contact: sxxzqhg@163.com

@file: word_tagging.py

@time: 2020/9/18 14:49

@desc: 定义Word类的结构；定义Tagger类，实现自然语言转为Word对象的方法。

"""
import jieba
import jieba.posseg as pseg


class Word(object):
    def __init__(self, token, pos):
        self.token = token
        self.pos = pos


class Tagger:
    def __init__(self, dict_paths):
        # TODO 加载外部词典
        for p in dict_paths:
            jieba.load_userdict(p)

    @staticmethod
    def get_word_objects(sentence):
        # type: (str) -> list
        """
        把自然语言转为Word对象
        :param sentence:
        :return:
        """
        return [Word(word, tag) for word, tag in pseg.cut(sentence)]


# TODO 用于测试
if __name__ == '__main__':
    tagger = Tagger(['./external_dict/metadata_sensor_name.txt', './external_dict/situation_name.txt'])
    while True:
        s = input('>>')
        for i in tagger.get_word_objects(s):
            print(i.token, i.pos)
