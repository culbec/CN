function [roots_] = quad_roots(degree)
    % quad_roots - computes the roots of the polynom
    % (x-1)^2(x-2)^2...(x-n)^2 = 0
    % degree - the degree of the polynom
    if degree <= 0
        error("Gradul polinomului trebuie sa fie > 0. Grad dat: %d", degree)
    end
    
    a = @(n) n;
    b = @(n) -n * (n + 1);
    c = @(n) n * (n + 1) * (2*n + 1) / 6;

    roots_ = roots([a(degree), b(degree), c(degree)])';
end