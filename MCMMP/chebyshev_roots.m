function roots = chebyshev_roots(n)
    k = 1:(n+1);
    roots = cos((2 * k - 1) * pi / (2 * (n+1)));
end