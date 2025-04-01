function [L, U, P] = LUP(A)
    % LUP_help - helper descompunerea LUP a matricei A cu interschimbare fizica
    % A - matricea data spre descompunere
    % L - matricea multiplicarilor (triunghiulara inferior cu 1 pe diag
    % principala)
    % U - matricea finala (triunghiulara superior)
    % P - matricea de permutare (pivotarea)
    [m, n] = size(A);
    P = zeros(m, n);

    piv = (1:m)';
    for i=1:m-1
        % pozitia unde se face pivotarea, daca de pozitia unde se gaseste
        % valorea maxima in modul pe coloana
        [~, pivPos] = max(abs(A(i:m, i)));
        pivPos = pivPos+i-1;

        % interschimbare linie pivot cu linie daca sunt diferite
        if pivPos ~= i
           A([i, pivPos], :) = A([pivPos, i], :);
           piv([i, pivPos]) = piv([pivPos, i]);
        end

        % Complementul Schur
        % 1. Impartim elem. de sub pivot si elem. de langa pivot cu pivot
        % 2. Scadem din matricea ramas produsul (sub_pivot) *
        % (langa_pivot), dupa transformare
        row = i+1:m;
        A(row, i) = A(row, i) / A(i,i);
        A(row, row) = A(row, row) - A(row, i) * A(i, row);
    end

    % formam matricea de pivotare
    % 1 -> ordinea de pivotare a fiecare linii
    % 0 0 1 0
    % 0 1 0 0
    % 1 0 0 0
    % 0 0 0 1
    % ==========> 3 2 1 4
    for i=1:m
        P(i, piv(i)) = 1;
    end

    U = triu(A);
    L = tril(A, -1); % fara diag principala
    L = L + eye(m);  % unitarizam diag principala
end