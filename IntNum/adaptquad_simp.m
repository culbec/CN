function Q = adaptquad_simp(f, a, b, tol)
    %% ADAPTQUAD_SIMP - Computes the integral of f on [a, b] using
    % adaptive Simpson's rule with extrapolation.
    %
    % Inputs:
    %   f   - function handle to be integrated
    %   a   - lower limit of integration
    %   b   - upper limit of integration
    %   tol - desired absolute error tolerance
    %
    % Output:
    %   Q   - approximate value of the integral
    %%
    
    % Evaluating the functions at both endpoints and midpoints
    mid = (a+b) / 2;
    fa = f(a); fb = f(b); fmid = f(mid);

    Q = quadstep_simpson(f, a, b, tol, fa, fmid, fb);
end


function Q = quadstep_simpson(f, a, b, tol, fa, fc, fb)
    %% QUADSTEP_SIMPSON - Recursive helper for adaptive Simpson's rule
    %
    % Uses Simpson's rule on [a,b] and compares to the sum over two halves.
    %%

    % Compute half-width and center
    h = b - a;
    c = (a + b) / 2;
    
    % Compute additional function evaluations for subintervals
    d = (a + c) / 2;
    e = (c + b) / 2;
    fd = f(d);
    fe = f(e);
    
    % Simpson estimate on whole interval
    Q1 = h / 6 * (fa + 4*fc + fb);
    
    % Simpson estimate on two subintervals
    Q2 = h / 12 * (fa + 4*fd + 2*fc + 4*fe + fb);
    
    % If the difference is below tolerance, apply extrapolation
    if abs(Q1 - Q2) < tol
        Q = Q2 + (Q2 - Q1) / 15;
    else
        % Recursive subdivision of both halves
        Qa = quadstep_simpson(f, a, c, tol, fa, fd, fc);
        Qb = quadstep_simpson(f, c, b, tol, fc, fe, fb);
        Q = Qa + Qb;
    end
end