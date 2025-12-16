function [x, y, xp, yp] = cp2_spiral(t)
% Spirale di Archimede
x = t .* cos(t);
y = t .* sin(t);
xp = cos(t) - t .* sin(t);
yp = sin(t) + t .* cos(t);
end