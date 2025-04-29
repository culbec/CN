function Bm = BarycentricInterp(xi, x, fx, c)
    % BarycentricInterp - numerically stable interpolation
    % xi - evaluation points
    % x  - nodes
    % fx - function values at nodes
    % c  - barycentric weights

    n = length(x);
    Bm = zeros(size(xi));
    numerator = zeros(size(xi));
    denominator = zeros(size(xi));
    exact_match = false(size(xi));  % logical mask

    for i = 1:n
        xdiff = xi - x(i);
        match = (xdiff == 0);       % exact node match?
        exact_match = exact_match | match;
        xdiff(match) = 1;           % avoid division by zero

        w = c(i) ./ xdiff;
        numerator = numerator + w * fx(i);
        denominator = denominator + w;
        Bm(match) = fx(i);          % exact interpolation at node
    end

    Bm(~exact_match) = numerator(~exact_match) ./ denominator(~exact_match);
end
