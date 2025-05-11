function S = spline_periodic(x, y)
    %% SPLINE_PERIODIC Computes a periodic cubic spline interpolant.
    %
    %   S = SPLINE_PERIODIC(x, y) returns a function handle that evaluates
    %   the periodic spline interpolant through (x, y), assuming x(1) = a, x(end) = b.
    %
    %   Inputs:
    %       x - vector of nodes (x1 to xn), must be sorted and periodic
    %       y - function values at nodes, must satisfy y(1) = y(end)
    %
    %   Output:
    %       S - function handle for evaluating the periodic spline
    %%
    
    n = length(x) - 1;  % x has n+1 points, with y(1) == y(end)
    h = diff(x);        % Step sizes
    
    % Ensure y(1) == y(end) for periodicity
    if abs(y(1) - y(end)) > 1e-10
        error('For periodic spline, y(1) must equal y(end).');
    end
    
    % Construct RHS vector
    rhs = zeros(n,1);
    for i = 1:n
        ip1 = mod(i, n) + 1;  % i+1 with wrap-around
        im1 = mod(i-2, n) + 1; % i-1 with wrap-around
        rhs(i) = 6 * ( (y(ip1)-y(i))/h(mod(i,n)+1) - (y(i)-y(im1))/h(i) );
    end

    % Build cyclic tridiagonal matrix A
    A = zeros(n,n);
    for i = 1:n
        A(i,i) = 2*(h(i)+h(mod(i,n)+1));
        A(i,mod(i,n)+1) = h(mod(i,n)+1);
        A(i,mod(i-2,n)+1) = h(i);
    end

    % Adjust corners for periodicity
    A(1,n) = h(1);
    A(n,1) = h(n);

    % Solve the linear system for M (second derivatives)
    M = A \ rhs;

    % Append M(1) again at the end for cyclic use
    M = [M; M(1)];

    % Return evaluation function
    S = @(xx) evaluateSplineFromM(xx, x, y, M);
end