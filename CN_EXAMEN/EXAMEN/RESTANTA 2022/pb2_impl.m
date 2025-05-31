function [x1,val_f,i]=pb2_impl(f, x0, err=1e-12, NrMaxIt=100)
  numarator_f = @(x) f(x) * f(x);
  df = @(x) f(x + f(x)) - f(x);
  [x1,val_f,i]=Newton(numarator_f, df, x0);
endfunction
