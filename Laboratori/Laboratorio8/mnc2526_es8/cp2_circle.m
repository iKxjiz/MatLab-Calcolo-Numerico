function [x,y,xp,yp]=cp2_circle(t)
%espressione parametrica della curva circonferenza
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end
