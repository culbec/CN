function [sinNormal, sinPade] = padeSin(x, m, k)
    % Computes the Pade approximation of sin(x)
    % x -> the variable around which the approximation is made
    % m -> the degree of the numerator
    % k -> the degree of the denominator

    % reduce x to [0, pi/2]
    [reduced, quadrant] = reduceToFirstQuadrant(x);
    
    coeffsSin = zeros(1, m+k+2);
    coeffsSin(2) = 1; % 0 + x - x^3/3! + ...

    for i = 1:(m + k) / 2
        coeffsSin(2*i+1) = (-1)^i / factorial(2*i+1);
    end

    sinPade = pade_with_coeffs(reduced, coeffsSin, m, k);
    if quadrant == 3 || quadrant == 4
        sinPade = -1 * sinPade;
    end

    sinNormal = sin(x);
    fprintf("x = %.16e\n", x);

    fprintf("Normal sin(x)                            = %.16e\n", sinNormal);
    fprintf("sin(x) with Pade(%d, %d)                 = %.16e\n\n", m, k, sinPade);

    fprintf("========= ERRORS =========\n");
    fprintf("Normal vs. Pade(%d, %d) = %.16e\n\n", m, k, abs(sinNormal - sinPade));
end