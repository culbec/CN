function I = simpson_repeated(f, a, b, n)
    %% simpson_repeated - Computes the integral using the repeated Simpson's rule
    %
    % Inputs:
    %   f - function handle to the integrand
    %   a - lower limit of integration
    %   b - upper limit of integration
    %   n - number of subintervals (must be even)
    %
    % Output:
    %   I - approximate value of the integral
    %%
    
    % Check that n is even
    if mod(n, 2) ~= 0
        error('n must be even for Simpson''s rule.');
    end
    
    % Step size
    h = (b - a) / n;
    
    % Compute the x values
    x = a:h:b;
    
    % Apply Simpson's rule: f(x0) + f(xn) + 4*sum(odd indices) + 2*sum(even indices)
    sums_odd = sum(arrayfun(f, x(2:2:end-1)));
    sums_even = sum(arrayfun(f, x(3:2:end-2)));

    % f(0) + f(n-1)
    I = f(x(1)) + f(x(end));
    I = I + 4 * sums_odd;
    I = I + 2 * sums_even;
    I = I * (h / 3);
end