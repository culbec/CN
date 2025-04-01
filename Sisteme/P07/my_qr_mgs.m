function [Q, R, P] = my_qr_mgs(A)
    % desc_qr - descompunere QR a unei matrici prin metoda Gram-Schmidt
    % modificata, care ortogonalizeaza pe rand coloanele pentru a preveni
    % instabilitatea numerica
    % A - matricea de descompus
    [m, n] = size(A);
    P = eye(n);
    R = zeros(n, n);
    Q = zeros(m, n);

    for i=1:n
        % Pivotam pentru a preveni instabilitatea numerica
        [~, p] = max(vecnorm(A(:, i:n), 2, 1));
        p = p + i - 1;

        if p ~= i
            A(:, [i, p]) = A(:, [p, i]);
            P(:, [i, p]) = P(:, [p, i]);
        end

        % Aplicam metoda Gram-Schmidt modificata
        R(i, i) = norm(A(:, i));
        Q(:, i) = A(:, i) / R(i, i);

        for j=i+1:n
            R(i, j) = Q(:, i)' * A(:, j);
            A(:, j) = A(:, j) - Q(:, i) * R(i, j);
        end
    end
end