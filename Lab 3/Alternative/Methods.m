a = 0.5;
N1 = 10000;
h1 = 0.0005;
N2 = 5000;
h2 = 0.05;

q0 = [1-a 0];
p0 = [0 sqrt((1+a)/(1-a))];

% Forward Euler
figure(1)
subplot(2,2,1)
[qforw, pforw] = Forward(N1,h1,q0,p0);
plot(qforw(:,1),qforw(:,2))
figure(2)
subplot(2,2,1)
EnergyPlot(qforw,pforw,N1,h1);
 
% Backwards Euler
figure(1)
subplot(4,1,2)
[qback, pback] = Backward(N1,h1,q0,p0);
plot(qback(:,1),qback(:,2))
figure(2)
subplot(2,2,2)
EnergyPlot(qback,pback,N1,h1);
 
% Midpoint Euler
figure(1)
subplot(2,2,3)
[qmid, pmid] = Midpoint(N1,h1,q0,p0);
plot(qmid(:,1),qmid(:,2))
figure(2)
subplot(2,2,3)
EnergyPlot(qmid,pmid,N1,h1);
 
% Symplectic Euler
figure(1)
subplot(2,2,4)
[qsym, psym] = Symplectic(N1,h1,q0,p0);
plot(qsym(:,1),qsym(:,2))
figure(2)
subplot(2,2,4)
EnergyPlot(qsym,psym,N1,h1);

% ODE45
figure(3)
subplot(2,1,1)
[qode,pode] = ode45Kepler(N2,h2,q0,p0);
plot(qode(:,1),qode(:,2))
subplot(2,1,2)
EnergyPlot(qode,pode,N2,h2);