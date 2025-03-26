function kappa = my_cond2_svd_mat(A)
    % my_cond_mat - calculeaza numarul de conditionare al matricii A in
    % raport cu norma euclidiana, folosind svd() pentru valorile singulare
    % A - matricea pentru care calculam numarul de conditionare
    
    % determinam valorile singulare
    sing = svd(A);

    % kappa_2(A) = max(sing) / min(sing)
    kappa = sing(1) / sing(end);
end