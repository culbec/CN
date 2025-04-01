function [solution] = gauss_scal(A, b)
    % gauss_part - Eliminare gaussiana folosind pivot scalat pe coloana
    % A - matricea sistemului
    % b - matrice termenilor liberi
    A = [A b];
    [n, ~] = size(A);

    % Factorii de scara pentru fiecare linie
    % Maximul in modul de pe fiecare linie
    s = max(abs(A(:, 1:n)), [], 2)';
    pivot = 1:n;

    for i=1:n-1
        [u, p] = max(abs(A(i:n, i)) ./ s(i:n));
        p = p + i - 1;

        if u <= eps
            error("Nu exista solutie unica!");
        end

        % Interschimbam liniile daca sunt indecsi diferiti
        if p ~= i
            pivot([i, p]) = pivot([p, i]);
        end
        
        % determinam valori noi pe liniile de sub pivot
        for j=i+1:n
            mji = A(pivot(j),i)/A(pivot(i),i);
            A(pivot(j), i+1:n+1) = A(pivot(j), i+1:n+1) - mji * A(pivot(i), i+1:n+1);
        end
    end

    % Substitutie inversa
    x = zeros(1,n);
    x(n) = A(pivot(n), n + 1) / A(pivot(n), n);
    
    for i=n-1:-1:1
        x(i) = (A(pivot(i), n + 1) - sum(A(pivot(i), i+1:n) .* x(i+1:n))) / A(pivot(i),i);
    end

    solution = x';
end