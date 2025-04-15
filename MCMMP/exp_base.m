function phi = exp_base(x)
    % y(x) = K * e^lambda*x => ln(y) = ln(K) * lambda * t
    % ln(y) = a + b * t
    x = x(:);
    phi = [ones(size(x)), x];
end