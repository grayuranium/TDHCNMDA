function [mean_AUC]=newdisease(sd,sm,interaction,name)
[nd,nm] = size(interaction);
all_TPR = zeros(nd,100);
all_FPR = zeros(nd,100);

for i=1:nd
    Y = interaction(i,:);
    temp = interaction;
    temp(i,:)=0;
    % IMCMDA
%     [score]=IMCMDA(temp,sd,sm,100);
    % WBSMDA
%     [score]=WBSMDA(temp,sd,sm);
    % RLSMDA
%     [score]=RLSMDA(temp,sd,sm,1,1,0.9);
    % TDHCNMDA
    [score]=TDHCNMDA(temp,sm,sd,4,1,1,0,2);
    res = score(i,:);
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
        all_TPR(i,count)=TPR;
        all_FPR(i,count)=FPR;
        count=count+1;
    end
    disp(['..',num2str(i)])
end
AUC = zeros(1,nd);
for i=1:nd
    AUC(i) = getauc(all_FPR(i,:),all_TPR(i,:));
end
save(['./res/AUC_newdisease_',name,'.mat'],'AUC')
mean_AUC = mean(AUC);
end