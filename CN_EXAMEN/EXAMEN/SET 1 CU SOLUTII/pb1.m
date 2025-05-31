%Problema 1
syms t;
syms alfa;
syms u;

f = cos(t) / t ^ alfa;
f = subs(f, t, 3*t/2) * 3 / 2;% S.V. t = 3 * u / 2

% Acum suntem pe intervalul [0, PI]
% S.V. cos(3 * t / 2) = u => t = 2 * arcos(u) / 3
% Suntem pe intervalul [0, 1] - am pus un - in fata la subs
f = - subs(f, t, 2 * acos(t) / 3) * 2 / 3 * diff(acos(t))

w = 1 / sqrt(1 - t^2);

% Prespunem ca avem 2 noduri si o sa aplicam o cuadratura Gauss
% I = A1*f(x1) + A2*f(x2)

pi2 = orto_poly_sym(w, t, sym(0), sym(1), 2);
nodes = solve(pi2, t)

syms x;
coefs = gauss_coefs_sym(subs(w, t, x), sym(0), sym(1), nodes)

f = f / w;
I = coefs(1) * subs(f, t, nodes(1)) + coefs(2) * subs(f, t, nodes(2))

[x2, val_f, i] = secant(function_handle(I), 0, 1)
