function [nodes, weights] = gauss_chebyshev1(n)
    %% GAUSS_CHEBYSHEV1 Computes the Gaussian quadrature nodes and weights
    % for Chebyshev polynomials of the first kind.
    %
    % Input:
    %   n - number of quadrature points
    %
    % Output:
    %   nodes   - nodes x_k (roots of T_n(x))
    %   weights - weights A_k = pi/n for all k
    %%
    
    k = 1:n;
    nodes = cos((2*k - 1) * pi / (2*n))';
    weights = pi / n * ones(n, 1);
end
