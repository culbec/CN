function systems = gen_rand_sys(dim_, num_sys)
    % gen_rand_sys - genereaza 'num_sys' sisteme liniare de dimensiunea
    % dim_ x dim_
    % num_sys   - numarul de sisteme de generat, > 0
    % dim_      - magnitudinea sistemului
    
    % A         - matricea sistemului
    % b         - vectorul termenilor liberi
    if num_sys <= 0 || mod(num_sys, 1) ~= 0
        error("num_sys needs to be a positive integer! Provided: %f", num_sys);
    end

    if dim_ <= 0 || mod(dim_, 1) ~= 0
        error("dim_ needs to be a positive integer! Provided: %f", dim_);
    end
    
    systems = struct("A", {}, "b", {});

    for i=1:num_sys
        while true
            A = randn(dim_);
            if abs(det(A)) > 1e-10
                break; % e destul de indepartat de 0
            end
        end
        
        b = randn([dim_, 1]);
    
        systems(i).A = A;
        systems(i).b = b;
    end
end