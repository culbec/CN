function [nodes, weights] = gauss_laguerre(n, mu)
    %% GAUSS_LAGUERRE Gaussian quadrature for Laguerre polynomials L_n^(mu)
    %
    % Input:
    %   n  - number of points
    %   mu - weight exponent parameter (mu > -1)
    %
    % Output:
    %   nodes, weights
    %%
    alpha = zeros(n, 1);
    beta = zeros(n-1, 1);

    for k = 0:n-1
        alpha(k+1) = 2*k + 1 + mu;
    end

    for k = 1:n-1
        beta(k) = sqrt(k * (k + mu));
    end

    % Construct Jacobi matrix
    J = diag(alpha) + diag(beta, 1) + diag(beta, -1);

    % Compute eigenvalues and eigenvectors
    [V, D] = eig(J);
    nodes = diag(D);
    [nodes, idx] = sort(nodes);
    V = V(:, idx);

    % Compute weights
    weights = gamma(mu + 1) * (V(1, :)').^2;
end
