function Lm = LagrangeVectorized(xi, x, fx)
    % Fully vectorized Lagrange interpolation (no for loops)
    % xi - points to evaluate at
    % x  - interpolation nodes
    % fx - function values at nodes

    xi = xi(:);
    x  = x(:);
    fx = fx(:);
    n  = numel(x); m  = numel(xi);

    % 1) Compute P(xi) = prod_{j=1..n} (xi - x_j)  for each xi
    X_diff = xi * ones(1,n) -   ones(m,1) * x.';
    P_xi = prod(X_diff, 2);

    % 2) Compute denominator for each fundamental Lagrange polynomial
    X_denominator = x * ones(1,n) - ones(n,1) * x.';
    X_denominator(eye(n)==1) = 1; % avoiding division by 0
    denom = prod(X_denominator, 2);

    % 3) Build the m×n matrix of all fundamental Lagrange polynomial
    L_mat = P_xi ./ X_diff ./ denom.';

    % 4) Combine for the interpolant
    Lm = L_mat * fx;
end
