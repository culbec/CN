function S = spline_hermite(x, y, dy)
    %% SPLINE_HERMITE Constructs a Hermite cubic spline (C^1) interpolant.
    %
    %   S = SPLINE_HERMITE(x, y, dy) returns a function handle S(xx)
    %   that evaluates the Hermite spline interpolating function values y
    %   and derivatives dy at nodes x.
    %
    %   Inputs:
    %       x  - vector of interpolation nodes (length n)
    %       y  - function values at nodes x (same length)
    %       dy - derivatives at nodes x (same length)
    %
    %   Output:
    %       S  - function handle for evaluating the spline at arbitrary xx
    %%

    n = length(x) - 1;  % Number of intervals
    a = y(1:n);         % a_i = f(x_i)
    b = dy(1:n);        % b_i = f'(x_i)
    h = x(2:end) - x(1:end-1);

    % Preallocate c and d
    c = zeros(n, 1);
    d = zeros(n, 1);

    for i = 1:n
        % Hermite cubic coefficients based on function and derivative values
        c(i) = (3*(y(i+1) - y(i))/h(i)^2 - (2*dy(i) + dy(i+1))/h(i));
        d(i) = (-2*(y(i+1) - y(i))/h(i)^3 + (dy(i) + dy(i+1))/h(i)^2);
    end

    % Return evaluator function
    S = @(xx) evaluateHermite(xx, x, a, b, c, d);
end