function S = spline_second_deriv(x, y, fppa, fppb)
    %% SPLINE_SECOND_DERIV Constructs a cubic spline with specified second derivatives.
    %
    %   S = SPLINE_SECOND_DERIV(x, y, fppa, fppb) returns a function handle S(xx)
    %   that evaluates the cubic spline where the second derivatives at the
    %   endpoints are known.
    %
    %   Inputs:
    %       x     - vector of knots
    %       y     - vector of function values at knots
    %       fppa  - second derivative at x(1)
    %       fppb  - second derivative at x(end)
    %
    %   Output:
    %       S     - function handle for evaluating the spline at given points xx
    %%
    
    % Number of intervals (subsplines) and step size
    n = length(x) - 1;
    step = diff(x);
    
    % Initialize the system matrix A and the right-hand side vector RHS
    A = zeros(n+1);
    rhs = zeros(n+1,1);
    
    % Apply the boundary condition at the left endpoint: M(1) = fppa
    A(1,1) = 1;
    rhs(1) = fppa;
    
    % Apply the boundary condition at the right endpoint: M(n+1) = fppb
    A(end,end) = 1;
    rhs(end) = fppb;
    
    % Build the tridiagonal system for the second derivatives at inner points
    for i = 2:n
        % Fill in the coefficients for M(i-1), M(i), M(i+1)
        A(i, i-1) = step(i-1);
        A(i, i) = 2*(step(i-1) + step(i));
        A(i, i+1) = step(i);

        % Compute the right-hand side based on function values
        rhs(i) = 6*((y(i+1) - y(i))/step(i) - (y(i) - y(i-1))/step(i-1));
    end
    
    % Solve the linear system to find the second derivatives at the kn
    M = A\rhs;

    % Return an evaluation function using the solved second derivatives
    S = @(xx) evaluateSplineFromM(xx, x, y, M);
end
