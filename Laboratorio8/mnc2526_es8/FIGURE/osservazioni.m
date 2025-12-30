% Osservazioni

close all;
clear all;
clc

n = 6;
np = 300;
tol = 1.0e-6;
param = 0;
a = 0;
b = 2*pi;

t1 = linspace(a, b, n);
t2 = chebyshev2(a, b, n);

[x1, y1] = cp2_circle(t1);
ppP1 = curv2_ppbezierCC1_interp([x1', y1'], a, b, param);

[x2, y2] = cp2_circle(t2);
ppP2 = curv2_ppbezierCC1_interp([x2', y2'], a, b, param);

[x3, y3, x1, y1] = cp2_circle(t1); % SEMBRA ESSERE IL MIGLIORE TRA TUTTI
ppP3 = curv2_ppbezierCC1_interp_der([x3', y3'], [x1', y1'], t1);

[x4, y4, x2, y2] = cp2_circle(t2);
ppP4 = curv2_ppbezierCC1_interp_der([x4', y4'], [x2', y2'], t2);

open_figure(1);
axis_plot(1.5, 0.125);
hold on;
grid on;

curv2_ppbezier_plot(ppP1, np, 'b', 3);

open_figure(2);
axis_plot(1.5, 0.125);
hold on;
grid on;

curv2_ppbezier_plot(ppP2, np, 'b', 3);

open_figure(3);
axis_plot(1.5, 0.125);
hold on;
grid on;

curv2_ppbezier_plot(ppP3, np, 'b', 3);

open_figure(4);
axis_plot(1.5, 0.125);
hold on;
grid on;

curv2_ppbezier_plot(ppP4, np, 'b', 3);

%% Funzioni Locali :
function x=chebyshev2( a,b,n )
%input:
%  a,b --> estremi intervalo in cui mappare i punti
%  n+1 --> numero di zeri del polinomio di Chebyshev di grado n+1
%punti di Chebishev seconda specie
for i=0:n
    x(i+1)=0.5.*(a+b)+0.5.*(a-b).*cos(i*pi/n);
end
end

function [x,y,xp,yp]=cp2_circle(t)
%espressione parametrica della curva circonferenza
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end