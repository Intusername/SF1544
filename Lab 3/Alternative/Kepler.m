function pdot = Kepler(qn)
    pdot(1,1) = -qn(1)/(qn(1)^2+qn(2)^2)^(3/2);
    pdot(1,2) = -qn(2)/(qn(1)^2+qn(2)^2)^(3/2);
end