function phi = poly_base(degree)
    % Create a polynomial basis function up to specified degree
    % Returns a matrix where each column corresponds to a power of x: [1, x, x^2, ..., x^degree]
    phi = @(x) bsxfun(@power, x(:), 0:degree);
end