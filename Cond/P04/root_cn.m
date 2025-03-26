function cn = root_cn(coeffs, roots_poly)
    % root_cn - calculeaza numarul de conditionare al radacinilor unei
    % ecuatii algebrice date prin coeficientii sai
    %
    % coeffs        - coeficientii ecuatiei algebrice
    % roots_poly    - known roots of the polynom
    
    % radacinile polinomului
    if nargin < 2
        x = roots(coeffs);
    else
        x = roots_poly;
    end

    % calculam coeficientii derivatei polinomului
    dp = polyder(coeffs);
    
    % ### FORMULA: 1 / |(x * p'(x)) * p(x)|
    % coeffs = [1, a1, a2, ..., an]
    x_fdx   = max(abs(x .* polyval(dp, x)), eps);
    fx      = max(polyval(abs(coeffs(2:end)), abs(x)), eps);
    
    cn = 1 ./ (x_fdx .* fx);
end