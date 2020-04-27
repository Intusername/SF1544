clf
clear all
close all
xmin = 50;
xmax = 2500;

% Data points
alpha = [150 200 300 500 1000 2000]';
U = [2 3 4 5 6 7]';
plot(alpha, U, '*')
hold on

% Model (5)
x = [alpha.^-1; 0];
y = [U.^-1; 1/8];
a = x\(y-1/8);

five = @(t) 1/(a/t+1/8);
fplot(five, [xmin xmax])

% Linearized least squares
% ln(8-U) = ln(a)+b*ln(alpha)
y = log(8-U);
x = log(alpha);
A = [ones(length(alpha),1) x];
lnab = A\y;

mkv = @(t) 8-exp(lnab(1))*t^(lnab(2));
fplot(mkv, [xmin xmax])

% Gauss-Newton
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

GN = @(t) 8 - ab(1)*t^ab(2)
fplot(GN, [xmin xmax])

% Polynomial regression
n = length(alpha);
p = polyfit(alpha,U,n);
t = linspace(xmin,xmax);
f = polyval(p,t);
plot(t,f)

legend('Data points', 'Least squares, (5)', 'Linearized least squares,(6)', 'Gauss-Newton, (6)', ...
'Polynomial regression,(6)', 'Location', 'southwest')
ylim([-5 10])