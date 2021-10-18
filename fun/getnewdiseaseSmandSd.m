function [all_sm,all_sd,all_interaction]=getnewdiseaseSmandSd(FS,FSP,SS,SSP,data_set)
% 已知关联个数
[pp,~] = size(data_set);
% 疾病个数
nd = max(data_set(:,2));
% miRNA个数
nm = max(data_set(:,1));
all_sm = zeros(nm,nm,nd);
all_sd = zeros(nd,nd,nd);
all_interaction = zeros(nd,nm,nd);
interaction = zeros(nd,nm);
for i=1:pp
    interaction(data_set(i,2),data_set(i,1))=1;
end
for i = 1:nd
    temp2 = interaction;
    temp2(i,:)=0;
    % 计算sd、sm
    [kd,km] = gaussiansimilarity(temp2,nd,nm);
    [sd,sm] = integratedsimilarity(FS,FSP,SS,SSP,kd,km);
    all_sm(:,:,i)=sm;
    all_sd(:,:,i)=sd;
    all_interaction(:,:,i)=temp2;
    disp(['..',num2str(i)])
end
end