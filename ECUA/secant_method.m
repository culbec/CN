function [root, success, iter] = secant_method(f, p0, p1, epsilon, N0)
    %% SECANT_METHOD Solves the nonlinear equation f(x) = 0 using the Secant method.
    %
    % Inputs:
    %   f       - function handle representing f(x)
    %   p0      - first initial approximation
    %   p1      - second initial approximation
    %   epsilon - error tolerance (stopping criterion)
    %   N0      - maximum number of iterations
    %
    % Outputs:
    %   root    - approximate root of the equation
    %   success - boolean indicating convergence
    %   iter    - number of iterations performed
    %%

    % Step P1: Initialize iteration
    i = 2;
    q0 = f(p0);  % f(p0)
    q1 = f(p1);  % f(p1)
    success = false;

    while i <= N0  % Step P2: Repeat until max iterations
        % Step P3: Compute new approximation using secant formula
        if q1 - q0 == 0
            error('Division by zero in secant formula.');
        end
        p = p1 - q1 * (p1 - p0) / (q1 - q0);

        % Step P4: Check stopping condition (absolute error)
        if abs(p - p1) < epsilon
            root = p;
            iter = i;
            success = true;
            return;
        end

        % Step P5: Update iteration counter
        i = i + 1;

        % Step P6: Shift previous values
        p0 = p1;
        q0 = q1;
        p1 = p;
        q1 = f(p);
    end

    % Step P7: If no convergence after N0 iterations
    root = p;
    iter = i - 1;
    warning('Method failed: precision could not be achieved in %d iterations.', N0);
end
