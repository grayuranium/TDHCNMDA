function [AUC]=getfivefold_TCRWMDA(data_set,sd,sm,mir_dis,name,eposi)
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
total_FPR = zeros(eposi,100);
total_TPR = zeros(eposi,100);
for i=1:eposi
    disp(['eposi......',num2str(i)])
    [all_TPR,all_FPR]=five_fold_TCRWMDA(sd,sm,sl,interactionB,interactionC,mir_dis,data_set);
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