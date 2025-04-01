function systems = gen_sys_herm(n, num_systems)
    % gen_sys_herm - genereaza sisteme de matrici hermitiene pozitiv definite
    % n - numarul de termeni ai ecuatiei
    % num_systems - numarul de sisteme de generat
    systems = struct('A', {}, 'b', {});
    
    for i=1:num_systems
        A = randi(20, n, n);
        A = triu(A);
        A = A + A';
        b = A * ones(n, 1);

        systems(i).A = A;
        systems(i).b = b;
    end
end