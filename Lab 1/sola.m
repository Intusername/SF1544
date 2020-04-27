vm = 25;
d = 75;

f = @(x) speed(x, vm, d);
fplot(f);
xlim([-30 150]);
ylim([-10 50]);

function output = speed(x, vm, d)
    if (x >= d)
        output = vm;
    elseif x <= 0;
        output = 0; 
    else 
        output = x/3;
    end
end









