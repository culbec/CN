% Problema 2

% a) ?

% b), c)
f = @(x) (exp(x) - x - 2);

[x1, val_f, i]=pb2_impl(f, 1) % Pentru punctul de start x0 = 1 o sa ni se returneze
% o radacina a ecuatiei
[x1, val_f, i]=pb2_impl(f,10) % Pentru acest punct de plecare, aproximarea Newton
% nu functioneaza
[x1, val_f, i]=pb2_impl(f,-10) % Iar pentru ultimul punct de plecare o sa se returneze
% o alta radacina a ecuatiei

