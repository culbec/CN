function val = evaluateSplineFromM(xx, x, y, M)
    %% EVALUATESPLINEFROMM Evaluates a cubic spline using second derivatives.
    %
    %   val = EVALUATESPLINEFROMM(xx, x, y, M) evaluates the cubic spline
    %   at points xx using precomputed second derivatives M.
    %
    %   Inputs:
    %       xx - evaluation points
    %       x, y - knots and values
    %       M - second derivative values at knots
    %
    %   Output:
    %       val - interpolated values
    %%

    n = length(x) - 1;
    h = diff(x);
    val = zeros(size(xx));
    
    for i = 1:length(xx)
        xi = xx(i);
        j = find(xi >= x(1:end-1) & xi <= x(2:end), 1, 'last');
        if isempty(j), j = n; end
        dx = xi - x(j);
        val(i) = ((M(j+1)/(6*h(j)))*dx^3) ...
               + ((M(j)/(6*h(j)))*(h(j)-dx)^3) ...
               + ((y(j+1)/h(j) - M(j+1)*h(j)/6)*dx) ...
               + ((y(j)/h(j) - M(j)*h(j)/6)*(h(j)-dx));
    end
end