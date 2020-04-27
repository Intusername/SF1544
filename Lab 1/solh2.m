h=0.5;
T=40;
N=T./h;
M=10;
vm=25;
d=75;
g=5;
maxit=20;

acc = zeros(M,N);
for l = 1:M % Initial positions for each car
    acc(l,1) = d*l;
end
for i =1:N
    acc(M, i+1)=acc(M,i)+h.*g;
    for j=M-1:-1:1
        %Calculating position for all except first care in queue
        if abs(acc(j,i)-acc(j+1,i))<=d
            acc(j,i+1)=1/(1+(h*vm) /d)*acc(j,i)+1/(1+d/(h*vm))...
            *acc(j+1,i+1);
        %Calculating position of first car in queue    
        else
            acc(j,i+1)=acc(j,i)+h*vm;
        end
    end
end

error=zeros(1,maxit);

%Residual plotting 
for j =1:maxit
    F = fixpointmethod(h,T,M,vm,d,X,g,j);
    error(j) = abs(F(1,T)-acc(1,T)); 
end
semilogy((1:1:maxit),error)

function[fixpoint] = fixpointmethod(h , T, M, vm, d , X, g , precision)
N=T./h ;
carPos=zeros(M,N);
carPos(:,1)=X;

for i =1:N
    carPos(M, i+1)= carPos(M,i)+h*g ; 
    for j=M-1:-1:1 
        guess = carPos(j,i); 
        l = @(t) carPos(j,i)+h* speed(vm, d , carPos(j+1,i+1)-t);
        int = l(guess); 
        for k = 1:precision
            int = l(int); 
        end
        carPos(j,i +1)=int ; 
    end
end

fixpoint = carPos;
end

function output = speed(vm, d, x)
    if (x >= d)
        output = vm;
    elseif x <= 0;
        output = 0; 
    else 
        output = x/3;
    end
end






