function [score] = TDHCNMDA_sub(A,t,theta1,theta2,leaky)
%SJHMDA 应用超图二维卷积网络进行关联矩阵生成
%   A：已知关联矩阵 SM：已知mirna关联矩阵 SD：已知疾病关联矩阵 默认使用sigmod增添非线性
addpath('./fun/');
% [~,nl] = size(interactionB);
[nd,nm] = size(A);
% B=textread('mirna-lncrna.txt');
% C=textread('lncrna-disease.txt');
% nl=max(B(:,2));% nl=34:the number of lncrnas
% [bb,]=size(B);
% [cc,]=size(C);
% interactionB = zeros(nm,nl);
% interactionC = zeros(nl,nd);
% for i=1:bb%%
%     interactionB(B(i,1),B(i,2))=1;
% end
% for i=1:cc
%     interactionC(C(i,1),C(i,2))=1;
% end
% interactionC = interactionC';


% 首先获取初始U、V矩阵，对原始矩阵进行满秩分解
% [U,V]=fr(A);
% V = V';
[U,S,V]=svd(A,'econ');
S = S-t;
S(S<0)=0;
U = U*S^(1/2);
V = V*S^(1/2);

% H1表示以疾病为节点的超图,nd*(nm+nd)
% H1 = [A,SD,interactionC];
% H1 = [A,SD];
H1 = A;
% 超边可以优化
% H1(H1>=sim_thred)=1;
% 权重分配可以优化
% W1 = diag(repelem([alpha/nm,(1-alpha)/nd],[nm,nd]));
% W1 = eye(nm+nd+nl)./(nm+nd+nl);
% W1 = eye(nm+nd)./(nm+nd);
W1 = eye(nm)./(nm);
D1 = sum(H1*diag(W1),2);
D1 = diag((D1+1).^(-1/2));
% D1 = diag(D1.^(-1/2));
DELTA1 = diag(sum(H1));
TEMP1 = H1*W1*pinv(DELTA1)*H1';
TEMP1 = TEMP1+eye(size(TEMP1));
P1 = D1*TEMP1*D1;
% L1 = eye(size(P1))-P1;

% H2表示以mirna为节点的超图,nm*(nd+nm)
% H2 = [A',SM,interactionB];
% H2 = [A',SM];
H2 = A';
% H2(H2>=sim_thred)=1;
% W2 = diag(repelem([alpha/nd,(1-alpha)/nm],[nd,nm]));
% W2 = eye(nm+nd+nl)./(nm+nd+nl);
% W2 = eye(nm+nd)./(nm+nd);
W2 = eye(nd)./(nd);
D2 = sum(H2*diag(W2),2);
D2 = diag((D2+1).^(-1/2));
% D2 = diag(D2.^(-1/2));
DELTA2 = diag(sum(H2));
TEMP2 = H2*W2*pinv(DELTA2)*H2';
TEMP2 = TEMP2+eye(size(TEMP2));
P2 = D2*TEMP2*D2;
% L2 = eye(size(P2))-P2;

% W1 = ReLU(theta1.*(U-P1*U+(2*L1*L1-4*L1)*U));
W1 = LeakyReLU(theta1.*(P1*U),leaky);
% W2 = Sigmod(theta1.*(W1-P1*W1+(2*L1*L1-4*L1)*W1));
W2 = Sigmod(theta1.*(P1*W1));
% H1 = ReLU(theta2.*(V-P2*V+(2*L2*L2-4*L2)*V));
H1 = LeakyReLU(theta2.*(P2*V),leaky);
% H2 = Sigmod(theta2.*(H1-P2*H1+(2*L2*L2-4*L2)*H1));
H2 = Sigmod(theta2.*(P2*H1));
score = [U,W1,W2]*[V,H1,H2]';
% score = U*V';
% score = (U+W1+W2)*(V+H1+H2)';
end



