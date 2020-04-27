h = 0.001;   % Step length  
N = 1000000; % Step size

% Initial values
a = 0.5; u = zeros(4,N); w = zeros(4,N);
u(:,1) =[1-a 0 0 sqrt((1+a)/(1-a))];

% Explicit Euler algorithm 
for n=1:N-1
    q1n = u(1,n); q2n = u(2,n); p1n = u(3,n); p2n = u(4,n);
    w(:,n) = f(q1n,q2n,p1n,p2n,h);
    u(:,n+1) = u(:,n) + w(:,n);
end

graph(u(1,:),u(2,:),u(3,:),u(4,:),h,N)

% Hamiltonian 
function output = f(q1,q2,p1,p2,h)
    output = h*[p1; p2; fq(q1,q2); fq(q2,q1)];
end

% Kepler system
function output = fq(c,d)
    output = -c/(((c^2)+(d^2))^(3/2)); 
end

% Plotting orbit and energy
function output = graph(q1,q2,p1,p2,h,N)   
    figure 
    plot(q1,q2)   
    figure 
    H = 1/2*(p1.^2+p2.^2)-1./sqrt(q1.^2+q2.^2);
    t= h:h:N*h;
    set(gcf,'color','w'); 
    plot(t,H)
end








