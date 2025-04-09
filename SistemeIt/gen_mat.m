function [A, b] = gen_mat(n, density, min_val, max_val, dominance_factor)
    % gen_mat - genereaza matrici rare diagonal dominante, avand valori random
    % n                 - dimensiunea matricii
    % density           - cat de densa sa fie matricea
    % min_val           - valoarea minima a unui element
    % max_val           - valoarea maxima a unui element
    % dominance_factor  - factorul de dominare al diagonalei in raport cu
    % celelalte valori
    
    % factor de dominare
    if nargin < 5
        dominance_factor = 1.5;
    end

    % matricea rara
    A = sprand(n, n, density);
    A = full(A);
    A = A * (max_val - min_val) + min_val;

    % ne asiguram ca este diagonal dominanta
    for i = 1:n
        row_sum = sum(abs(A(i,:))) - abs(A(i, i));
        A(i,i) = dominance_factor * row_sum;
    end

    % solutia sistemului este [1, ..., n]^T
    x = (1:n)';
    b = A \ x;
end