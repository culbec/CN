%Problema 2

% a)
% Pp ca exista 2 polinoame distincte p1 si p2 ce satisfac
% conditilie din enunt
% grad(p1), grad(p2) <= n =>
% grad(p1'), grad(p2') <= n - 1
% => grad(p1' - p2') <= n - 1
% => p1' - p2' are maxim n - 1 radacini
% Din enunt avem ca p1'(xi) = f'(xi) = p2'(xi)
% (p1' - p2')(xi) = 0, pentru xi, i = 1, 2, ..., n
% => p1' - p2' are n radacini
% contradictie => ca nu exista 2 polinoame distincte ce satisfac
% conditilie din enunt => unicitate (1)

% Daca formam un sistem ce contine doar p'(x) o sa avem urmatoarele ecuatii
% p'(xk) = cn-1 * xk^(n-1) + ... + c1 * 1, k = 1,n
% Acest sistem conduce la o matrice Vandermonde are determinant
% nenul => avem o singura solutie pentru sistemul nostru
% p(x) = an*x^n + ... + a0 => p'(x) = n * an * x^(n-1) + ... + a1 + 0
% Egalam coeficientii ai(i=1,n) cu ci(i=1,n)
% Dupa ce aflam coeficientii ai(i=1,n), folosim relatia p(x0)=f(x0)
% pentru a determina si ultimul coeficient a0
% => Problema este rezolvabila (2)
% Din (1) si (2) => problema are solutie unica

% b)
% Fie nodurile 0, 1, 2 si valorile y0=f(0), y1=f'(1), y2=f'(2)
% solutia o sa fie polinomul p(x) = ax^2 + bx + c
% p'(x) = 2ax + b
% Sistemul
% Ec 1: p(0) = f(0) => c = y0
% Ec 2: p'(1) = f'(1) => 2a + b = y1
% Ec 3: p'(2) = f'(2) => 4a + b = y2
% a = (y2 - y1) / 2
% b = 2y1 -y2
% c = y0
% Deci polinomul de interpolare este
% p(x) = (y2 - y1) / 2 * x^2 + (2y1 -y2) * x + y0
% Conform subpunctului a, polinomul obtinut este solutia unica
% a problemei de interpolare
