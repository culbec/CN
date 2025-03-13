function improved_f_10 = improved_f_10(xi)
    result = 0.0;

    if abs(xi) < 1
        syms x k GENERAL_TERM(x, k)

        GENERAL_TERM(x, k) = x^(k-1) / factorial(k+1);
        MAX_TERMS = 10;

        for i=1:MAX_TERMS
            result = vpa(result + double(GENERAL_TERM(xi, i)));
        end
    else
        disp("|x| >= 1. Computing function normally...");
        result = double((exp(xi) - 1 - xi) / xi^2);  
    end

    fprintf("Result: %e", result);
    improved_f_10 = result;
end