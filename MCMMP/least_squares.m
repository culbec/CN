function answer = least_squares(x, y, base, points, weights)
    % least_squares - Least Squares approximation method, given training
    % data x and y.
    % x                     - features of the training data (input)
    % y                     - expected output of the training data
    % base                  - polynomial form of the data, given n features x
    % points                - points that we want to approximate using this method
    if nargin < 5
        weights = ones(size(x, 1), 1);
    end

    % We want to minimize: sum(i=1,n)[w_i * (y_i - f(x_i))^2
    % Therefore, we need to solve the following equation:
    % (phi * w * phi^T) * a = phi * w * y, where:
    % * phi is the matrix denoted by the value of the polynomial in each
    % point of the training data
    % * w is the diagonal matrix of the weights; in this way we can scale
    % the errors independently
    % * y is the output for each known feature of the training data
    % * a represents the new coefficients, determined by the link between x
    % and y
    
    % Training matrix: contains the value of the base polynom in all points
    % of x
    phi = base(x);

    % Test matrix: contains the value of the base polynom in all points of
    % the points values
    phi_approx = base(points);
    
    % Diagonal for scaling the errors between terms independently
    w = diag(weights);

    a = (phi' * w * phi) \ (phi' * w * y');
    
    % New coefficients * approximated points matrix
    answer = (phi_approx * a)';
end