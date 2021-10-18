function [score]=RLSMDA(A,X,Y,deltm,deltd,w)
% A:interaction X:sd Y:sm
[nd,nm] = size(A);
Im = eye(nm);
Id = eye(nd);
Fm = Y*(Y+Im.*deltm)*A';
Fd = X*(X+Id.*deltd)*A;
score = Fm'.*w+Fd.*(1-w);
end