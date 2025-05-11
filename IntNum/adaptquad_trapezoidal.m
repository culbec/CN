function Q = adaptquad_trapezoidal(f, a, b, tol)
    % ADAPTQUAD_TRAPEZOIDAL - Computes the integral using adaptive trapezoidal rule
    %
    % Inputs:
    %   f   - function handle
    %   a   - start of interval
    %   b   - end of interval
    %   tol - absolute error tolerance
    %
    % Output:
    %   Q   - estimated integral value
    
    fa = f(a);
    fb = f(b);
    Q = quadstep_trapezoidal(f, a, b, tol, fa, fb);
end

function Q = quadstep_trapezoidal(f, a, b, tol, fa, fb)
    % quadstep_trapezoid - Recursive helper for adaptive trapezoid rule
    
    % Compute midpoint
    c = (a + b) / 2;
    fc = f(c);
    
    % Trapezoidal estimate on full interval
    Q1 = (b - a) * (fa + fb) / 2;
    
    % Trapezoidal estimate on two halves
    Q2 = (b - a) / 2 * (fa + 2*fc + fb) / 2;
    
    % Accept if error is below tolerance
    if abs(Q1 - Q2) < tol
        Q = Q2;
    else
        % Recursively apply on both halves
        Qa = quadstep_trapezoidal(f, a, c, tol, fa, fc);
        Qb = quadstep_trapezoidal(f, c, b, tol, fc, fb);
        Q = Qa + Qb;
    end
end
