% INPUT:  Number of data points (N), total time (T), derivative of function that gives...
%         initial X-vector (dg), model function (f), precision of method (p)...
%         value of x0 (x0), formula for deciding initial vector X (init)
% OUTPUT: Updated X-vector

function [X1, alpha] = EulerLagrange (N,T,dg,f,p,x0)
  dt = T/N;
  X = [];             % Lagrar kapital, N+1 element
  Xu = [x0];          % Lagrar uppdatering av kapitalet, N+1 element
  L = zeros(1,N);   % Lagrar Lagrangemultiplikatorvärdena vid tiderna dt,..., Ndt. N element
  D = [];             % Lagrar förändring i kapitalvektorn
  maxit = 30;
  
  for i=1:N+1;
   X(i) = x0;        %Startgissningar för varje tid
  end

  for i=1:maxit;
    L(N) = dg(X(N));
    for m=N-1:-1:1
      L(m) = L(m+1) + dt*f(X(m))*L(m+1);
    end
    for n=1:N
      Xu(n+1) = Xu(n)+dt*(f(Xu(n))-1/(L(n)^(3/5)));
    end
    D(i,1) = norm(Xu-X);
    X = Xu;
    if D(i,1) < p
      break
    end
  end
  X1 = X';
  alpha = (L.^(-3/5))';
endfunction
