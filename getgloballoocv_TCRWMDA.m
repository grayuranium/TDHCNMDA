function [AUC] = getgloballoocv_TCRWMDA(data_set,sd,sm,mir_dis,name)
B=textread('mirna-lncrna.txt');
C=textread('lncrna-disease.txt');
lncrnafeature=textread('lncrnafeature.txt');
[nd,nm]= size(mir_dis);
nl=max(B(:,2));% nl=34:the number of lncrnas
[bb,]=size(B);
[cc,]=size(C);
interactionB = zeros(nm,nl);
interactionC = zeros(nl,nd);
sl=CosineSmilarity(lncrnafeature);
for i=1:bb%%
    interactionB(B(i,1),B(i,2))=1;
end
for i=1:cc
    interactionC(C(i,1),C(i,2))=1;
end
[all_TPR,all_FPR]=global_LOOCV_TCRWMDA(sd,sm,sl,interactionB,interactionC,mir_dis,data_set);
% calculate the mean AUC
mean_FPR = mean(all_FPR);
mean_TPR = mean(all_TPR);
FPR = mean_FPR;
TPR = mean_TPR;
AUC = getauc(FPR,TPR);
save(['./res/FPR_global_',name,'.mat'],'FPR')
save(['./res/TPR_global_',name,'.mat'],'TPR')
end