function [output] = RReLU(A)
%RELU RELU函数
%   此处显示详细说明
A(A<0)=-A(A<0).*rand(1);
output=A;
end

