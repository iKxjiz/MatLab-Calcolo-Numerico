function [x,y]=c2_bicorn2(t)
%espressione parametrica della curva bicorn2  
%per t in [-1,1]
    x = t;
    y = (1.8-2*t.^2+sqrt(1-3*t.^2+3*t.^4-t.^6))./(3+t.^2);
end