function [nodes, weights] = gauss_legendre(n)
    %% GAUSS_LEGENDRE Computes the Gaussian quadrature nodes and weights for Legendre polynomials.
    %
    % Input:
    %   n - number of quadrature points
    %
    % Output:
    %   nodes   - nodes x_k (roots of the Legendre polynomial of degree n)
    %   weights - corresponding weights A_k for the integration formula
    %
    % This function computes the nodes and weights using the symmetric tridiagonal
    % Jacobi matrix associated with the Legendre polynomials, whose recurrence
    % relation coefficients are:
    %   alpha_k = 0
    %   beta_0 = 2
    %   beta_k = k^2 / (4k^2 - 1), for k > 0
    %%
    
    % Construct Jacobi matrix for Legendre polynomials
    alpha = zeros(n, 1);  % All alpha_k = 0
    beta = zeros(n-1, 1); % beta_0 is not used in the matrix
    for k = 1:n-1
        beta(k) = k / sqrt(4*k^2 - 1);
    end

    % Create symmetric tridiagonal matrix
    J = diag(alpha) + diag(beta, 1) + diag(beta, -1);

    % Compute eigenvalues (nodes) and eigenvectors
    [V, D] = eig(J);
    nodes = diag(D);              % Nodes are eigenvalues
    [nodes, idx] = sort(nodes);   % Sort nodes in ascending order
    V = V(:, idx);                % Reorder eigenvectors accordingly

    % Compute weights
    weights = 2 * (V(1, :)').^2;

end
