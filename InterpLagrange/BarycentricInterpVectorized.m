function Bm = BarycentricInterpVectorized(xi, x, fx, c)
    % BarycentricInterpVectorized - numerically stable interpolation
    % vectorized
    % xi - evaluation points
    % x  - nodes
    % fx - function values at nodes
    % c  - barycentric weights
    xi = xi(:);
    x  = x(:);
    fx = fx(:);
    c = c(:);
    n  = numel(x); m  = numel(xi);

    % matrix of differences: m×n
    Xdiff = xi * ones(1,n) - ones(m,1) * x.';

    % build the weighted Cauchy matrix: w_j / (xi - x_j)
    c_mat = ones(m,1) * c.' ./ Xdiff;

    % numerator and denominator
    num = c_mat * fx;
    den = sum(c_mat, 2);

    Bm = num ./ den;

    % handle exact matches xi == x(i) to avoid division by 0 or 0/0
    [tf, idx] = ismember(xi, x);
    Bm(tf)   = fx(idx(tf));
end
