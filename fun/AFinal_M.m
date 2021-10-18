function [Anew]=AFinal_M(tM, tD, tQM, tQD,M,N,lamda,F1)
    tM = real(tM);
    tQM = real(tQM);
    C10 = kron(tD, tM);
    C20 = 1.0./(C10+lamda*1.0);
    C30 = C20.*C10;
    TtQM = tQM';
    TtQD = tQD';
    C40 = TtQM*F1;
    C50 = C40*tQD;
    C60 = C50(:);
    C70 = C30.*C60';
    C0 = zeros(N,M);
    for z=1:M
        for k=1:N
            C0(k,z) = C70(N*(z-1)+k);
        end
    end
    A00 = tQM*C0;
    Anew = A00*TtQD;
end