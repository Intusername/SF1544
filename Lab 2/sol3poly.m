clf
clear all
close all

% Data points
alpha = [150 200 300 500 1000 2000]';
U = [2 3 4 5 6 7]';

% Polynomial interpolation
n = length(alpha)-1;
p = polyfit(alpha,U,n);
t = linspace(0,3000);
f = polyval(p,t);
plot(alpha,U,'*')
hold on
plot(t,f)
legend('Data points', 'Polynomial regresion', 'Location', 'northwest')