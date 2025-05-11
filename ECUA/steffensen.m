function [root, success, iter] = steffensen(g, p0, epsilon, N0)
    %% STEFFENSEN Solves p = g(p) using Steffensen's fixed-point acceleration method.
    %
    % Inputs:
    %   g       - function handle representing g(x), the iteration function
    %   p0      - initial guess
    %   epsilon - stopping criterion for convergence
    %   N0      - maximum number of iterations
    %
    % Outputs:
    %   root    - approximate solution
    %   success - boolean indicating if method converged
    %   iter    - number of iterations performed
    %%

    i = 1;              % Step P1: iteration counter
    success = false;    % Will be set to true if method converges

    while i <= N0       % Step P2: Iterate until max iterations
        % Step P3: Apply Steffensen formula
        p1 = g(p0);                  % First evaluation
        p2 = g(p1);                  % Second evaluation
        denominator = p2 - 2 * p1 + p0;

        if denominator == 0
            error('Denominator in Steffensen formula is zero; division undefined.');
        end

        p = p0 - ((p1 - p0)^2) / denominator;

        % Step P4: Check if convergence is reached
        if abs(p - p0) < epsilon
            root = p;
            iter = i;
            success = true;
            return;
        end

        % Step P5–P6: Update for next iteration
        i = i + 1;
        p0 = p;
    end

    % Step P7: If no convergence
    root = p0;
    iter = i - 1;
    warning('Method failed: precision could not be achieved in %d iterations.', N0);
end
