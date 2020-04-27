t = 40; 
h = .5; 
M = 10; 
vm = 25; 
g = vm;
d = 75;
p = 10; %Precision of iterations

x = (0:h:t);
y = fixpointmethod(t,h,M,vm,g,d,p);
plot(x, y)

function [fixpoint] = fixpointmethod(t,h,M,vm,g,d,p)
n = t./h
carPos = zeros(M,n);
for l = 1:M % Initial positions for each car
    carPos(l,1)= 10*l;
end

for i = 1:n
    carPos(M, i+1) = carPos(M,i) + h*g; %Position of first car
    for j = M-1:-1:1 %Iterating through the position matrix
        guess = carPos(j,i);
        %Determining fixpoint function, I(x) = x
        I = @(t) carPos(j,i)+h* speed(carPos(j +1, i+1)-t, vm, d);
        int = I(guess); %Initial guess
        for k = 1:p %Recursive iteration
            int = I(int);
        end
        carPos(j, i+1) = int; %Saving the result
    end
end
fixpoint = carPos;
end

% Speed limit and three-second-rule
function output = speed(x, vm, d)
    if (x >= d)
        output = vm;
    elseif x <= 0;
        output = 0; 
    else 
        output = x/3;
    end
end
