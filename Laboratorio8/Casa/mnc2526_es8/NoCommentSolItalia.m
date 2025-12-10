%==========================================================================
% Script: smbppbez_interp_italy.m
%==========================================================================
% DESCRIZIONE:
% Si vuole riprodurre il disegno di Figura 1 a destra, utilizzando
% curve di Bézier a tratti multi-grado, ottenute come join di curve
% di Bezier di interpolazione e/o modellazione.
% Si colorino quindi le regioni delimitate da tali curve per replicare,
% come richiesto, il disegno. (Cerchio con la bandiera dell'italia)
%==========================================================================

clear all
clc
open_figure(1);
axis_plot(1.5, 0.125);
hold on;
grid on;

% Parametri generali
n = 20;
mp = 100;
tol = 1.0e-2;
param = 0;

%Determinare la circonferenza per interpolazione di Hermite con una curva
%cubica a tratti ppP
t = chebyshev2(0, 2*pi, n + 1);
[x, y, xp, yp] = cp2_circle(t);
ppP = curv2_bezier_interp([x', y'], 0, 2*pi, 2);

curv2_ppbezier_plot(ppP, mp, 'b', 2);

% Circonferenza interna (scalata al 97%)
S = get_mat_scale([0.97, 0.97]);

ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP_intern.cp, S);
curv2_ppbezier_plot(ppP_intern, mp, 'b', 2);

r1 = [-1 0.3; 1 0.3];
r2 = [-1 -0.3; 1 -0.3];

ppr1 = curv2_bezier_interp(r1, 0, 1, param);
ppr2 = curv2_bezier_interp(r2, 0, 1, param);

C = [0, 0.3];
T1r1 = get_mat_trasl(-C);
T1r2 = get_mat_trasl(C);
T2r1 = get_mat_trasl([0.32, 0]);
T2r2 = get_mat_trasl([-0.32, 0]);
R = get_mat2_rot(pi/2);
M1 = T2r1 * R * T1r1;
M2 = T2r2 * R * T1r2;
ppr1.cp = point_trans(ppr1.cp, M1);
ppr2.cp = point_trans(ppr2.cp, M2);

curv2_ppbezier_plot(ppr1, mp, 'r', 2);
curv2_ppbezier_plot(ppr2, mp, 'r', 2);
point_plot(ppr1.cp(1,:), 'ko', 3);
point_plot(ppr2.cp(1,:), 'ko', 3);

[IP1P2_r1, t1_r1, t2_r1] = curv2_intersect(ppr1, ppP_intern);
[IP1P2_r2, t1_r2, t2_r2] = curv2_intersect(ppr2, ppP_intern);
point_plot(IP1P2_r1', 'go', 1, 'g', 'g', 8);
point_plot(IP1P2_r2', 'go', 1, 'g', 'g', 8);

open_figure(2);
hold on;
curv2_ppbezier_plot(ppP, mp, 'k', 3);

[p1_sx, p1_dx] = decast_subdiv(ppP_intern, t2_r1(1));
[p1_1_sx, p1_1_dx] = decast_subdiv(ppP_intern, t2_r1(2));
union_dx = curv2_mdppbezier_join(p1_dx, p1_1_sx, tol);
union_dx = curv2_mdppbezier_close(union_dx);
union_dx_points = curv2_mdppbezier_plot(union_dx, -mp, 'k', 3);
point_fill(union_dx_points, [1, 0, 0]);

R = get_mat2_rot(pi);
ppP_intern.cp = point_trans(ppP_intern.cp, R);

[p2_sx, p2_dx] = decast_subdiv(ppP_intern, t2_r1(1));
[p2_2_sx, p2_2_dx] = decast_subdiv(ppP_intern, t2_r1(2));

union_sx = curv2_mdppbezier_join(p2_dx, p2_2_sx, tol);
union_sx = curv2_mdppbezier_close(union_sx);

union_sx_points = curv2_mdppbezier_plot(union_sx, -mp, 'k', 3);
point_fill(union_sx_points, [0.2, 0.7, 0.2]);

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