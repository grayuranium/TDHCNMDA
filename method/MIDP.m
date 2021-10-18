function [score]=MIDP(A,Y,rq,ru)
% A:interaction X:sd Y:sm
Y = Y./sum(Y,2);
% 注意对角线是0奥
Y(logical(eye(size(Y))))=0;
[nd,nm] = size(A);
score = A;
score(:,:)=0;
for i=1:nd
    p0 = A(i,:)';
    Mq = Y;
    Mq(p0'==0,:)=0;
    Mu = Y;
    Mu(p0'==1,:)=0;
    S0 = A(i,:)';
    S0 = S0./sum(S0);
    tempS = S0;
    pq = sum(tempS(A(i,:)'==1));
    pu = 1-pq;
    S = Mq'*tempS.*rq+S0.*(1-rq).*pq+Mu'*tempS.*ru+S0.*(1-ru).*pu;
    while(norm(S-tempS,1)>1*10^-10)
        tempS = S;
        pq = sum(tempS(A(i,:)'==1));
        pu = 1-pq;
        S = Mq'*tempS.*rq+S0.*(1-rq).*pq+Mu'*tempS.*ru+S0.*(1-ru).*pu;
    end
    score(i,:)=S';
end
end