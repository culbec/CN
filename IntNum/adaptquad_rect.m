function Q = adaptquad_rect(f, a, b, tol)
    % ADAPTQUAD_RECT - Computes the integral using adaptive midpoint rule
    %
    % Inputs:
    %   f   - function handle
    %   a   - interval start
    %   b   - interval end
    %   tol - tolerance for absolute error
    %
    % Output:
    %   Q   - estimated integral value
    
    % Evaluate function at midpoint
    c = (a + b) / 2;
    fc = f(c);
    Q = quadstep_rect(f, a, b, tol, fc);
end

function Q = quadstep_rect(f, a, b, tol, fc)
    % quadstep_midpoint - Recursive helper for adaptive midpoint rule
    
    % Compute midpoint estimate over full interval
    h = b - a;
    Q1 = h * fc;
    
    % Compute midpoints of left and right halves
    d = (a + (a + b) / 2) / 2;
    e = ((a + b) / 2 + b) / 2;
    
    fd = f(d);
    fe = f(e);
    
    % Estimate on both halves
    Q2 = (h / 2) * (fd + fe);
    
    % Accept approximation if difference is small
    if abs(Q1 - Q2) < tol
        Q = Q2;
    else
        % Recurse on left and right halves
        Qa = quadstep_rect(f, a, (a + b) / 2, tol, fd);
        Qb = quadstep_rect(f, (a + b) / 2, b, tol, fe);
        Q = Qa + Qb;
    end
end
