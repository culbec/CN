function C2 = ChebInterp2(xi, fx, a, b)
    % ChebInterp2 - Chebyshev #2 nodes using barycentric interpolation
    % xi        - evaluation points
    % fx        - f in nodes
    % [a,b]     - interval

    n = length(fx) - 1;
    if nargin == 2
        a=-1;
        b=1;
    end

    c = [1/2; ones(n-1,1); 1/2].*(-1).^((0:n)');
    x = sort(cos((0:n)'*pi/n))*(b-a)/2+(a+b)/2;
    C2 = BarycentricInterp(xi, x, fx, c);
end