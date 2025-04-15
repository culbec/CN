function phi = chebyshev_I_base(n)
    phi = @(x) chebyshev_matrix(n, x);
end

function M = chebyshev_matrix(n, x)
    x = x';
    M = zeros(length(x), n + 1);
    for k = 0:n
        M(:, k + 1) = cos(k * acos(x));
    end
end