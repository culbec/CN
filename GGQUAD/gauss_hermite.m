function [nodes, weights] = gauss_hermite(n)
    %% GAUSS_HERMITE Computes Gaussian quadrature nodes and weights for Hermite polynomials
    %
    % Input:
    %   n - number of quadrature points
    %
    % Output:
    %   nodes, weights
    %%
    
    alpha = zeros(n, 1);
    beta = sqrt((1:n-1)' / 2);   % sqrt(k/2) for k=1 to n-1

    % Construct Jacobi matrix
    J = diag(alpha) + diag(beta, 1) + diag(beta, -1);

    % Compute eigenvalues and eigenvectors
    [V, D] = eig(J);
    nodes = diag(D);
    [nodes, idx] = sort(nodes);
    V = V(:, idx);

    weights = sqrt(pi) * (V(1, :)').^2;
end
