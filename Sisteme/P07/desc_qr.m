function [Q, R, x] = desc_qr(A, b)
    % desc_qr - determina solutia sistemului folosind descompunerea QR
    % A - matricea sistemului
    % b - vectorul termenilor liberi

    [Q, R] = my_qr(A);
    x = R \ (Q' * b);
end