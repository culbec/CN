function val = evaluateHermite(xx, x, a, b, c, d)
    %% EVALUATEHERMITE Evaluates the Hermite spline at points xx.
    %%
    val = zeros(size(xx));
    n = length(a);

    for i = 1:length(xx)
        xi = xx(i);

        % Find interval index j such that x(j) <= xi <= x(j+1)
        j = find(xi >= x(1:end-1) & xi <= x(2:end), 1, 'last');
        if isempty(j), j = n; end

        dx = xi - x(j);
        val(i) = a(j) + b(j)*dx + c(j)*dx^2 + d(j)*dx^3;
    end
end