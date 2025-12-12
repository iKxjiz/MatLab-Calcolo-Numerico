%==========================================================================
% Script: smdppbez_interp_germ.m
%==========================================================================
% DESCRIZIONE:
% Si vuole riprodurre il disegno di Figura 1 a destra, utilizzando
% curve di Bézier a tratti multi-grado, ottenute come join di curve
% di Bezier di interpolazione e/o modellazione.
% Si colorino quindi le regioni delimitate da tali curve per replicare,
% come richiesto, il disegno. (Cerchio con la bandiera della Germania)
%==========================================================================

close all;
clear all;
clc

%% Parametri iniziali
n = 8;
np = 300;
tol = 1.0e-6;
param = 0;
a = 0;
b = 2*pi;

%% Creazione cerchi concentrici
open_figure(1);
axis_plot(1.5, 0.125);
hold on;
grid on;

% Cerchio esterno
t = linspace(a, b, n);
[x, y, x1, y1] = cp2_circle(t);
ppP = curv2_ppbezierCC1_interp_der([x', y'], [x1', y1'], t);
curv2_ppbezier_plot(ppP, np, 'b', 2);

% Cerchio interno (scalato e ruotato)
S = get_mat_scale([0.97, 0.97]);
R = get_mat2_rot(pi/2);
M = R * S;
ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP.cp, M);
curv2_ppbezier_plot(ppP_intern, np, 'b', 2);

%% Definizione linee orizzontali divisorie
r1 = [-1, 0.3; 1 0.3];
r2 = [-1, -0.3; 1 -0.3];

ppr1 = curv2_bezier_interp(r1, 0, 1, param);
curv2_ppbezier_plot(ppr1, np, 'r', 2);

ppr2 = curv2_bezier_interp(r2, 0, 1, param);
curv2_ppbezier_plot(ppr2, np, 'r', 2);

%% Calcolo punti di intersezione
% Intersezione linea superiore con cerchio interno
[IP1P2_1, t1, t2] = curv2_intersect(ppr1, ppP_intern);
IP1P2_1 = IP1P2_1';
point_plot(IP1P2_1(1,:), 'ko', 2, 'k', 'y', 8);
point_plot(IP1P2_1(2,:), 'ko', 2, 'k', 'r', 8);

% Intersezione linea inferiore con cerchio interno
[IP1P2_2, t3, t4] = curv2_intersect(ppr2, ppP_intern);
IP1P2_2 = IP1P2_2';
point_plot(IP1P2_2(1,:), 'ko', 2, 'k', 'g', 8);
point_plot(IP1P2_2(2,:), 'ko', 2, 'k', 'b', 8);

%% Suddivisione e chiusura regioni
open_figure(2);
curv2_ppbezier_plot(ppP, np, 'k', 2);

% Regione superiore (nera)
[dx_sup, sx_sup] = ppbezier_subdiv(ppP_intern, t2(1));
[~, p1] = ppbezier_subdiv(sx_sup, t2(2));
dx_p1 = curv2_mdppbezier_join(dx_sup, p1, tol);
superiore = curv2_mdppbezier_close(dx_p1);
sup_points = curv2_mdppbezier_plot(superiore, -np, 'r', 2);

% Regione inferiore (gialla)
[dx_inf, sx_inf] = ppbezier_subdiv(ppP_intern, t4(1));
[p2, ~] = ppbezier_subdiv(sx_inf, t4(2));
inferiore = curv2_mdppbezier_close(p2);
inf_points = curv2_mdppbezier_plot(inferiore, -np, 'r', 2);

% Regione centrale (rossa)
[dx_cent_sx, sx_cent_sx] = ppbezier_subdiv(ppP_intern, t2(1));
[p3, ~] = ppbezier_subdiv(sx_cent_sx, t4(1));

[dx_cent_dx, sx_cent_dx] = ppbezier_subdiv(ppP_intern, t2(2));
[~, p4] = ppbezier_subdiv(dx_cent_dx, t4(2));

p3_p4 = curv2_mdppbezier_join(p3, p4, tol);
centrale = curv2_mdppbezier_close(p3_p4);
cent_points = curv2_mdppbezier_plot(centrale, -np, 'r', 2);

%% Colorazione regioni
point_fill(sup_points, 'k');
point_fill(inf_points, 'y');
point_fill(cent_points, 'r');

%% Funzioni locali

% function x = chebyshev2(a, b, n)
% % Punti di Chebyshev di seconda specie
% % Input:
% %   a, b --> estremi intervallo in cui mappare i punti
% %   n+1  --> numero di zeri del polinomio di Chebyshev di grado n+1
% for i = 0:n
%     x(i+1) = 0.5.*(a+b) + 0.5.*(a-b).*cos(i*pi/n);
% end
% end

function [x, y, xp, yp] = cp2_circle(t)
% Espressione parametrica della circonferenza e sue derivate
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end