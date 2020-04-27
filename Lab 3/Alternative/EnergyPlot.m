% Plot the energy, H Hamiltonian
function H = EnergyPlot(q,p,N,h)
    tspan = h*(1:N);
    H = (1/2)*vecnorm(q,2,2).^2 - 1./vecnorm(p,2,2);
    plot(tspan,H);
end