function [x, success, iter] = successive_approximations_system(phi, x0, epsilon, Nmax)
    %% SUCCESSIVE_APPROXIMATIONS_SYSTEM Solves x = phi(x) using fixed-point iteration
    %
    % Inputs:
    %   phi     - function handle returning updated x (vector)
    %   x0      - initial column vector guess
    %   epsilon - tolerance for stopping criterion
    %   Nmax    - maximum number of iterations
    %
    % Outputs:
    %   x       - approximate solution vector
    %   success - true if convergence occurred
    %   iter    - number of iterations performed
    %%

    x = x0;
    iter = 0;
    success = false;

    while iter < Nmax
        x_new = phi(x);
        iter = iter + 1;

        if norm(x_new - x) < epsilon
            x = x_new;
            success = true;
            return;
        end

        x = x_new;
    end

    warning("Successive approximation did not converge in %d iterations.", Nmax);
end
