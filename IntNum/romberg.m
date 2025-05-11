function [R, approx] = romberg(f, a, b, max_level, tol)
    % ROMBER - Computes integral of f on [a,b] using Romberg integration
    %
    % Inputs:
    %   f          - function handle to integrate
    %   a, b       - limits of integration
    %   max_level  - maximum number of levels (rows of Romberg table)
    %   tol        - error tolerance for stopping criterion
    %
    % Outputs:
    %   R      - Romberg table (triangular matrix)
    %   approx - best approximation obtained
    
    % Preallocate Romberg table
    R = zeros(max_level, max_level);
    
    % Step 1: initial trapezoidal rule estimate
    h = b - a;
    R(1,1) = h / 2 * (f(a) + f(b));
    
    for k = 2:max_level
        % Halve the step size
        h = h / 2;
    
        % Trapezoidal sum: use previous sum and add midpoint evaluations
        n_intervals = 2^(k - 2);
        x_midpoints = a + h : 2*h : b - h;
        sum_midpoints = sum(arrayfun(f, x_midpoints));
    
        % Compute new trapezoidal estimate
        R(k,1) = 0.5 * R(k-1,1) + h * sum_midpoints;
    
        % Richardson extrapolation
        for j = 2:k
            R(k,j) = (4^(j-1) * R(k,j-1) - R(k-1,j-1)) / (4^(j-1) - 1);
        end
    
        % Stopping criterion based on last diagonal
        if abs(R(k,k) - R(k-1,k-1)) < tol
            approx = R(k,k);
            R = R(1:k, 1:k);  % trim unused rows
            return;
        end
    end
    
    % If max_level reached without satisfying tolerance
    approx = R(max_level, max_level);
end
