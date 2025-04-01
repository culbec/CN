function [Q, R] = my_qr(A)
    % desc_qr - descompunere QR a unei matrici prin metoda reflectiilor
    % Householder
    % Metoda prin reflectii Householder este mai stabila decat metoda
    % Gram-Schmidt, cea din urma fiind instabila daca vectorii x si e1 sunt
    % aproape ortogonali
    % A - matricea de descompus
    [m, n] = size(A);
    Q = eye(m);

    for i=1:n
        % Construim reflectia Householder
        x = A(i:m, i);
        
        e1 = zeros(length(x), 1);
        e1(1) = norm(x);

        v = x - e1;
        v = v / norm(v);

        % Aplicam reflectia Householder
        H = eye(m);
        H(i:m, i:m) = H(i:m, i:m) - 2 * (v * v');

        A = H * A;
        Q = Q * H;
    end

    R = triu(A);
    Q = Q'; % asiguram ortogonalitatea
end