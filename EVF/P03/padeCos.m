function [cosNormal, cosPade] = padeCos(x, m, k)
    % Computes the Pade approximation of cos(x)
    % x -> the variable around which the approximation is made
    % m -> the degree of the numerator
    % k -> the degree of the denominator

    % reduce x to [0, pi/2]
    [reduced, quadrant] = reduceToFirstQuadrant(x);
    
    coeffsCos = zeros(1, m+k+2);
    coeffsCos(1) = 1; % 1 - x^2/2! + ..

    for i = 1:(m+k+1)/2
        coeffsCos(2*i) = (-1)^i / factorial(2*i);
    end

    cosPade = pade_with_coeffs(reduced, coeffsCos, m, k);

    if quadrant == 2 || quadrant == 3
        cosPade = -1 * cosPade;
    end

    cosNormal = cos(x);
    fprintf("x = %.16e\n", x);

    fprintf("Normal cox(x)                            = %.16e\n", cosNormal);
    fprintf("cos(x) with Pade(%d, %d)                 = %.16e\n\n", m, k, cosPade);

    fprintf("========= ERRORS =========\n");
    fprintf("Normal vs. Pade(%d, %d) = %.16e\n\n", m, k, abs(cosNormal - cosPade));
end