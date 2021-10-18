#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2021/7/30 19:48
# @Author  : AlexRC
# @File    : Zhu.py
# @Software: win10 python3.6.3

# We only provide the code for predicting new diseases here.
# The global loocv and 5-fold cross-validation can obtained from origin paper.

def NewDisease(epochs):
    # top_index = loadmat('/mnt/DMA/top_index.mat')
    # top_index = top_index['top_index']
    known_associations, unknown_associations = divide_known_unknown_associations(DMA)
    nm = 495
    nd = 383
    total_scores = np.zeros((nd,nm))
    for i in range(nd):
        DMAtest = known_associations[known_associations[:, 0] == i, :]
        DMAtrain = known_associations[known_associations[:, 0] != i, :]
        _, DMAcandidate = divide_known_unknown_associations(DMA, special=i)
        scores, labels = train_and_evaluate(DMAtrain=DMAtrain, DMAtest=DMAtest, DMAcandidate=DMAcandidate,
                                            graph=graph, num_steps=epochs)
        total_scores[i,:] = scores
        print('Total Batch:.......' + str(i))
    datanew = "/mnt/DMA/total_scores.mat"
    savemat(datanew, {'total_scores': total_scores})
    print('FINISH!!!!!!!!!!')

if __name__ == '__main__':
    NewDisease(2000)