function [AUC]=newdisease_special(sd,sm,interaction,name)
[nd,nm] = size(interaction);
B=textread('mirna-lncrna.txt');
C=textread('lncrna-disease.txt');
lncrnafeature=textread('lncrnafeature.txt');
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
M=transition_matrix_network_propagation1(sm);
D=transition_matrix_network_propagation1(sd);
L=transition_matrix_network_propagation1(sl);

all_TPR = zeros(1,100);
all_FPR = zeros(1,100);
Y = interaction(59,:);
temp = interaction;
temp(59,:)=0;
% IMCMDA
% [score]=IMCMDA(temp,sd,sm,100);
% WBSMDA
% [score]=WBSMDA(temp,sd,sm);
% RLSMDA
% [score]=RLSMDA(temp,sd,sm,1,1,0.9);
% MKRMDA
% [score]=MKRMDA(temp,sm,sd1,sd2);
% TCRWMDA
% [score]=TCRWMDA(M,D,temp,interactionB,interactionC,L, 1, 1, 1,0.1,1,0.9);
% TDHCNMDA
[score]=TDHCNMDA(temp,sm,sd,4,1,1,0,2);
res = score(59,:);
[~,score_index]=sort(res);
score_index = fliplr(score_index);
count = 1;
for k=linspace(0,1,100)
    X = zeros(1,nm);
    positive_index = floor(nm*k);
    if positive_index~=0
        X(score_index(1:positive_index))=1;
    end
    % TN
    TN = length(find(X(Y==0)==0));
    % FP
    FP = length(find(X(Y==0)==1));
    % TP
    TP = length(find(X(Y==1)==1));
    % FN
    FN = length(find(X(Y==1)==0));
    TPR = TP/(TP+FN);
    FPR = FP/(FP+TN);
    all_TPR(1,count)=TPR;
    all_FPR(1,count)=FPR;
    count=count+1;
end
FPR = all_FPR;
TPR = all_TPR;
save(['./hist/FPR_newdisease_',name,'.mat'],'FPR')
save(['./hist/TPR_newdisease_',name,'.mat'],'TPR')
AUC = getauc(FPR,TPR);
end