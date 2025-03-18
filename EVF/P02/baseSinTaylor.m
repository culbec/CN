function bsT = baseSinTaylor(x)
    % Computes sin(x) using Taylor's formula, using it's general term.
    % sin(x) = x - x^3/3! + x^5/5! - ... + (-1)^n * x^(2n+1)/(2n+1)!
    syms xi ni

    SinTerm_ = (-1)^ni * xi^(2*ni + 1) / factorial(2*ni + 1);
    SinTerm = matlabFunction(SinTerm_, 'Vars', [xi, ni]);

    % Computing general terms until digits are lost
    bsT = 0;
    term = x;
    n = 1;

    while bsT + term ~= bsT
        bsT = bsT + term;
        term = SinTerm(x, n);
        n = n + 1;
    end
end