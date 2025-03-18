function bcT = baseCosTaylor(x)
    % Computes cos(x) using Taylor's formula, using it's general term.
    % cos(x) = 1 - x^2/2! + x^4/4! - ... + (-1)^n * x^(2n)/(2n)!
    syms xi ni

    CosTerm_ = (-1)^ni * xi^(2*ni) / factorial(2*ni);
    CosTerm = matlabFunction(CosTerm_, 'Vars', [xi, ni]);

    % Computing general terms until digits are lost
    bcT = 0;
    term = 1;
    n = 1;

    while bcT + term ~= bcT
        bcT = bcT + term;
        term = CosTerm(x, n);
        n = n + 1;
    end
end