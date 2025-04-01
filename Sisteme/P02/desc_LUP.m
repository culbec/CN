function [L, U, P, x] = desc_LUP(A, b)
    % LUP - descompunrea solutiei sistemului pe baza descompunerii LUP
    % A   - matricea sistemului
    % b   - termenii liberi
    
    [L, U, P] = LUP(A);

    y = L \ (P * b);
    x = U \ y;
end