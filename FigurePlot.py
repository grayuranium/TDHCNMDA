#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2021/6/28 7:06
# @Author  : AlexRC
# @File    : FigurePlot.py
# @Software: win10 python3.6.3

import xlrd
import matplotlib.pyplot as plt
import cv2
import numpy as np

# 绘制参数折线图
# workbook1 = xlrd.open_workbook(u'Parameter_t.xlsx')
# sheet1 = workbook1.sheet_by_index(0)
# x1 = sheet1.col_values(0)
# y1 = sheet1.col_values(1)
# workbook2 = xlrd.open_workbook(u'Parameter_sigma.xlsx')
# sheet1 = workbook2.sheet_by_index(0)
# x2 = sheet1.col_values(0)
# y2 = sheet1.col_values(1)
# workbook3 = xlrd.open_workbook(u'Parameter_alpha.xlsx')
# sheet1 = workbook3.sheet_by_index(0)
# x3 = sheet1.col_values(0)
# y3 = sheet1.col_values(1)
#
# fig = plt.figure()
# ax1 = fig.add_subplot(311)
# ax1.set(xlim=[0, 10], ylim=[0.85, 1], xticks=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
#         yticks=[0.85, 0.9, 0.95, 1.0], ylabel='AUC', xlabel='Values of parameter t')
# ax1.plot(x1, y1, marker=".", color="red")
# ax1.annotate(s=format(y1[4], '.4f'), xy=(x1[4], y1[4]), xytext=(x1[4], y1[4] + 0.02), xycoords='data',
#              arrowprops=dict(arrowstyle="->"))
#
# ax2 = fig.add_subplot(312)
# ax2.set(xlim=[0, 1], ylim=[0.85, 1], xticks=[0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
#         yticks=[0.85, 0.9, 0.95, 1.0], ylabel='AUC', xlabel=r'Values of parameter $\sigma$')
# ax2.plot(x2, y2, marker=".", color="red")
# ax2.annotate(s=format(y2[0], '.4f'), xy=(x2[0], y2[0]), xytext=(x2[0] + 0.05, y2[0] + 0.015), xycoords='data',
#              arrowprops=dict(arrowstyle="->"))
#
# ax3 = fig.add_subplot(313)
# ax3.set(xlim=[1, 10], ylim=[0.85, 1], xticks=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
#         yticks=[0.85, 0.9, 0.95, 1.0], ylabel='AUC', xlabel=r'Values of parameter $\alpha$')
# ax3.plot(x3, y3, marker=".", color="red")
# ax3.annotate(s=format(y3[1], '.4f'), xy=(x3[1], y3[1]), xytext=(x3[1], y3[1] + 0.017), xycoords='data',
#              arrowprops=dict(arrowstyle="->"))
#
# plt.subplots_adjust(hspace=0.5)
# fig.set_size_inches(7, 6)
# plt.savefig('Figure2.tif', dpi=1200)
# plt.show()

# 绘制参数热力图
# import pandas as pd
# import seaborn as sns
# data = pd.read_excel(u'Parameter_theta.xlsx',header=None)
# data.index = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]
# data.columns = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]
# fig = plt.figure()
# sns.heatmap(data,annot=True,fmt='.4f',cmap='BuGn',vmax=0.8,vmin=1,linewidths=0.05,annot_kws={'size':8,'color':'black'})
# plt.xlabel(r'$\theta_{1}$')
# plt.ylabel(r'$\theta_{2}$')
# fig.set_size_inches(7, 6)
# plt.savefig('Figure3.tif',dpi=1200)
# plt.show()

# 绘制AUC图
# GLOOCV、FFCV、newdisease
# model_path = "E://Matlab_Workspace//TDHCNMDA//res//"
# model_name = ["RWRMDA","MIDP","RLSMDA","WBSMDA","MKRMDA","IMCMDA","TCRWMDA","Zhu's method","TDHCNMDA"]
# TYPE = ["global","fivefold","newdisease"]
# # GLOOCV
# AUC_GLOOCV = [0.83394978,0.770900913,0.835047379,0.825654718,0.889009381,0.837787019,0.917614976,0.888821921,0.925587595]
# # FFCV
# AUC_FFCV = [0.780617248,0.720492299,0.833886077,0.780340643,0.861230268,0.837270179,0.916370735,0.878951578,0.92109353]
# # newdisease
# # AUC = [0.77022982,0.764825224,0.546895267,0.725579539,0.752436226,0.527022982,0.785279542]
# color_list = ['darkred','wheat','darkgreen','deepskyblue','plum','darkgoldenrod','grey','black','red']
# model_AUC_GLOOCV = []
# model_AUC_FFCV = []
# for j in range(9):
#     model_AUC_GLOOCV.append(model_name[j]+"(AUC="+format(AUC_GLOOCV[j],'.4f')+")")
#     model_AUC_FFCV.append(model_name[j]+"(AUC="+format(AUC_FFCV[j],'.4f')+")")
# from scipy.io import loadmat
#
# fig = plt.figure()
# ax1 = fig.add_subplot(121)
# # ax1.set(xlim=[0, 10], ylim=[0.85, 1], xticks=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
# #         yticks=[0.85, 0.9, 0.95, 1.0], ylabel='AUC', xlabel='Values of parameter t')
# ax1.set(xlim=[0,1],ylim=[0,1],xlabel='False Positive Rate',ylabel='True Positive Rate')
# ax1.set_title('Global LOOCV')
# ax1.plot([0, 1], [0, 1], linestyle='--', lw=2, color='royalblue', label='Chance', alpha=.8)
# p1 = []
# for i in range(9):
#     fpr_name = model_path+"FPR_"+TYPE[0]+"_"+model_name[i]+".mat"
#     tpr_name = model_path+"TPR_"+TYPE[0]+"_"+model_name[i]+".mat"
#     fpr = loadmat(fpr_name)
#     fpr = fpr['FPR'][0]
#     tpr = loadmat(tpr_name)
#     tpr = tpr['TPR'][0]
#     temp_p, = ax1.plot(fpr, tpr, color=color_list[i])
#     p1.append(temp_p)
# plt.legend(p1,model_AUC_GLOOCV,loc='lower right')
# plt.grid()
#
# ax2 = fig.add_subplot(122)
# ax2.set(xlim=[0,1],ylim=[0,1],xlabel='False Positive Rate',ylabel='True Positive Rate')
# ax2.set_title('5-fold cross-validation')
# ax2.plot([0, 1], [0, 1], linestyle='--', lw=2, color='royalblue', label='Chance', alpha=.8)
# p2 = []
# for i in range(9):
#     fpr_name = model_path+"FPR_"+TYPE[1]+"_"+model_name[i]+".mat"
#     tpr_name = model_path+"TPR_"+TYPE[1]+"_"+model_name[i]+".mat"
#     fpr = loadmat(fpr_name)
#     fpr = np.mean(fpr['FPR'],axis=0)
#     tpr = loadmat(tpr_name)
#     tpr = np.mean(tpr['TPR'],axis=0)
#     temp_p, = ax2.plot(fpr, tpr, color=color_list[i])
#     p2.append(temp_p)
# plt.legend(p2,model_AUC_FFCV,loc='lower right')
#
# plt.grid()
# fig.set_size_inches(14, 5)
# plt.savefig('Figure4.tif',dpi=1200)
# plt.show()


