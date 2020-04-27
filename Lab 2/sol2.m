% Data points 
x = [0 0.5 1 1.5 2 2.99 3]';
y = [0 0.52 1.09 1.75 2.45 3.5 4]';
plot(x,y,'o')
hold on

% Least squares
A1 = [x, x.^2];
ab=A1\y;
mkv = @(t) ab(1)*t + ab(2)*t^2;
fplot(mkv,[0 3])

% Polynomial interpolation
n = length(x)-1;
p = polyfit(x,y,n);
t = linspace(0,3);
f = polyval(p,t);
plot(t,f)

legend('Data points', 'Least squares', 'Polynomial interpolation', 'Location', 'southwest')