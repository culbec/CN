function [Q, R, P, x] = desc_qr(A, b)
    % desc_qr - determina solutia sistemului folosind descompunerea QR cu
    % pivotare pe coloana
    % A - matricea sistemului
    % b - vectorul termenilor liberi

    [Q, R, P] = my_qr_pivot(A);
    x = R \ (Q' * b);
end