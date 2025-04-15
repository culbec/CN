function phi = para_base(data)
    % ellipse_base - gives the polynom for the parabolic model
    % data      - X input features and y targets
    x = data(:, 1);
    y = data(:, 2);

    phi = [y.^2, ones(size(x))];
end