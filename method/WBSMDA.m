function [score]=WBSMDA(A,X,Y)
% A:interaction X:sd Y:sm
[nd,nm] = size(A);
% 从前往后依次是cmw，cmb,cdw,cdb
res = zeros(nd,nm,4);
for i=1:nd
    for j=1:nm
        if isempty(find(A(i,:)==1, 1))
            % 说明没有miRNA与该疾病相关     
            res(i,j,1) = 1;
            res(i,j,2) = 1;
        else
            res(i,j,1) = max(Y(j,A(i,:)==1));
            res(i,j,2) = max(Y(j,A(i,:)==0));
        end    
    end
end
for i=1:nm
    for j=1:nd
        if isempty(find(A(:,i)==1, 1))
            % 说明没有疾病与该miRNA相关
            res(j,i,3) = 1;
            res(j,i,4) = 1;
        else
            res(j,i,3) = max(X(A(:,i)==1,j));
            res(j,i,4) = max(X(A(:,i)==0,j));
        end
        
    end
end
score = res(:,:,1).*res(:,:,3)./(res(:,:,2).*res(:,:,4));
end