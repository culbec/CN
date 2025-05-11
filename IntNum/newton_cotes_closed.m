function [w, x] = newton_cotes_closed(n, a, b)
    % NETWON_COTES_CLOSED - Generates Newton-Cotes closed quadrature weights
    %
    % Inputs:
    %   n - degree (number of intervals); number of nodes is n+1
    %   a, b - integration limits
    %
    % Outputs:
    %   w - weights for the quadrature
    %   x - equidistant nodes over [a, b]
    
    % Generate equally spaced nodes
    x = linspace(a, b, n+1);
    
    % Compute weights using Lagrange polynomials
    w = zeros(1, n+1);
    for i = 1:n+1
        % Construct Lagrange basis polynomial L_i
        Li = 1;
        for j = [1:i-1, i+1:n+1]
            Li = conv(Li, poly(x(j)));
            Li = Li / (x(i) - x(j));
        end
        % Integrate L_i over [a, b]
        int_Li = polyint(Li);
        w(i) = polyval(int_Li, b) - polyval(int_Li, a);
    end
end
