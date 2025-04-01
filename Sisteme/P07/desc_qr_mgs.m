function [Q, R, P, x] = desc_qr_mgs(A, b)
    % desc_qr - determina solutia sistemului folosind descompunerea QR cu
    % metoda Gram-Schmidt modificata
    % A - matricea sistemului
    % b - vectorul termenilor liberi

    [Q, R, P] = my_qr_mgs(A);
    x = R \ (Q' * b);
end