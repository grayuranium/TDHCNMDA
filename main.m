clear;clc;
addpath('./fun/');
addpath('./method/');
% Model name
modal_name = 'TDHCNMDA';
% Datasets
load('./data/middle/data_set.mat');
load('./data/middle/dis_sim.mat');
load('./data/middle/dis_mir.mat');
load('./data/middle/mir_sim.mat');
load('./data/middle/mir_name.mat');
load('./data/middle/top_index.mat');
load('./data/middle/SD1.mat');
load('./data/middle/SD2.mat');

% Parameters analysis
% five_fold = getfivefold_para(data_set,dis_sim,mir_sim,dis_mir,10);

% Performance evaluation
% global LOOCV
% global_loocv = getgloballoocv(data_set,dis_sim,mir_sim,dis_mir,modal_name);
% global_loocv = getgloballoocv_MKRMDA(data_set,SD1,SD2,mir_sim,dis_mir,modal_name);
% global_loocv = getgloballoocv_TCRWMDA(data_set,dis_sim,mir_sim,dis_mir,modal_name);

% 5-fold cross-validation
five_fold = getfivefold(data_set,dis_sim,mir_sim,dis_mir,modal_name,100);
% five_fold = getfivefold_MKRMDA(data_set,SD1,SD2,mir_sim,dis_mir,modal_name,100);
% five_fold = getfivefold_TCRWMDA(data_set,dis_sim,mir_sim,dis_mir,modal_name,100);

% Prediction for new diseases
% new_disease = newdisease(dis_sim,mir_sim,dis_mir,modal_name);
% new_disease = newdisease_special(dis_sim,mir_sim,dis_mir,modal_name);
% new_disease = newdisease_MKRMDA(SD1,SD2,mir_sim,dis_mir,modal_name);
% new_disease = newdisease_TCRWMDA(dis_sim,mir_sim,dis_mir,modal_name);

% Performance of TDHCNMDA+
% five_fold = getfivefold(data_set,dis_sim,mir_sim,dis_mir,modal_name,100);

% Case studies
% result = casestudy(dis_mir,dis_sim,mir_sim,mir_name);
