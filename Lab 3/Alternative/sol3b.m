clf, close all, clear all
N=200; % antal steg i rummet
a=1.0; % områdesbredd
T=0.5; % sluttid
c = 2; % parameter i vågekvationen, våghastighet

dx=a/N; % steglängd i rummet
dt=dx/(2*c); % tidssteg, tänk på stabilitetsvillkoren
M=fix(T/dt); % antal tidsteg

% Initieringsfunktioner
dAlemberts = true; % sätt till true för d'Alemberts formel, false för symplektiska Euler
u0 = @(x) sin(2*pi*x/a); % funktion u vid t = 0
p0 = @(x) 0; % funktion p=u' vid t = 0
neumann = false; % true för homogena Neumannvillkor, false för Dirichlet
dirN = 0; % randvillkor vid Dirichletproblem
dir0 = 0;

% allokering av minne
u=zeros(N-1,M+1); % u(n,m) utböjning vid tid (m-1)*dt i position n*dx
p=zeros(N-1,M+1); % p=u’
A=zeros(N-1,N-1); % Au är differensapproximation av d^2 u/dx^2
X=zeros(N-1,1); % X(n) blir n*dx


figure(1)
axis([0 a -1 1])
write_obj = VideoWriter('outw.avi');
write_obj.FrameRate = 10;
open(write_obj);
nframe=M; % kommando för film
mov(1:nframe)= struct('cdata',[],'colormap',[]);
set(gca,'nextplot','replacechildren')

for n=1:N-1 % slinga med rumssteg för att bilda begynnelsedata och A
    X(n,1) = n*dx;
    u(n,1) = u0(n*dx);
    p(n,1) = p0(n*dx);
    A(n,n) = -2*N^2;
    if n < N-1
        A(n+1,n) = N^2;
        A(n,n+1) = N^2;
    end
end

if dAlemberts   % tidstegning med d'Alembert
    for m=2:M
        for n=1:N-1
            u(n,m) = 1/2*(u0(n*dx+c*m*dt)+u0(n*dx-c*m*dt));
        end
            plot(X,u(:,m), 'b', 'Linewidth', 1)
            mov(m-1)=getframe(gcf);
    end
else
    for m=1:M     % tidstegning med symplektiska Euler
        p(:,m+1) = p(:,m) + dt*c^2*A*u(:,m);
        u(:,m+1) = u(:,m) + dt*p(:,m+1);
        if neumann
            u(1,m+1) = u(2,m+1);
            u(end,m+1) = u(end-1,m+1);
        else
            u(1,m+1) = dir0;
            u(end,m+1) = dirN;
        end
        
        plot(X,u(:,m+1), 'b', 'Linewidth', 1)
        mov(m)=getframe(gcf);
    end
end

writeVideo(write_obj,mov);
close(write_obj);