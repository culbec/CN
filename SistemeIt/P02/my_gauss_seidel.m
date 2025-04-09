function [x, n_iter] = my_gauss_seidel(A, b, x0, tolerance, it_max)
    % my_gauss_seidel - Gauss-Seidel method for solving linear systems
    % A         - matricea sistemului
    % b         - vectorul termenilor liberi
    % x0        - solutia initiala. Default: zeros(size(b))
    % tolerance - eps, toleranta maxima admisa. Default: 1e-6
    % it_max    - numarul de iteratii maxime. Default: 50

    % Asignam parametrii default, daca e cazul
    if nargin < 5, it_max=50; end
    if nargin < 4, tolerance=1e-6; end
    if nargin < 3, x0 = zeros(size(b)); end

    [rows_, cols_] = size(A);

    % Verificam ca matricea A sa fie patratica si ca numarul termenilor
    % liberi sa match-uiasca numarul de randuri al matricii A
    if rows_ ~= cols_ || rows_ ~= length(b)
        error("Invalid parameters!")
    end

    M = tril(A);
    N = M - A;

    % Incepem calculul iterativ
    x = x0(:);
    conv_curbe = zeros(it_max, 1);
    for i=1:it_max
        x0 = x;
        % x_next = M \ (N * x_prev + b)
        x = M \ (N * x0 + b);

        rel_error = norm(x-x0, "inf") / norm(x, "inf");
        residual = norm(b - A * x, "inf");
        conv_curbe(i) = log(residual);
        % conditia de oprire: rel_error <= tolerance
        if rel_error <= tolerance
            figure;
            grid on;
            semilogy(1:i, conv_curbe(1:i), 'o-', 'LineWidth', 1.5, 'DisplayName', 'Gauss-Seidel Method - Convergence')
            xlabel('Iteration no.');
            ylabel('Logarithm of residual');
            legend('Location', 'best');

            n_iter = i;
            return;
        end
    end

    error("The solution did not converge in %d maximum interations!", it_max);
end