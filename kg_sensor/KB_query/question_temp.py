# encoding=utf-8

"""

@author: qhg

@contact: sxxzqhg@163.com

@file: question_temp.py

@time: 2020/9/18 14:49

@desc:
设置问题模板，为每个模板设置对应的SPARQL语句。demo提供如下模板：

1. 某传感器表达了什么情境
2. 某情境包含哪些元数据
3. 某元数据的预测模型是什么
4. 某元数据的内容是什么
5. 某情境的内容是什么
6. 某预测模型的内容是什么

读者可以自己定义其他的匹配规则。
"""
from refo import finditer, Predicate, Star, Any, Disjunction
import re

# TODO SPARQL前缀和模板
SPARQL_PREXIX = """
PREFIX : <http://www.sensor-situation.com#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
"""

SPARQL_SELECT_TEM = "{prefix}\n" + \
             "SELECT DISTINCT {select} WHERE {{\n" + \
             "{expression}\n" + \
             "}}\n"

SPARQL_COUNT_TEM = "{prefix}\n" + \
             "SELECT COUNT({select}) WHERE {{\n" + \
             "{expression}\n" + \
             "}}\n"

SPARQL_ASK_TEM = "{prefix}\n" + \
             "ASK {{\n" + \
             "{expression}\n" + \
             "}}\n"

class W(Predicate):
    def __init__(self, token=".*", pos=".*"):
        self.token = re.compile(token + "$")
        self.pos = re.compile(pos + "$")
        super(W, self).__init__(self.match)

    def match(self, word):
        m1 = self.token.match(word.token)
        m2 = self.pos.match(word.pos)
        return m1 and m2

class Rule(object):
    def __init__(self, condition_num, condition=None, action=None):
        assert condition and action
        self.condition = condition
        self.action = action
        self.condition_num = condition_num

    def apply(self, sentence):
        matches = []
        for m in finditer(self.condition, sentence):
            i, j = m.span()
            matches.extend(sentence[i:j])
        return self.action(matches), self.condition_num

class QuestionSet:
    def __init__(self):
        pass

    @staticmethod
    def has_metadata_sensor_question(word_objects):
        """
        某传感器表达了什么情境
        :param word_objects:
        :return:
        """
        select = "?x"
        sparql = None
        for w in word_objects:
            if w.pos == pos_metadata_sensor:
                e = "?m :metadataSensorName '{metadata_sensor_name}'."\
                    "?m :hasSituation ?s."\
                    "?s :situationName ?x".format\
                    (metadata_sensor_name=w.token.encode().decode('utf-8'))

                sparql = SPARQL_SELECT_TEM.format(prefix=SPARQL_PREXIX,
                                                  select=select,
                                                  expression=e)
                break
        return sparql


# TODO 定义关键词
pos_metadata_sensor = "nc"
metadata_sensor_entity = (W(pos=pos_metadata_sensor))

sensor = (W("传感器") | W("设备"))
situation = (W("情境") | W("情景") | W("场景"))


# TODO 问题模板/匹配规则

"""
1. 某传感器表达了什么情境
"""
rules = [
    Rule(condition_num=2, condition=metadata_sensor_entity + Star(Any(), greedy=False) + situation + Star(Any(), greedy=False), action=QuestionSet.has_metadata_sensor_question),
]