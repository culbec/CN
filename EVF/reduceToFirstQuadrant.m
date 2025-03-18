function [reduced, quadrant] = reduceToFirstQuadrant(x)
    % Reduces the value of x between [0, pi / 2], as the Taylor function
    % works better for trigonometric functions if the input is closer to 0
    two_pi = 2 * pi;

    % checking in which quadrant we are
    reduced = mod(x, two_pi);

    % Assuming quadrant is 1
    quadrant = 1;
    if reduced > 3 * pi / 2
        % Quadrant 4
        reduced = 2 * pi - reduced;
        quadrant = 4;
    elseif reduced > pi
        % Quadrant 3
        reduced = reduced - pi;
        quadrant = 3;
    elseif reduced > pi / 2
        % Quadrant 2
        reduced = pi - reduced;
        quadrant = 2;
    end
end