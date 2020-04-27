% Data points
x = [1/150 1/200 1/300 1/500 1/1000 1/2000 0]';
y = [1/2 1/3 1/4 1/5 1/6 1/7 1/8]';

% Create a function for U
a = x\(y-1/8);
U = @(alpha) 1/(a/alpha+1/8);

% Plot function and original data points
plot(x.^(-1),y.^(-1),'*')
hold on
fplot(U, [0 2000])
legend('Data points', 'Least squares', 'Location', 'southeast')