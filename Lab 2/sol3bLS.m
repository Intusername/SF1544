% Data points
alpha = [150 200 300 500 1000 2000]';
U = [2 3 4 5 6 7]';

% ln(8-U) = ln(a)+b*ln(alpha)
y = log(8-U);
x = log(alpha);
A = [ones(length(alpha),1) x];

% Linearized least squares
lnab = A\y;
mkv = @(t) lnab(1)+lnab(2)*t;

subplot(2,1,1)
plot(x, y, '*')
hold on
fplot(mkv, [min(x) max(x)])
legend('Data points', 'Linearized least squares regression')
title('Graph of linearized function with obtained values of a and b')

mkv2 = @(t) 8-exp(lnab(1))*t^(lnab(2));
subplot(2,1,2)
plot(alpha, U, '*')
hold on
fplot(mkv2, [min(alpha) max(alpha)])
legend('Data points', 'Linearized least squares regression', 'Location', 'southeast')
title('Graph of original function with obtained values of a and b')