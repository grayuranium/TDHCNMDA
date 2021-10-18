function [GD]=Gauss_D(adj_matrix,M)
    GD = zeros(M);
    T = adj_matrix';
    rd = M*1.0./sum(sum(T.*T));
    for i=1:M
        for j=1:M
            GD(i,j) = exp(((T(i,:)-T(j,:))*(T(i,:)-T(j,:))')*-rd);
        end
    end
end