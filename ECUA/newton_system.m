function [x, success, iter] = newton_system(F, J, x0, epsilon, Nmax)
    %% NEWTON_SYSTEM Solves a system of nonlinear equations F(x) = 0 using Newton's method
    %
    % Inputs:
    %   F       - function handle returning column vector F(x)
    %   J       - function handle returning Jacobian matrix J(x)
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
        % Evaluate function and Jacobian at current point
        Fx = F(x);
        Jx = J(x);

        % Solve the linear system J * delta = -F
        delta = -Jx \ Fx;

        % Update approximation
        x_new = x + delta;
        iter = iter + 1;

        % Check convergence
        if norm(delta) < epsilon
            x = x_new;
            success = true;
            return;
        end

        % Prepare for next iteration
        x = x_new;
    end

    warning("Newton method did not converge in %d iterations.", Nmax);
end
