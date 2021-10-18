function [AUC]=getfivefold_MKRMDA(data_set,SD1,SD2,mir_sim,mir_dis,name,eposi)
total_FPR = zeros(eposi,100);
total_TPR = zeros(eposi,100);
for i=1:eposi
    disp(['eposi......',num2str(i)])
    [all_TPR,all_FPR]=five_fold_MKRMDA(SD1,SD2,mir_sim,mir_dis,data_set);
    % calculate the mean AUC
    total_FPR(i,:) = mean(all_FPR);
    total_TPR(i,:) = mean(all_TPR);
end
FPR = total_FPR;
TPR = total_TPR;
save(['./res/FPR_fivefold_',name,'.mat'],'FPR')
save(['./res/TPR_fivefold_',name,'.mat'],'TPR')
mean_FPR = mean(FPR);
mean_TPR = mean(TPR);
AUC = getauc(mean_FPR,mean_TPR);
end