function [output] = ReLU(A)
%RELU RELU����
%   �˴���ʾ��ϸ˵��
A(A<0)=0;
output=A;
end

