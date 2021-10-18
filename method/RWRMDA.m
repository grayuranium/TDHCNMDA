function [score]=RWRMDA(A,Y,r)
% A:interaction X:sd Y:sm
Y = Y./sum(Y,2);
[nd,nm] = size(A);
score = A;
score(:,:)=0;
for i=1:nd
    p0 = A(i,:)';
    p0 = p0./sum(p0);
    tempp = p0;
    p = (1-r).*(Y*tempp)+r.*p0;
    while(norm(p-tempp,1)>1*10^-6)
        tempp = p;
        p = (1-r).*(Y*tempp)+r.*p0;
    end
    score(i,:)=p';
end
end