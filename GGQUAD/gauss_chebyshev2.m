function [nodes, weights] = gauss_chebyshev2(n)
    %% GAUSS_CHEBYSHEV2 Computes the Gaussian quadrature nodes and weights
    % for Chebyshev polynomials of the second kind.
    %
    % Input:
    %   n - number of quadrature points
    %
    % Output:
    %   nodes   - nodes x_k (roots of U_n(x))
    %   weights - computed from eigenvectors of Jacobi matrix
    %%
    
    alpha = zeros(n, 1);
    beta = 0.5 * ones(n-1, 1);   % sqrt(1/4) for all k > 0

    % Construct Jacobi matrix
    J = diag(alpha) + diag(beta, 1) + diag(beta, -1);

    % Eigen decomposition
    [V, D] = eig(J);
    nodes = diag(D);
    [nodes, idx] = sort(nodes);
    V = V(:, idx);

    % Weights: beta0 = pi/2
    weights = (pi / 2) * (V(1, :)').^2;
end
