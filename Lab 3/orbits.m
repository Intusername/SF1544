% Variables and initial values for Explicit Euler
h1 = 0.001; N1 = 500000; % Step length and step size 
a = 0.5;
u1 = zeros(4,N1); w1 = zeros(4,N1);
u1(:,1) =[1-a 0 0 sqrt((1+a)/(1-a))];

% Variables and initial values for Implicit Euler
h2 = 0.006; N2 = 4580; % Step length and step size 
tol2 = 1e-4;u2=zeros(4,N2);
u2(:,1)=[1-a; 0; 0; sqrt((1+a)/(1-a))];

% Variables and initial values for Midpoint method 
h3 = 0.00049; N3 = 90000; % Step length and step size 
tol3 = 1e-10; u3 = zeros(4,N3);
u3(:,1)=[1-a; 0; 0; sqrt((1+a)/(1-a))];

% Variables and initial values for Sympletic Euler
h4 = 0.001; N4 = 100000; % Step length and step size 
tol4 = 1e-10; u4=zeros(4,N4);
u4(:,1)=[1-a; 0; 0; sqrt((1+a)/(1-a))];

% Algorithm for Explicit Euler
for n=1:N1-1
    q1n = u1(1,n); q2n = u1(2,n);...
        p1n = u1(3,n); p2n = u1(4,n);
    w1(:,n) = f(q1n,q2n,p1n,p2n,h1);
    u1(:,n+1) = u1(:,n) + w1(:,n);
end

% Algorithm for Implicit Euler
for n=1:N2-1
    w2 = u2(:,n);
    % Fixpoint iteration
    while max(abs(u2(:,n)+f(w2(1),...
            w2(2),w2(3),w2(4),h2)-w2))> tol2
        w2 = u2(:,n)+f(w2(1),w2(2),w2(3),w2(4),h2);
    end
    u2(:,n+1)=w2;
end

% Algorithm for Midpoint method
for n=1:N3-1
    w3 = u3(:,n);
    % Fixpoint iteration
    while max(abs(u3(:,n)+f3(w3(1),w3(2),w3(3),w3(4),...
        u3(1,n),u3(2,n),u3(3,n),u3(4,n),h3)-w3))> tol3
    w3 = u3(:,n) + f3(w3(1),w3(2),w3(3),w3(4),...
        u3(1,n),u3(2,n),u3(3,n),u3(4,n),h3);
    end
    u3(:,n+1)=w3;
end

%Algorithm for Sympletic Euler
for n=2:N4
    w4 = u4(:,n-1);
    % Fixpoint iteration
    while max(abs(u4(:,n-1)+f4(w4(3),w4(4),...
        u4(1,n-1),u4(2,n-1),h4)-w4))> tol4
        w4 = u4(:,n-1) + f4(w4(3),w4(4),...
        u4(1,n-1),u4(2,n-1),h4);
    end
    u4(:,n)=w4;
end

u = {u1, u2, u3, u4};
h = {h1, h2, h3, h4};
N = {N1, N2, N3, N4};
main(u,h,N)

% Plotting energies and orbits 
function output = main(u,h,N)
    text = {'(a) Explicit Euler' ' (b) Implicit Euler'...
         '(c) Midpoint method' '(d) Sympletic Euler'}
    figure(1)
    plot_orbits(u,text);
    figure(2) 
    graph_energy(u,text,h,N) 
end 

% Plotting orbits for each procedures
function output = plot_orbits(u,text)
    for i=1:4
        q1 = u{i}(1,:); q2 = u{i}(2,:);
        subplot(2,2,i)
        graph(q1, q2, text, i)
    end
end

% Plotting energy over time for each procedures
function output = graph_energy(u,text,h,N)   
    for i=1:4 
        q1 = u{i}(1,:); q2 = u{i}(2,:);
        p1 = u{i}(3,:); p2 = u{i}(4,:);
        t = h{i}:h{i}:h{i}*N{i};
        subplot(2,2,i)
        graph(t, H(q1, q2, p1, p2), text, i)
    end
end

function output = graph(a,b,text,i)
    set(gcf,'color','w'); 
    plot(a,b);
    set(gca,'fontsize',10)
    title(text{i},'fontsize',16)
end

% Hamiltonians
function output = H(q1, q2, p1, p2)
    output = 1/2*(p1.^2+p2.^2)-1./sqrt(q1.^2+q2.^2);
end

function output = f3(q1,q2,p1,p2,q3,q4,p3,p4,h)
    output = (h/2)*[p1+p3;p2+p4;...
        fq(q1,q2)+fq(q3,q4);fq(q2,q1)+fq(q4,q3);];
end

function output = f4(p1,p2,q1,q2,h)
    output = h*[p1; p2; fq(q1,q2); fq(q2,q1)];
end

function output = f(q1,q2,p1,p2,h)
    output = h*[p1; p2; fq(q1,q2); fq(q2,q1)];
end

function output = fq(c,d)
    output = -c/(((c^2)+(d^2))^(3/2)); 
end







