function val = evaluateSpline(xx, x, y, b, c, d)
    %% EVALUATESPLINE Evaluates a standard cubic spline at given points.
    %
    %   val = EVALUATESPLINE(xx, x, y, b, c, d) returns the spline values at xx,
    %   using the cubic polynomial coefficients for each subinterval.
    %
    %   Inputs:
    %       xx - points at which to evaluate
    %       x, y - original knots and values
    %       b, c, d - spline coefficients
    %
    %   Output:
    %       val - vector of interpolated values
    %%

    n = length(x) - 1;
    val = zeros(size(xx));
    
    for i = 1:length(xx)
        xi = xx(i);
        j = find(xi >= x(1:end-1) & xi <= x(2:end), 1, 'last');
        if isempty(j), j = n; end
        dx = xi - x(j);
        val(i) = y(j) + b(j)*dx + c(j)*dx^2 + d(j)*dx^3;
    end
end