function [x,y]=c2_bicorn1(t)
%espressione parametrica della curva bicorn1 
%per t in [-1,1]
    x = t;
    y = (2-2*t.^2-sqrt(1-3*t.^2+3*t.^4-t.^6))./(3+t.^2);
end