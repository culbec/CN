function omega = find_omega(A)
    % find_omega - gaseste rata de relaxare optima folosind urmatoarea
    % formula:
    % wo = 2 / (1 + sqrt(1 - p^2)), unde p = raza spectrala a matricii
    % metodei Jacobi
    % A - matricea sistemului
    M = diag(diag(A));
    N = M - A;

    % Matricea metodei Jacobi
    T = M \ N;
    
    % Determinam raza spectrala
    eigenvals = eig(T);
    p =  max(abs(eigenvals));

    omega = 2 / (1 + sqrt(1 - p^2));
end