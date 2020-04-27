% Backward Euler
function [q, p] = Backward(N,h,q0,p0)
    tol = 1e-4;
    q = q0;
    p = p0;
    
    for i = 1:N-1
        q(i+1,:) = q(i,:); %Fixed-point iteration
        while max(abs((q(i,:)+h*(p(i,:)+h*Kepler(q(i+1,:)))-q(i+1,:)))) > tol
            q(i+1,:) = q(i,:) + h*(p(i,:) + h*Kepler(q(i+1,:)));
        end
        p(i+1,:) = p(i,:) + h*Kepler(q(i+1,:));
    end
end