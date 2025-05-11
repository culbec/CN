function S = spline_complete(x, y, fpa, fpb)
    %% SPLINE_COMPLETE Construct a complete (clamped) cubic spline
    % S = spline_complete(x, y, fpa, fpb) returns a function handle that is
    % useful for evaluating the cubic spline interpolation within a
    % division [a, b] (clamped boundary conditions - known first
    % derivatives at both endpoints)
    % 
    % Inputs:
    %   x   - vector of knots, sorted;
    %   y   - vector of evaluated knots;
    %   fpa - first derivative at a in [a, b];
    %   fpb - first derivative at b in [a, b];
    %
    % Output:
    %   S - function handle for evaluating the spline at given points
    %%
    
    % Number of intervals and step size
    n = length(x) - 1;
    step = diff(x);

    % RHS
    alpha = zeros(n+1, 1);
    alpha(1) = 3 * (y(2) - y(1)) / step(1) - 3 * fpa;
    alpha(n+1) = 3 * fpb - 3 * (y(n+1) - y(n)) / step(n);

    % Computing the interior of the RHS
    for i = 2:n
        alpha(i) = 3*(y(i+1)*step(i-1) - y(i)*(step(i)+step(i-1)) + y(i-1)*step(i)) / (step(i)*step(i-1));
    end

    % Solving the tridiagonal system using Thomas's algorithm
    l = zeros(n+1,1); mu = zeros(n+1,1); z = zeros(n+1,1);
    l(1) = 2*step(1); mu(1) = 0.5; z(1) = alpha(1)/l(1);
    
    for i = 2:n
        l(i) = 2*(x(i+1)-x(i-1)) - step(i-1)*mu(i-1);
        mu(i) = step(i)/l(i);
        z(i) = (alpha(i) - step(i-1)*z(i-1))/l(i);
    end
    
    l(n+1) = step(n)*(2 - mu(n));
    z(n+1) = (alpha(n+1) - step(n)*z(n))/l(n+1);
    
    % Back substitution for c, then compute b and d
    c = zeros(n+1,1); b = zeros(n,1); d = zeros(n,1);
    c(n+1) = z(n+1);
    
    for j = n:-1:1
        c(j) = z(j) - mu(j)*c(j+1);
        b(j) = (y(j+1) - y(j))/step(j) - step(j)*(c(j+1) + 2*c(j))/3;
        d(j) = (c(j+1) - c(j))/(3*step(j));
    end
    
    S = @(xx) evaluateSpline(xx, x, y, b, c, d);
end