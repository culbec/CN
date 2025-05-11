function [nodes, weights] = gauss_jacobi(n, alpha, beta)
    %% GAUSS_JACOBI Computes Gaussian quadrature nodes and weights for Jacobi polynomials
    %
    % Input:
    %   n     - number of quadrature points
    %   alpha - exponent for (1 - x)^alpha in the weight function
    %   beta  - exponent for (1 + x)^beta  in the weight function
    %
    % Output:
    %   nodes   - Gauss nodes (roots of Jacobi polynomial)
    %   weights - corresponding weights for the quadrature rule
    %%

    a = alpha;
    b = beta;
    N = n;

    % Diagonal (alpha_k)
    j = (1:N)';
    ab = 2*j + a + b;

    alphak = (b^2 - a^2) ./ (ab .* (ab + 2));

    % Off-diagonal (sqrt(beta_k))
    j = (1:N-1)';
    ab = 2*j + a + b;
    betak = 4*j.*(j+a).*(j+b).*(j+a+b) ./ ( (ab.^2) .* (ab+1) .* (ab-1) );

    % Form Jacobi matrix
    J = diag(alphak) + diag(sqrt(betak), 1) + diag(sqrt(betak), -1);

    % Eigen-decomposition
    [V, D] = eig(J);
    [nodes, idx] = sort(diag(D));
    V = V(:, idx);

    % First row of eigenvectors -> weights
    % beta0 from theory:
    beta0 = 2^(a + b + 1) * gamma(a + 1) * gamma(b + 1) / gamma(a + b + 2);
    weights = beta0 * (V(1, :)').^2;
end
