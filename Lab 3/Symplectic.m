h = 0.005; N = 500000;
tol = 1e-10; a=0.5; u=zeros(4,N);
u(:,1)=[1-a; 0; 0; sqrt((1+a)/(1-a))];

for i=2:N
    u(:,i) = u(:,i-1) + f(w(3),w(4),u(1,i-1),u(2,i-1),h);
end

graph_energy(u(1,:),u(2,:),u(3,:),u(4,:),h,N)

function output = graph_energy(q1,q2,p1,p2,h,N)
    figure 
    plot(q1,q2)
    figure 
    H = 1/2*(p1.^2+p2.^2)-1./sqrt(q1.^2+q2.^2);
    t= h:h:N*h;
    plot(t,H)
end

function output = f(p1,p2,q1,q2,h)
    output = h*[p1; p2; fq(q1,q2); fq(q2,q1)];
end

function output = fq(c,d)
    output = -c/(((c^2)+(d^2))^(3/2)); 
end