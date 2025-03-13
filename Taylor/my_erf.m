function my_erf = my_erf(x_value, num_terms)
    % my_erf -> computes erf(x) using 'num_terms' terms

    syms f(x, n) x n
    assume(x > 0 & n >= 0);

    % general term of erf(x)
    f(x, n) = ((-1)^n * x^(2*n + 1)) / ((2*n + 1) * factorial(n));
    
    total_sum = 0;

    for k = 0:(num_terms - 1)
        result = subs(f(x, k), x, x_value);
        total_sum = total_sum + result;
    end

    my_erf = 2* total_sum / sqrt(pi);
end % my_erf