function my_pade = my_pade(f, m, k, x)
    % my_pade -> computes Pade Approximation
    % f -> the function
    % m -> the degree of the denumerator
    % k -> the degree of the denominator
    % x -> variable of computation
    syms T_C 

    % c_k coefficients
    C = zeros(m+k+1, 1, 'sym');
    for p = 0:m+k
        C(p+1) = limit(diff(f, x, p), x, 0) / factorial(p);
    end

    % LHS of the system
    a = sym(zeros(k, k));
    for i = 1:k
        for j = 1:k
            idx = m + i - j + 1;
            if idx >= 1 && idx <= m + k + 1
                a(i,j) = C(idx);
            else
                a(i, j) = 0;
            end
        end
    end
    
    % RHS of the system
    b = sym(zeros(k, 1));
    for i = 1:k
        idx = m + i + 1;
        if idx <= m + k + 1
            b(i) = -C(idx);
        else
            b(i) = 0;
        end
    end
    
    % Solving B coefficients
    B = sym(zeros(k, 1));
    try
        B = linsolve(a, b);
    catch
        % left matrix division if linsolve fails
        B = a \ b;
    end
    B = [1; B]; % B[0] = 1
    
    % Computing A coefficients
    A = sym(zeros(m + 1, 1));
    for i = 0:m
        A(i + 1) = C(i + 1);
        for j = 1:min(i, k)
            A(i + 1) = A(i + 1) - B(j + 1) * C(i - j + 1);
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

    my_pade = simplifyFraction(vp / vq);
end % my_pade

