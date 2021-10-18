function [output] = ReLU(A)
%RELU RELU函数
%   此处显示详细说明
A(A<0)=0;
output=A;
end

