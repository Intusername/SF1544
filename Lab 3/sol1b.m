h = 0.006; % Step length
N =4580;   % Step size

% Initial values 
a=0.5; tol = 1e-4;u=zeros(4,N);
u(:,1)=[1-a; 0; 0; sqrt((1+a)/(1-a))];

% Implicit Euler algorithm 
for n=1:N-1
    w = u(:,n);
    % Fixpoint iteration
    while max(abs(u(:,n)+f(w(1), w(2),w(3),w(4),h)-w))> tol
        w = u(:,n)+f(w(1),w(2),w(3),w(4),h);
    end
    u(:,n+1)=w;
end

graph(u(1,:),u(2,:),u(3,:),u(4,:),h,N)

% Hamiltonian 
function output = f(q1,q2,p1,p2,h)
    output = h*[p1; p2; fq(q1,q2); fq(q2,q1)];
end

%Kepler system 
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

