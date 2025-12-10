function [x,y]=c2_cardioide(t)
%espressione parametrica della cardiode con t in [0,2*pi]
x = 2.*cos(t)-cos(2.*t);
y = 2.*sin(t)-sin(2.*t);
return