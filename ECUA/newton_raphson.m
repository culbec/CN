function [root, success, iter] = newton_raphson(f, df, p0, epsilon, N0)
    %% NEWTON_RAPHSON Solves the nonlinear equation f(x) = 0 using Newton-Raphson method
    %
    % Inputs:
    %   f       - function handle representing f(x)
    %   df      - function handle representing f'(x)
    %   p0      - initial approximation
    %   epsilon - error tolerance (stopping criterion)
    %   N0      - maximum number of iterations
    %
    % Outputs:
    %   root    - approximate root of the equation
    %   success - boolean flag indicating whether convergence was successful
    %   iter    - number of iterations performed
    %%

    % Initialize variables
    i = 1;                  % Step P1: iteration counter
    success = false;        % Will be set to true if convergence is successful

    while i <= N0           % Step P2: loop while iteration count is within limit
        % Step P3: Compute next approximation using Newton-Raphson formula
        p = p0 - f(p0) / df(p0);

        % Step P4: Check stopping criterion (absolute error)
        if abs(p - p0) < epsilon
            root = p;       % Return the current approximation
            success = true;
            iter = i;
            return;
        end

        % Step P5–P6: Update iteration count and approximation
        i = i + 1;
        p0 = p;
    end

    % Step P7: If max iterations reached without convergence
    root = p0;
    iter = i - 1;
    warning('Method failed: precision could not be achieved in %d iterations.', N0);
end
