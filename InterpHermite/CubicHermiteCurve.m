function [x, y] = CubicHermiteCurve(p0, p1, m0, m1, t)
    % CUBICHERMITECURVE Parametric cubic Hermite between two given points
    % Input:
    % p0, p1    - the points of the curve
    % m0, m1    - the tangents in the points
    % t         - parameter vector in [0, 1]
    h00 =  2*t.^3 - 3*t.^2 + 1;
    h10 =      t.^3 - 2*t.^2 + t;
    h01 = -2*t.^3 + 3*t.^2;
    h11 =      t.^3 -     t.^2;

    x = h00*p0(1) + h10*m0(1) + h01*p1(1) + h11*m1(1);
    y = h00*p0(2) + h10*m0(2) + h01*p1(2) + h11*m1(2);
end
