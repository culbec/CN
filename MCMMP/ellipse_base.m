function phi = ellipse_base(data)
    % ellipse_base - gives the polynom for the elliptic model
    % data      - X input features and y targets
    x = data(:, 1);
    y = data(:, 2);

    phi = [y.^2, x.*y, x, y, ones(size(x))];
end