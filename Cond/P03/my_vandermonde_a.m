function Vn = my_vandermonde_a(n, k)
    % my_vandermonde - creates a custom Vandermonde matrix with the
    % following term rule: t_k = -1 + k * 2/n
    % n - the number of columns
    % k - the number of rows/terms
    if n <= 0
        error("Numarul de coloane trebuie sa fie > 0. Coloane date: %d\n", n);
    end

    if k <= 0
        error("Numarul de termeni trebuie sa fie > 0. Numar de termeni dat: %d\n", k);
    end

    % ca input: k puncte echidistante in [-1, 1]
    points = linspace(-1, 1, k);
    for i = 1: k
        points(i) = -1 + points(i) * 2 / n;
    end

    Vn = zeros(k, n + 1);

    for i = 1:k
        for j = 0:n
            Vn(i, j + 1) = points(i)^j;
        end
    end
end