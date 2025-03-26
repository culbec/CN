function Vn = my_vandermonde_b(n)
    % my_vandermonde - creates a custom Vandermonde matrix with the
    % following term rule: t_k = 1/k, k in [1, n]
    % n - the number of columns
    % k - the number of rows/terms
    if n <= 0
        error("Numarul de coloane trebuie sa fie > 0. Coloane date: %d\n", n);
    end

    points = zeros(1, n);
    for i = 1: n
        points(i) = 1 / i;
    end

    Vn = zeros(n, n + 1);

    for i = 1:n
        for j = 0:n
            Vn(i, j + 1) = points(i)^j;
        end
    end
end