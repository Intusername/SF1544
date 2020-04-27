% Data points
alpha = [150 200 300 500 1000 2000]';
U = [2 3 4 5 6 7]';
plot(alpha,U,'*')
hold on

% Gauss-Newton, r = U - 8 + a*alpha^b
precision = 1e-10;
max_it = 20;        % maximum number of iterations
res = [];
ab = [180 -0.5]';   % initial guess
for k=1:max_it
  D = [alpha.^ab(2) ab(1)*alpha.^(ab(2)).*log(alpha)];  % Jacobian matrix
  ab2 = ab - D\(U - 8 + ab(1)*alpha.^ab(2));
  res(k,1) = norm(ab-ab2);
  ab=ab2;
  if res(k,1) < precision;
    break
  end
end

res

GN = @(t) 8 - ab(1)*t^ab(2)
fplot(GN, [100 2100])
legend('Data points', 'Gauss-Newton regression', 'Location', 'southeast')



