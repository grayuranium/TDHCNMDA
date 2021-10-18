function [all_TPR,all_FPR]=five_fold(sd,sm,interaction,data_set)

B=textread('mirna-lncrna.txt');
C=textread('lncrna-disease.txt');
[nd,nm]=size(interaction);
nl=max(B(:,2));% nl=34:the number of lncrnas
[bb,]=size(B);
[cc,]=size(C);

interactionB = zeros(nm,nl);
interactionC = zeros(nl,nd);
for i=1:bb
    interactionB(B(i,1),B(i,2))=1;
end
for i=1:cc
    interactionC(C(i,1),C(i,2))=1;
end

[pp,~] = size(data_set);
all_TPR = zeros(5,100);
all_FPR = zeros(5,100);
% shuffle
shuffle_index = randperm(pp);
data_set = data_set(shuffle_index,:);
per = floor(pp/5);
for i = 1:5
    if i==5
        temp_data = data_set((i-1)*per+1:end,:);
    else
        temp_data = data_set((i-1)*per+1:i*per,:);
    end
    temp = interaction;
    % exclude test samples
    for j=1:length(temp_data)
        temp(temp_data(j,2),temp_data(j,1))=-inf;
    end
    % save indexes of candidate samples
    cadidate_index = find(temp==0);
    cadidate_Y = cadidate_index;
    cadidate_Y(:,:)=0;
    % save indexes of positive samples
    positive_index = find(temp==-inf);
    positive_Y = positive_index;
    positive_Y(:,:)=1;
    index = [positive_index;cadidate_index];
    % save true label
    Y = [positive_Y;cadidate_Y];
    [p,~] = size(Y);
    for j=1:length(temp_data)
        temp(temp_data(j,2),temp_data(j,1))=0;
    end
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
    % MKRMDA
%     [score]=MKRMDA(temp,sm,sd1,sd2);
    % TDHCNMDA
    [score]=TDHCNMDA(temp,sm,sd,4,1,1,0,2);
    % TDHCNMDA_plus
%     [score]=TDHCNMDA_plus(temp,sm,sd,interactionB,interactionC,4,1,1,0,2);
    % TDHCNMDA_sub
%     [score]=TDHCNMDA_sub(temp,4,1,1,2);
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