function kappa = my_cond2_mat(A)
    % my_cond_mat - calculeaza numarul de conditionare al matricii A in
    % raport cu norma euclidiana
    % A - matricea pentru care calculam numarul de conditionare

    % determinam valorile singulare ale matricii A, care sunt definite de:
    % G = A^T * A (matricea Gram)
    % lambda = eig(G) % eigenvalues
    % sing = sqrt(lambda) % valori singulare
    G = A' * A;
    lambda = eig(G);
    sing = sqrt(lambda);

    % kappa_2(A) = max(sing) / min(sing)
    kappa = max(sing) / min(sing);
end