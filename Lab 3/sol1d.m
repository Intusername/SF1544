h = 0.001;  % Step length
N = 100000; % Step size

% Initial values 
tol = 1e-10; a=0.5; u=zeros(4,N);
u(:,1)=[1-a; 0; 0; sqrt((1+a)/(1-a))];

% Sympletic Euler algorithm
for n=2:N
    w = u(:,n-1);
    % Fixpoint iteration
    while max(abs(u(:,n-1)+f(w(3),w(4),...
            u(1,n-1),u(2,n-1),h)-w))> tol
        w = u(:,n-1) + f(w(3),w(4),u(1,n-1),u(2,n-1),h);
    end
    u(:,n)=w;
end

% Plotting orbit and energy
graph(u(1,:),u(2,:),u(3,:),u(4,:),h,N)

% Hamiltonian
function output = f(p1,p2,q1,q2,h)
    output = h*[p1; p2; fq(q1,q2); fq(q2,q1)];
end

% Kepler system 
function output = fq(c,d)
    output = -c/(((c^2)+(d^2))^(3/2)); 
end

function output = graph(q1,q2,p1,p2,h,N)
    figure 
    plot(q1,q2)
    figure 
    H = 1/2*(p1.^2+p2.^2)-1./sqrt(q1.^2+q2.^2);
    t= h:h:N*h;
    set(gcf,'color','w'); 
    plot(t,H)
end




