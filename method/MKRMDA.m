function [score]=MKRMDA(dir_mir,sm,sd1,sd2)
% 行为miRNA, N 
% 列为disease, M 
% N为行数  M为列数
[nd,nm] = size(dir_mir);
N=nm;
M=nd;
F1 = dir_mir';
F2 = sm;
F3 = sd1;
F4 = sd2;

GD = Gauss_D(F1,M);
GM = Gauss_M(F1,N);
KM0 = (F2+GM).*(1/2);
KD0 = (F3+F4+GD).*(1/3);
TKM0 = KM0';
TKD0 = KD0';
E = (KD0 + TKD0) ./ 2;
H = (KM0 + TKM0) ./ 2;
% 转置和的特征向量和特征值
[QD,TD]=eig(E);
[QM,TM]=eig(H);
TD = diag(TD)';
TM = diag(TM)';
% 只考虑KM的实部
TM=real(TM);
QM=real(QM);
lamda = 1.0;
C1 = kron(TD, TM);
C2 = 1./(C1+lamda);
C3 = C1.*C2;

TQM = QM';
TQD = QD';
C4 = TQM*F1;
C5 = C4*QD;
C6 = C5(:);
C7=C3.*C6';
C = zeros(N,M);
for z=1:M
    for k=1:N
        C(k,z)=C7(N*(z-1)+k);
    end
end

A1=QM*C;
A=A1*TQD;
A=real(A);
% a=A';

betaD0=[1./3,1./3,1./3]';
betaM0=[1./2,1./2]';
U=F1-A.*(lamda/2.0);
derta=0.5;
func0=@(beta)1./(2*lamda*N*M)*norm(U-beta(1).*(KM0*A*F3)+ beta(2).*(KM0*A*F4)+ beta(3).*(KM0*A*GD),'fro')+derta*norm(beta,2)^2;
res1 = fmincon(func0, betaD0, [], [], [1.0,1.0,1.0], 1, [0.0,0.0,0.0],[1.0,1.0,1.0]);
betaD0_new=res1;
KD1=betaD0_new(1)*F3+betaD0_new(2)*F4+betaD0_new(3)*GD;
TKM0 = KM0';
TKD1 = KD1';
E1 = (KD1 + TKD1) ./ 2;
H1 = (KM0 + TKM0) ./ 2;
[QD1,TD1]=eig(E1);
[QM1,TM1]=eig(H1);
TD1 = diag(TD1)';
TM1 = diag(TM1)';
A_New=AFinal_M(TM1,TD1,QM1,QD1,M,N,lamda,F1);
U_New=F1-A_New.*(lamda/2.0);

func1=@(beta)1./(2*lamda*N*M)*norm(U_New-beta(1)*F2*A_New*KD1+ beta(2)*GM*A_New*KD1,'fro')+derta*norm(beta,2)^2;
res2 = fmincon(func1, betaM0, [], [], [1.0,1.0], 1, [0.0,0.0],[1.0,1.0]);
betaM0_new=res2;
KM1=betaM0_new(1)*F2+betaM0_new(2)*GM;
TKM1 = KM1';
TKD1 = KD1';
E2 = (KD1 + TKD1) ./ 2;
H2 = (KM1 + TKM1) ./ 2;
[QD2,TD2]=eig(E2);
[QM2,TM2]=eig(H2);
TD2 = diag(TD2)';
TM2 = diag(TM2)';
A_New1=AFinal_M(TM2,TD2,QM2,QD2,M,N,lamda,F1);
U_New1=F1-A_New1.*(lamda/2);
score = real(A_New)';
end