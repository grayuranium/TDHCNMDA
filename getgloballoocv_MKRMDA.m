function [AUC] = getgloballoocv_MKRMDA(data_set,sd1,sd2,mir_sim,mir_dis,name)
[all_TPR,all_FPR]=global_LOOCV_MKRMDA(sd1,sd2,mir_sim,mir_dis,data_set);
% calculate the mean AUC
mean_FPR = mean(all_FPR);
mean_TPR = mean(all_TPR);
FPR = mean_FPR;
TPR = mean_TPR;
AUC = getauc(FPR,TPR);
save(['./res/FPR_global_',name,'.mat'],'FPR')
save(['./res/TPR_global_',name,'.mat'],'TPR')
end