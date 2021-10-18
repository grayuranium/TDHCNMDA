function [auc]=getauc(fpr,tpr)
% º∆À„AUC
% [~,box] = size(fpr);
% auc = 0;
% for i=2:box
%     auc = auc+(fpr(i)-fpr(i-1))*tpr(i);
% end
auc = trapz(fpr,tpr);
end