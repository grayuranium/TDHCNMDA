function [AUC]=getfivefold_para(data_set,dis_sim,mir_sim,mir_dis,eposi)
AUC = zeros(10);
for theta1=0.1:0.1:1
    for theta2=0.1:0.1:1
        total_FPR = zeros(eposi,100);
        total_TPR = zeros(eposi,100);
        for i=1:eposi
            [all_TPR,all_FPR]=five_fold_para(dis_sim,mir_sim,mir_dis,data_set,theta1,theta2);
            % calculate the mean AUC
            total_FPR(i,:) = mean(all_FPR);
            total_TPR(i,:) = mean(all_TPR);
        end
        FPR = total_FPR;
        TPR = total_TPR;
        mean_FPR = mean(FPR);
        mean_TPR = mean(TPR);
        AUC(uint8(theta1*10),uint8(theta2*10)) = getauc(mean_FPR,mean_TPR);
    end
    disp(['eposi......',num2str(theta1)])
end
end