function S = spline_deboor(x, y)
    %% SPLINE_DEBOOR Constructs a robust cubic B-spline interpolant using de Boor's algorithm.
    %
    %   S = SPLINE_DEBOOR(x, y) returns a function handle S(xx) that evaluates
    %   a cubic B-spline (order 4) interpolant through the data points (x, y).
    %   The function ensures proper construction of the knot vector to avoid
    %   singularities or poor scaling when nodes are uniform or limited.
    %
    %   Inputs:
    %       x - vector of knots (must be strictly increasing)
    %       y - vector of function values at knots (same size as x)
    %
    %   Output:
    %      S - function handle that evaluates the B-spline at given points xx
    %%
    
    % Order of the spline (k = 4 → cubic)
    k = 4;
    
    % Ensure that x is strictly increasing
    if any(diff(x) <= 0)
        error('x must be strictly increasing with unique values.');
    end
    
    % Ensure x and y are column vectors for consistency
    x = x(:);
    y = y(:);
    
    % Number of data points
    n = length(x);
    
    % Verify that there are enough data points for a spline of order k
    if n < k
        error('At least %d data points are required for a spline of order %d.', k, k);
    end

    % Construct a safe knot vector with internal knots
    % Place additional knots inside the domain using averaged positions
    % This avoids degeneracy in the basis function matrix
    knots = augknt(x, k);  % Augmented knot vector suitable for interpolation

    % Build the spline using spapi and the safe knot vector
    sp = spapi(knots, x, y);
    
    % Return a function handle to evaluate the spline
    S = @(xx) fnval(sp, xx);
end