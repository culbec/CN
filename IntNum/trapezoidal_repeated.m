function I = trapezoidal_repeated(f, a, b, n)
    %% trapezoidal_repeated - Computes the integral of a function using the repeated trapezoidal rule
    %
    % Inputs:
    %   f - function handle to the integrand
    %   a - lower limit of integration
    %   b - upper limit of integration
    %   n - number of subintervals (must be >= 1)
    %
    % Output:
    %   I - approximate value of the integral
    %%

    % Step size
    h = (b - a) / n;
    
    % Compute the x values
    x = a:h:b;
    
    % Apply trapezoidal rule: endpoints + 2 * sum of internal points
    sums = sum(arrayfun(f, x(2:end-1)));
    I = (h / 2) * (f(a) + 2 * sums + f(b));
end