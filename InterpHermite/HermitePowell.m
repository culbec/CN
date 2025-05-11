function [H, Q] = HermitePowell(x, y, dy, xx)
    % HERMITEPOWELL Hermite interpolation using Powell's divided-difference
    % method
    % Input:
    % x     - the nodes for interpolation
    % y     - the values of the function in the interpolation nodes
    % dy    - the derivatives of values in the interpolation nodes
    % xx    - evaluation points
    % Output:
    % H     - interpolation result
    % Q     - divided differences table

    if any(diff(x) == 0)
        error("Interpolation nodes must be distinct!")
    end

    n = length(x);
    m = 2 * n;

    z = zeros(1, m);
    Q = zeros(m, m); % divided differences

    % Doubled nodes and initial divided differences
    for i=1:n
        z(2*i-1) = x(i);
        z(2*i) = x(i);


        Q(2*i-1, 1) = y(i);
        Q(2*i, 1) = y(i);
        Q(2*i, 2) = dy(i);

        if i > 1
            Q(2*i-1, 2) = (Q(2*i-1, 1) - Q(2*i-2, 1)) / (z(2*i-1) - z(2*i-2));
        end
    end

    % Higher-order divided differences
    for j=3:m
        for i=j:m
            Q(i,j) = (Q(i,j-1) - Q(i-1,j-1)) / (z(i) - z(i-j+1));
        end
    end

    % Evaluating the interpolation polynomial in Newton form
    H = zeros(size(xx));
    for i=1:numel(xx)
        xi = xx(i);
        H(i) = Q(1,1);

        curr = 1;
        for j=2:m
            curr = curr * (xi - z(j-1));
            H(i) = H(i) + Q(j,j) * curr;
        end
    end
end