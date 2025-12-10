clear all
close all

figure(1);
hold on

m = 13;
[xc, yc] = circle(0,0,5,m);

r = 5 * sin (pi / 12);
n = 25;

[x , y] = circle(0,0,r,n);

for i = 1 : m - 1
    xi = x + xc(i);
    yi = y + yc(i);
    fill(xi, yi, 'r-', 'LineWidth', 1.5);
end

exis equal

function [x, y] = circle(cx, cy, r, n)
x = r * cos(n) + cx;
y = r * sin(n) + cy;
end