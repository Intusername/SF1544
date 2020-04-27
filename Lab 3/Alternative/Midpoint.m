% Midpoint (implicit) Euler
function [q, p] = Midpoint(N,h,q0,p0)
    p = p0;
    q = q0;
    tol = 1e-6;
    
    for n = 1:N-1
        q(n+1,:) = q(n,:);
        pdot = Kepler(q(n,:));
        %Fixed-point iteration
        while max(abs((q(n,:)+h*(p(n,:)+(h/4)*(pdot + Kepler(q(n+1,:))))-q(n+1,:)))) > tol
            q(n+1,:) = q(n,:)+h*(p(n,:)+(h/4)*(pdot + Kepler(q(n+1,:))));
        end
        p(n+1,:) = (p(n,:)+(h/2)*(pdot + Kepler(q(n+1,:))));
    end
end
