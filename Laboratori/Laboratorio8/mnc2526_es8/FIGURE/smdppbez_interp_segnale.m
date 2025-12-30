%==========================================================================
% Script: smdppbez_interp_segnale.m
%==========================================================================
% DESCRIZIONE:
% Si vuole riprodurre il disegno di Figura 2 a destra, utilizzando curve
% di Bézier a tratti multi-grado, ottenute come join di curve di Bézier
% di interpolazione e/o modellazione.
% Si colorino quindi le regioni delimitate da tali curve per replicare,
% come richiesto, il disegno. Figura 2 ==> segnale di divieto
%==========================================================================

close all;
clear all;
clc

%% Parametri iniziali
n = 20;
mp = 100;
tol = 1.0e-6;
param = 0;

%% Interpolazione circonferenze
open_figure(1);
grid on;
axis equal;

% Cerchio esterno
t = chebyshev2(0, 2*pi, n + 1);
[x, y] = cp2_circle(t);
ppP = curv2_ppbezierCC1_interp([x', y'], 0, 2*pi, param);

% Cerchio interno (scalato e ruotato)
S = get_mat_scale([0.92, 0.92]);
R = get_mat2_rot(pi/2);
M = R * S;
ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP_intern.cp, M);

curv2_ppbezier_plot(ppP, mp, 'b', 3);
curv2_ppbezier_plot(ppP_intern, mp, 'b', 3);

%% Definizione linee orizzontali
r1 = [-1 0.2; 1 0.2];
r2 = [-1 -0.2; 1 -0.2];

ppr1 = curv2_bezier_interp(r1, 0, 1, param);
ppr2 = curv2_bezier_interp(r2, 0, 1, param);

curv2_ppbezier_plot(ppr1, mp, 'r', 2);
curv2_ppbezier_plot(ppr2, mp, 'r', 2);

%% Calcolo intersezioni
[IP1P2_r1, t1_r1, t2_r1] = curv2_intersect(ppr1, ppP_intern);
IP1P2_r1 = IP1P2_r1';

[IP1P2_r2, t1_r2, t2_r2] = curv2_intersect(ppr2, ppP_intern);
IP1P2_r2 = IP1P2_r2';

point_plot(IP1P2_r1(1,:), 'ko', 2, 'k', 'y', 8);
point_plot(IP1P2_r1(2,:), 'ko', 2, 'k', 'r', 8);
point_plot(IP1P2_r2(1,:), 'ko', 2, 'k', 'g', 8);
point_plot(IP1P2_r2(2,:), 'ko', 2, 'k', 'b', 8);

% Informazioni sulle intersezioni
fprintf("- ppr1 t1_r1(1)(%f) = %f %f \n", t1_r1(1), decast_val(ppr1, t1_r1(1)));
fprintf("- ppr1 t1_r1(2)(%f) = %f %f \n", t1_r1(2), decast_val(ppr1, t1_r1(2)));
fprintf("- ppP_intern t2_r1(1)(%f) = %f %f \n", t2_r1(1), decast_val(ppP_intern, t2_r1(1)));
fprintf("- ppP_intern t2_r1(2)(%f) = %f %f \n\n", t2_r1(2), decast_val(ppP_intern, t2_r1(2)));
fprintf("- ppr2 t1_r2(1)(%f) = %f %f \n", t1_r2(1), decast_val(ppr2, t1_r2(1)));
fprintf("- ppr2 t1_r2(2)(%f) = %f %f \n", t1_r2(2), decast_val(ppr2, t1_r2(2)));
fprintf("- ppP_intern t2_r2(1)(%f) = %f %f \n", t2_r2(1), decast_val(ppP_intern, t2_r2(1)));
fprintf("- ppP_intern t2_r2(2)(%f) = %f %f \n\n", t2_r2(2), decast_val(ppP_intern, t2_r2(2)));

%% Suddivisioni e costruzione regione centrale
open_figure(2);
axis equal;

% Cerchio esterno rosso
ppP_points = curv2_ppbezier_plot(ppP, -mp, 'b', 3);
point_fill(ppP_points, 'r', 'b', 2);

% Suddivisione parte superiore
[sx_1, dx_1] = ppbezier_subdiv(ppP_intern, t2_r1(1));
[p1, dx_1_1] = ppbezier_subdiv(dx_1, t2_r2(1));

% Suddivisione parte inferiore
[sx_2, dx_2] = ppbezier_subdiv(ppP_intern, t2_r2(2));
[p2, dx_2_2] = ppbezier_subdiv(dx_2, t2_r1(2));

%% Join e colorazione regione bianca centrale
bianco1 = curv2_mdppbezier_join(p1, p2, tol);
bianco1 = curv2_mdppbezier_close(bianco1);
bianco = curv2_mdppbezier_plot(bianco1, -mp, 'b', 2);

point_fill(bianco, 'white', 'b', 3);

%% Funzioni locali

function x = chebyshev2(a, b, n)
% Punti di Chebyshev di seconda specie
% Input:
%   a, b --> estremi intervallo in cui mappare i punti
%   n+1  --> numero di zeri del polinomio di Chebyshev di grado n+1
for i = 0:n
    x(i+1) = 0.5.*(a+b) + 0.5.*(a-b).*cos(i*pi/n);
end
end

function [x, y, xp, yp] = cp2_circle(t)
% Espressione parametrica della circonferenza e sue derivate
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end