# model_path = "E://Matlab_Workspace//TDHCNMDA//res//"
# model_name = ["RLSMDA","WBSMDA","MKRMDA","IMCMDA","TCRWMDA","Zhu's method","TDHCNMDA"]
# TYPE = ["global","fivefold","newdisease"]
# # newdisease
# AUC = [0.77022982,0.764825224,0.546895267,0.725579539,0.752436226,0.527022982,0.785279542]
# color_list = ['darkgreen','deepskyblue','plum','darkgoldenrod','grey','black','red']
# model_AUC = []
# for j in range(7):
#     model_AUC.append(model_name[j]+"(AUC="+format(AUC[j],'.4f')+")")
# from scipy.io import loadmat
# plt.figure()
# # ax1.set(xlim=[0, 10], ylim=[0.85, 1], xticks=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
# #         yticks=[0.85, 0.9, 0.95, 1.0], ylabel='AUC', xlabel='Values of parameter t')
# plt.xlim(0,1)
# plt.ylim(0,1)
# plt.xlabel('False Positive Rate')
# plt.ylabel('True Positive Rate')
# plt.title('Performance for the prediction of new diseases')
# plt.plot([0, 1], [0, 1], linestyle='--', lw=2, color='royalblue', label='Chance', alpha=.8)
# p = []
# for i in range(7):
#     fpr_name = model_path+"FPR_"+TYPE[2]+"_"+model_name[i]+".mat"
#     tpr_name = model_path+"TPR_"+TYPE[2]+"_"+model_name[i]+".mat"
#     fpr = loadmat(fpr_name)
#     fpr = fpr['FPR'][0]
#     tpr = loadmat(tpr_name)
#     tpr = tpr['TPR'][0]
#     temp_p, = plt.plot(fpr, tpr, color=color_list[i])
#     p.append(temp_p)
# plt.legend(p,model_AUC,loc='lower right')
# plt.grid()
# plt.savefig('Figure5.tif',dpi=1200)
# plt.show()


# additional biological information
# model_path = "E://Matlab_Workspace//TDHCNMDA//res//"
# model_name = ["TDHCNMDA-","TDHCNMDA","TDHCNMDA+"]
# AUC = [0.915592687,0.92109353,0.921197847]
# color_list = ['hotpink','red','maroon']
# model_AUC = []
# for j in range(3):
#     model_AUC.append(model_name[j]+"(AUC="+format(AUC[j],'.4f')+")")
# from scipy.io import loadmat
#
# plt.figure()
# plt.plot([0, 1], [0, 1], linestyle='--', lw=2, color='royalblue', label='Chance', alpha=.8)
# plt.xlim([0, 1])
# plt.ylim([0, 1])
# plt.xlabel('False Positive Rate')
# plt.ylabel('True Positive Rate')
# plt.title('Performance of TDHCNMDA with additional biological information')
# p = []
# for i in range(3):
#     fpr_name = model_path+"FPR_fivefold_"+model_name[i]+".mat"
#     tpr_name = model_path+"TPR_fivefold_"+model_name[i]+".mat"
#     fpr = loadmat(fpr_name)
#     fpr = fpr['FPR']
#     fpr = np.mean(fpr,axis=0)
#     tpr = loadmat(tpr_name)
#     tpr = tpr['TPR']
#     tpr = np.mean(tpr, axis=0)
#     temp_p, = plt.plot(fpr, tpr, color=color_list[i])
#     p.append(temp_p)
# plt.legend(p,model_AUC,loc='lower right')
# plt.grid()
# plt.savefig('Figure6.tif',dpi=1200)
# plt.show()

# figure concatenate
# from PIL import Image
# img1 = Image.open('Figure2.tif')
# img2 = Image.open('Figure3.tif')
# fig = plt.figure()
# ax1 = fig.add_subplot(121)
# ax1.imshow(img1)
# plt.axis('off')
# ax2 = fig.add_subplot(122)
# ax2.imshow(img2)
# plt.axis('off')
# fig.set_size_inches(6, 3)
# plt.savefig('Parameters.tif',dpi=1200)
# plt.show()