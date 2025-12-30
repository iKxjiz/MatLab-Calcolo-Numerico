function [x, y] = fcircle(n, cx, cy, r)
% r : raggio ---- cx, cy : coordinate del centro
t = linspace(0, 2*pi, n);
x = r * cos(t) + cx;
y = r * sin(t) + cy;
end