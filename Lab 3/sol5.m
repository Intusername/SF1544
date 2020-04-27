% Initial values 
a=0.5;
tspan=[0 10000];
y0=[0; sqrt((1+a)/(1-a)); 1-a; 0];

% Solving ODE
odefun = @(t,y0) [fq(y0(3),y0(4));...
    fq(y0(4),y0(3)); y0(1);y0(2)]

% Plotting
[t,y]=ode45(odefun,tspan,y0);
plot(y(:,3),y(:,4));
axis equal 

% Kepler system 
function output = fq(c,d)
    output = -c/(((c^2)+(d^2))^(3/2)); 
end