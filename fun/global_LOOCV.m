function [all_TPR,all_FPR]=global_LOOCV(sd,sm,interaction,data_set)
[pp,~] = size(data_set);
all_TPR = zeros(pp,100);
all_FPR = zeros(pp,100);
for i = 1:pp
    temp = interaction;
    % exclude test samples
    temp(data_set(i,2),data_set(i,1))=-inf;
    % save indexes of candidate samples
    cadidate_index = find(temp==0);
    cadidate_Y = cadidate_index;
    cadidate_Y(:,:)=0;
    % save indexes of positive samples
    positive_index = find(temp==-inf);
    index = [positive_index;cadidate_index];
    % save true label
    Y = [1;cadidate_Y];
    [p,~] = size(Y);
    temp(data_set(i,2),data_set(i,1))=0;
    % IMCMDA
%     [score]=IMCMDA(temp,sd,sm,100);
    % WBSMDA
%     [score]=WBSMDA(temp,sd,sm);
    % RWRMDA
%     [score]=RWRMDA(temp,sm,0.2);
    % RLSMDA
%     [score]=RLSMDA(temp,sd,sm,1,1,0.9);
    % MIDP
%     [score]=MIDP(temp,sm,0.4,0.1);
    % TDHCNMDA
    [score]=TDHCNMDA(temp,sm,sd,4,1,1,0,0.1);
    res = score(index);
    [~,score_index]=sort(res);
    score_index = fliplr(score_index')';
    % adjust thresholds
    count = 1;
    for k=linspace(0,1,100)
        X = zeros(p,1);
        positive_index = floor(p*k);
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
end