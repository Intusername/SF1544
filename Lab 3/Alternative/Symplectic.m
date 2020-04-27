% Symplectic Euler
function [q, p] = Symplectic(N,h,q0,p0)
    q = q0;
    p = p0;
    
    for n = 1:N-1
        p(n+1,:) = p(n,:) + h*Kepler(q(n,:));
        q(n+1,:) = q(n,:) + h*(p(n+1,:));
    end
end