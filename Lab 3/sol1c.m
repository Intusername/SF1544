h = 0.001; N = 90000; 
a=0.5; tol = 1e-10; u = zeros(4,N);
u(:,1)=[1-a; 0; 0; sqrt((1+a)/(1-a))];

for n=1:N-1
w = u(:,n);
while max(abs(u(:,n)+f(w(1),w(2),w(3),w(4),...
    u(1,n),u(2,n),u(3,n),u(4,n),h)-w))> tol
w = u(:,n) + f(w(1),w(2),w(3),w(4),...
    u(1,n),u(2,n),u(3,n),u(4,n),h);
end
u(:,n+1)=w;
end

graph_energy(u(1,:),u(2,:),u(3,:),u(4,:),h,N)

function output = graph_energy(q1,q2,p1,p2,h,N)
    figure(1)
    plot(q1,q2);
    figure(2)
    H= 1/2*(p1.^2+p2.^2)-1./sqrt(q1.^2+q2.^2);
    t = h:h:h*N;
    plot(t,H)
end 

function output = f(q1,q2,p1,p2,q3,q4,p3,p4,h)
    output = (h/2)*[p1+p3;p2+p4;...
        fq(q1,q2)+fq(q3,q4);fq(q2,q1)+fq(q4,q3);];
end

function output = fq(c,d)
    output = -c/(((c^2)+(d^2))^(3/2)); 
end
