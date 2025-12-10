function [x,y,xp,yp] = cp2_cardioide(t)
%espressione parametrica della cardiode con t in [0,2*pi]
% Coordinate
x = 2*cos(t) - cos(2*t);
y = 2*sin(t) - sin(2*t);

% Derivate prime
xp = -2*sin(t) + 2*sin(2*t);
yp = 2*cos(t) - 2*cos(2*t);
end