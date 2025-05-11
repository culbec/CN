function I = rectangle_repeated(f, a, b, n)
    % rectangle_repeated - Computes the integral using the repeated midpoint (rectangle) rule
    %
    % Inputs:
    %   f - function handle to the integrand
    %   a - lower limit of integration
    %   b - upper limit of integration
    %   n - number of subintervals (must be >= 1)
    %
    % Output:
    %   I - approximate value of the integral
    
    % Step size
    h = (b - a) / n;
    
    % Compute midpoints of each subinterval
    midpoints = a + h * (0.5:1:n-0.5);
    
    % Apply midpoint rule: sum of f(midpoints) times step size
    I = h * sum(arrayfun(f, midpoints));
end
