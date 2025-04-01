function [solution] = gauss_part(A, b)
    % gauss_part - Eliminare gaussiana folosind pivotare partiala
    % A - matricea sistemului
    % b - matrice termenilor liberi
    A = [A b];
    [n, ~] = size(A);

    % Scop - transformarea matricii sistemului intr-o matrice superior
    % triunghiulara
    % 1. Interschimbare de linii;
    % 2. Inmultirea unei linii cu un intreg nenul;
    % 3. Adunarea la o linie multiplul altei linii;

    % Vector de pivoti pentru a tine evidenta permutarilor de linii
    pivot = 1:n;

    for i=1:n-1
        % Cautam valoarea maxima in modul pe coloana i, de la linia i in jos
        [maxVal, p] = max(abs(A(pivot(i:n), i)));
        p = p + i - 1; % Adjustam indexul pentru a lua in considerare offset-ul

        if maxVal <= eps
            error("Nu exista solutie unica!");
        end

        % Interschimbam pivotii daca sunt indecsi diferiti
        if p ~= i
            pivot([i, p]) = pivot([p, i]);
        end

        % Determinam valori noi pe liniile de sub pivot
        for j=i+1:n
            mji = A(pivot(j), i) / A(pivot(i), i);
            A(pivot(j), i+1:n+1) = A(pivot(j), i+1:n+1) - mji * A(pivot(i), i+1:n+1);
            % Setam explicit elementele sub pivot la zero pentru a evita erori de precizie
            A(pivot(j), i) = 0;
        end
    end

    if abs(A(pivot(n), n)) <= eps
        error("Nu exista solutie unica!");
    end

    % Substitutie inversa
    x = zeros(1, n);
    x(n) = A(pivot(n), n + 1) / A(pivot(n), n);
    
    for i=n-1:-1:1
        x(i) = (A(pivot(i), n + 1) - sum(A(pivot(i), i+1:n) .* x(i+1:n))) / A(pivot(i), i);
    end

    solution = x';
end