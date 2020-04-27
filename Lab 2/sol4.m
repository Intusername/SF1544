
N = 60;
T = 1;
dg = @(x) 1/sqrt(x);
p = 1e-6;
x0 = 1;
X = [];
alpha = [];

f1 = @(x) x;
[X(:,1), alpha(:,1)] = EulerLagrange(N,T,dg,f1,p,x0);
f2 = @(x) x + x^2/10;
[X(:,2), alpha(:,2)] = EulerLagrange(N,T,dg,f2,p,x0);
f3 = @(x) 1.070894*x + 0.061849*x^2;
[X(:,3), alpha(:,3)] = EulerLagrange(N,T,dg,f3,p,x0);

f = ['f1'; 'f2'; 'f3'];

t = linspace(0,T,N);
for i=1:3
    subplot(2,3,i)
    plot(t,X(2:N+1,i))
    hold on
    plot(t,alpha(:,i))
    legend('X','alpha', 'Location', 'southeast')
    title(f(i,:));
 end

annotation('textbox',[0.6 0 .1 .2],'String',...
    'f1=x, f2=x+x^2/10, f3=1.070894x+ 0.061849x^2','EdgeColor','none')

subplot(2,3,4)
for i = 1:3
    graph(t, X(2:N+1,i), 0,0, 'X')
end 

subplot(2,3,5)
for i = 1:3
  graph(t, alpha(:,i),0,0, 'Alpha')
end 

subplot(2,3,6)
for i = 1:3
    graph(t, X(2:N+1,i), 1, alpha(:,i), 'X and Alpha')
end 

function g = graph(t, p, q,b, text)
  plot(t,p)
  hold on 
  if q == 1
    plot(t,b)
  end
  legend('f1','f2','f3', 'Location', 'northwest')
  title(text)
end

function [X1, alpha] = EulerLagrange (N,T,dg,f,p,x0)
  dt = T/N;
  X = [];         % Storing value for capital, N+1th element
  Xu = [x0];      % Storing updated capital, N+1th element
  L = zeros(1,N); % Storing multiplicator values
                  % for times dt,..., Ndt. Nth element
  D = [];         % Storing alteration of capital vector 
  maxit = 30;
  
  for i=1:N+1;
   X(i) = x0;        % Initial guess for every time frame
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
end
