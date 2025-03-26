function Hn = my_hilbert(n)
    % my_hilbert - calculeaza matricea Hilbert de dimensiune n
    % n - dimensiunea matricii
    % ERROR - n <= 0
    if n <= 0
        error("Dimensiunea matricii trebuie sa fie > 0. Dimensiune data: %d\n", n);
    end

    % formam matricea
    Hn = zeros(n);

    for i = 1:n
        for j = 1:n
            Hn(i, j) = 1 / (i + j - 1);
        end
    end
end