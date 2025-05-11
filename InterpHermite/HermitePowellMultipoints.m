function [Hs, Qs] = HermitePowellMultipoints(x, y, dy, xx)
    % HERMITEPOWELLMULTIPOINTS  Hermite interpolation at multiple points
    % Input:
    %   x   – 1×n vector of nodes
    %   y   – 1×n vector of f(x) at the nodes
    %   dy  – 1×n vector of f ′(x) at the nodes
    %   xx  – 1×m vector of query points
    % Output:
    %   Hs  – 1×m vector of Hermite‐interpolated values P(xx)
    %   Qs  – 1×m cell array of the 2n×2n divided‐difference tables

    m = numel(xx);
    Hs = zeros(size(xx));
    Qs = cell(1, m);

    for i = 1:m
        [Hs(i), Q] = HermitePowell(x, y, dy, xx(i));
        Qs{i}    = Q;
    end
end