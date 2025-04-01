function x = cholesky(A, b)
    % cholesky - rezolvarea unui sistem format din matrici hermitiene
    % pozitiv definite folosind descompunerea Cholesky
    % A - matricea sistemului
    % b - termenii liberi
    R = desc_cholesky(A);
    y = (R.') \ b;
    x = R \ y;
end