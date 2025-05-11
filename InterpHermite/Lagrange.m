function Lm = Lagrange(xi, x, fx)
    % Lagrange - classic Lagrange interpolation
    % xi    - evaluation points
    % x     - nodes
    % fx    - function values in nodes
    if nargin ~= 3
        error('Illegal number of arguments! Required: points, nodes, f(nodes)')
    end

    n = length(x);
    Lm = zeros(size(xi));
    
    for i = 1:n
        Li = ones(size(xi));
        for j = [1:i-1, i+1:n]
            Li = Li .* (xi - x(j)) / (x(i) - x(j));
        end
        Lm = Lm + Li * fx(i);
    end
end