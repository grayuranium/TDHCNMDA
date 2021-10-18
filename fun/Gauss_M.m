function [GM]=Gauss_M(adj_matrix,N)
    GM = zeros(N);
    T = adj_matrix;
    rm = N*1.0./sum(sum(T.*T));
    for i=1:N
        for j=1:N
            GM(i,j) = exp(((T(i,:)-T(j,:))*(T(i,:)-T(j,:))')*-rm);
        end
    end
end