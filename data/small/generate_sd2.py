#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2021/4/30 9:39
# @Author  : AlexRC
# @File    : generate_sd2.py
# @Software: win10 python3.6.3

import xlrd
import math
import numpy as np
import pandas as pd

book = xlrd.open_workbook('SD2_mesh.xlsx')

sheet1 = book.sheets()[0]

col3_values = sheet1.col_values(2)
# 建立所有疾病名称集合
dis_set = set()
# 建立每个DAG包含的疾病列表
dis_list = []
for i in col3_values:
    i1 = i.split('\n')
    # 每个DAG包含的疾病
    item_list = []
    per_set = set()
    for j in i1:
        i2 = j.split('.')
        # 每个分支包含的疾病
        line_list = []
        for k1 in range(len(i2)):
            line_list.append('.'.join(i2[0:k1 + 1]))
        item_list.extend(line_list)
    for k in item_list:
        dis_set.add(k)
        per_set.add(k)
    dis_list.append(per_set)
dis_list_len = len(dis_list)
# 建立每个疾病对应的值
dis_dict = {}
for i in dis_set:
    count = 0
    for j in dis_list:
        if i in j:
            count += 1
    dis_dict[i] = -math.log(count / dis_list_len)
# 计算每个疾病DAG的值
dis_val = []
for i in dis_list:
    value = 0
    for j in i:
        value += dis_dict[j]
    dis_val.append(value)
# 计算SD2
SD2 = []
for i in range(len(dis_val)):
    SD2_row = []
    for j in range(len(dis_val)):
        union = dis_list[i] & dis_list[j]
        union_val = 0
        for k in union:
            union_val += dis_dict[k]
        SD2_row.append((union_val*2)/(dis_val[i]+dis_val[j]))
    SD2.append(SD2_row)
# 63号疾病和109号疾病没在MESH找到对应条目，因此默认与其他疾病无关联
dis63 = [0.0 for index in range(len(dis_val))]
dis63[62] = 1.0
dis109 = [0.0 for index in range(len(dis_val))]
dis109[108] = 1.0
SD2[62] = dis63
SD2[108] = dis109

A = np.array(SD2)
data = pd.DataFrame(A)

writer = pd.ExcelWriter('SD2.xlsx')		# 写入Excel文件
data.to_excel(writer, 'sheet1', float_format='%.4f')		# ‘page_1’是写入excel的sheet名
writer.save()

writer.close()