function systems = gen_sys(n, num_systems)
    % gen_sys - genereaza sisteme cu nxn coeficienti si n termeni liberi
    % cu solutia (1,...,1)^T
    % n - numarul de termeni ai ecuatiei
    % num_systems - numarul de sisteme de generat
    systems = struct('A', {}, 'b', {});
    
    for i=1:num_systems
        while true
            A = randn(n);
            if abs(det(A)) > 1e-10
                break; % e destul de indepartat de 0
            end
        end
    
        x = ones(n, 1);
        b = A * x;
    
        systems(i).A = A;
        systems(i).b = b;
    end
end