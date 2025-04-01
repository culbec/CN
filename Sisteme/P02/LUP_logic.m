function [L, U, P] = LUP_logic(A)
    % LUP_logic - LUP decomposition of matrix A with logical pivoting
    % A - input matrix to decompose
    % L - lower triangular matrix with 1s on the diagonal
    % U - upper triangular matrix
    % P - permutation matrix

    [m, n] = size(A);
    P = eye(m);
    L = zeros(m);
    U = A;       

    for i = 1:m-1
        % pozitia pivotului
        [~, pivPos] = max(abs(U(i:m, i)));
        pivPos = pivPos + i - 1;

        % schimbam logic daca e necesar
        if pivPos ~= i
            U([i, pivPos], :) = U([pivPos, i], :);
            P([i, pivPos], :) = P([pivPos, i], :);
            if i > 1
                L([i, pivPos], 1:i-1) = L([pivPos, i], 1:i-1);
            end
        end

        % procesul de eliminare
        for j = i+1:m
            % multiplicatorul va fi stocat in L
            L(j, i) = U(j, i) / U(i, i);

            % actualizam U pe baza multiplicatorului
            U(j, i:end) = U(j, i:end) - L(j, i) * U(i, i:end);
        end
    end

    L = L + eye(m); % 1 pe diagonala principala
end