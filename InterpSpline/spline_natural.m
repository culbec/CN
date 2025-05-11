function S = spline_natural(x, y)
    %% SPLINE_NATURAL Constructs a natural cubic spline (with zero second derivatives at endpoints).
    %
    %   S = SPLINE_NATURAL(x, y) returns a function handle S(xx) that evaluates
    %   the natural cubic spline interpolation through the given data points.
    %
    %   Inputs:
    %       x - vector of knots (must be strictly increasing)
    %       y - vector of corresponding function values
    %
    %   Output:
    %       S - function handle that evaluates the spline at given points xx
    %%

    % Number of spline intervals (n subintervals for n+1 points) and step
    % size
    n = length(x) - 1;
    step = diff(x);

    % Initialize the linear system matrix A and the right-hand side rhs
    % This system solves for the second derivatives M(2), ..., M(n)
    A = zeros(n-1, n-1);
    rhs = zeros(n-1, 1);

    % Build the tridiagonal system based on the spline continuity conditions
    for i = 1:n-1
        % Diagonal entry: 2(h_i + h_{i+1})
        A(i, i) = 2 * (step(i) + step(i+1));
        
        % Lower diagonal (if applicable): h_i
        if i > 1
            A(i, i-1) = step(i);
        end
        
        % Upper diagonal (if applicable): h_{i+1}
        if i < n-1
            A(i, i+1) = step(i+1);
        end
        
        % RHS value based on divided differences of adjacent intervals
        rhs(i) = 6 * ( (y(i+2) - y(i+1)) / step(i+1) - (y(i+1) - y(i)) / step(i) );
    end

    % Solve the linear system for the inner second derivatives M(2)...M(n)
    M_inner = A \ rhs;

    % Assemble the full vector of second derivatives M with boundary values set to 0
    M = [0; M_inner; 0];

    % Return an evaluation function using the computed second derivatives
    S = @(xx) evaluateSplineFromM(xx, x, y, M);
end
