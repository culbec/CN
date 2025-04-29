function C1 = ChebInterp1(xi, fx, a, b)
    % ChebInterp1 - Chebyshev #1 nodes using barycentric interpolation
    % xi        - evaluation points
    % fx        - f in nodes
    % [a,b]     - interval

    n = length(fx) - 1;
    if nargin == 2
        a=-1;
        b=1;
    end

    c = sin((2*(0:n)'+1)*pi/(2*n+2)).*(-1).^((0:n)');
    x = sort(cos((2*(0:n)'+1)*pi/(2*n+2))*(b-a)/2+(a+b)/2);
    C1 = BarycentricInterp(xi, x, fx, c);
end