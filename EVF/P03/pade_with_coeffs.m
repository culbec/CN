function padeApprox = pade_with_coeffs(x, coeffs, m, k)
    % computes the Pade approximation using the passed coefficients
    % x -> variable around the approximation is made
    % coeffs -> the coefficients used for the approximation
    % m -> the degree of the numerator
    % k -> the degree of the denominator

    if length(coeffs) < m+k+2
       error("Length of the passed coefficients needs to be at least: %d", m+k+2);
    end

    % Computing the matrix with the coefficients and the resulted vector
    a = zeros(k);
    C = zeros(k, 1);
    for i = 1:k
        for j = 1:k
            if m + i - j + 1 > 0 && m + i - j + 1 <= length(coeffs)
                a(i, j) = coeffs(m+i-j+1);
            end
        end
        if m + i + 1 <= length(coeffs)
            C(i) = -coeffs(m + i + 1);
        end
    end

    % Checking the condition of the matrix and applying a regularization
    % term to the diagonal of the matrix if necessary, for stabilizing the
    % system
    if rcond(a) < eps(1)*100
        a = a + eye(size(a)) * 1e-10;
    end

    % Solving the system A * B = C
    B = a \ C;
    B = [1; B]; % we are assuming B(1) = 1

    A = zeros(m + 1, 1);
    for i= 1:m+1
        for j =1:min(i, k +1) % i > k + 1 => B(j) = 0
            A(i) = A(i) + coeffs(i-j+1) * B(j);
        end
    end

    % p(m) and q(k)
    vp = 0;
    for i = 0:m
        vp = vp + A(i + 1) * x^i;
    end

    vq = 0;
    for i = 0:k
        vq = vq + B(i + 1) * x^i;
    end

    padeApprox = vp / vq;
end