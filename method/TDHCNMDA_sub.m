function [score] = TDHCNMDA_sub(A,t,theta1,theta2,leaky)
%SJHMDA Ӧ�ó�ͼ��ά���������й�����������
%   A����֪�������� SM����֪mirna�������� SD����֪������������ Ĭ��ʹ��sigmod���������
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


% ���Ȼ�ȡ��ʼU��V���󣬶�ԭʼ����������ȷֽ�
% [U,V]=fr(A);
% V = V';
[U,S,V]=svd(A,'econ');
S = S-t;
S(S<0)=0;
U = U*S^(1/2);
V = V*S^(1/2);

% H1��ʾ�Լ���Ϊ�ڵ�ĳ�ͼ,nd*(nm+nd)
% H1 = [A,SD,interactionC];
% H1 = [A,SD];
H1 = A;
% ���߿����Ż�
% H1(H1>=sim_thred)=1;
% Ȩ�ط�������Ż�
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

% H2��ʾ��mirnaΪ�ڵ�ĳ�ͼ,nm*(nd+nm)
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



