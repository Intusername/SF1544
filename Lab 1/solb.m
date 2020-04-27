t = 40; %Measure time
h = 0.5; % Step size
M = 10; % Number of cars
vm = 25; %Maximum speed
g = 5; %Speed of first car
d = 75; %Distance when cars start to slow down
id = d; %Initial distance between cars

x=[0:h:t];
carPos = fweuler(t,h,M,vm,g,d,id);

hold on
for i = 1:M %Plotting graphs 
    plot(x,carPos(:,i))
end

function [retval] = fweuler (t,h,M,vm,g,d,id)
  n = t/h+1; %Number of evaluation points
  carPos = [];
  carPos(1,:)=id*(1:M); % Initial positions for each car
  carPos(1:n,M) = [id*M : h*g : id*M+t*g]; %Positions of car M
  for i = 1:n-1
    for c = 1:M-1
      %Calculating position of all cars except car  M
      f = speed(carPos(i,c+1)- carPos(i,c), vm, d);
      carPos(i+1,c) = carPos(i,c) + h * f;
    end
  end
  retval = carPos;
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
