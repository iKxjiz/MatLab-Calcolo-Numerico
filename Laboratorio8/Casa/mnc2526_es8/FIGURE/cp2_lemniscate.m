function [x, y, xp, yp] = cp2_lemniscate(t)
% Lemniscata di Bernoulli
a = 1;
x = (a * cos(t)) ./ (1 + sin(t).^2);
y = (a * sin(t) .* cos(t)) ./ (1 + sin(t).^2);
% Derivate (calcolo simbolico semplificato)
den = (1 + sin(t).^2).^2;
xp = -a * (sin(t) + 2*sin(t).^3 + sin(t) .* cos(t).^2) ./ den;
yp = a * (cos(t).^2 - sin(t).^2 + cos(t).^2 .* cos(2*t)) ./ den;
end