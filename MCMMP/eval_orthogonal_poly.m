function p = eval_orthogonal_poly(x, a, b, c, c_rec)
    % eval_orthogoanl_poly - evaluates polynomials with orthogonal basis
    % using a Horner's like method
    % x             - the points where the evaluation is made
    % c             - coefficients for the basis expansion
    % a, b, c_rec   - recurrence coefficients for the basis;
    n = length(c) - 1;

    p_prev = 0;
    p_curr = 1;
    p = c(1) * p_curr;

    for k=1:n
        p_next = (a(k) * x + b(k)) * p_curr + c_rec(k) * p_prev;
        p = p + c(k+1) * p_next;

        p_prev = p_curr;
        p_curr = p_next;
    end
end