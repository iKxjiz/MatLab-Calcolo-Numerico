%==========================================================================
% Script: sppbez_interp2d_ceco.m
%==========================================================================
% DESCRIZIONE:
% Creazione della bandiera della Cecoslovacchia utilizzando curve di Bézier
% a tratti multi-grado. La bandiera è composta da un cerchio esterno, un
% cerchio interno e linee che dividono le tre regioni colorate.
%==========================================================================

close all;
clear;
clc

%% Parametri iniziali
n = 8;
np = 150;
tol = 1.0e-6;
param = 0;
a = 0;
b = 2*pi;

%% Interpolazione circonferenza esterna
open_figure(1);

t = linspace(a, b, n);
[x, y, x1, y1] = cp2_circle(t);
Q = [x', y'];
Q1 = [x1', y1'];
ppP = curv2_ppbezierCC1_interp_der(Q, Q1, t);

% Stima dell'errore di interpolazione
npt = 200;
t = linspace(a, b, npt);
Pxy = ppbezier_val(ppP, t);
[x, y] = cp2_circle(t);
Qxy = [x', y'];
MaxErr = max(vecnorm((Pxy-Qxy)'));
fprintf("Massimo errore %e\n", MaxErr);

%% Creazione cerchio interno
S = get_mat_scale([0.95 0.95]);
ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP_intern.cp, S);

curv2_ppbezier_plot(ppP, np, 'b', 3);
curv2_ppbezier_plot(ppP_intern, np, 'b', 3);
point_plot(ppP.cp(1,:), 'ko', 2)

%% Definizione linee del simbolo
% Linea diagonale superiore sinistra
ppr1.cp = [-1 0.6; 0 0];
ppr1.deg = 1;
ppr1.ab = [0 1];
curv2_bezier_plot(ppr1, np, 'r', 3);
point_plot(ppr1.cp(1,:), 'ko', 3)

% Linea diagonale inferiore sinistra
ppr2.cp = [-1 -0.6; 0 0];
ppr2.deg = 1;
ppr2.ab = [0 1];
curv2_bezier_plot(ppr2, np, 'r', 3);
point_plot(ppr2.cp(1,:), 'ko', 3)

% Linea verticale centrale
ppr3.cp = [0 0; 1.2 0];
ppr3.deg = 1;
ppr3.ab = [0 1];
curv2_bezier_plot(ppr3, np, 'r', 3);
point_plot(ppr3.cp(1,:), 'ko', 3);
point_plot(ppr3.cp(end,:), 'ko', 3);

%% Costruzione e suddivisione regioni
open_figure(2);
curv2_ppbezier_plot(ppP, np, 'b', 3);
curv2_ppbezier_plot(ppP_intern, np, 'b', 3);
curv2_bezier_plot(ppr1, np, 'r', 3);
curv2_bezier_plot(ppr2, np, 'r', 3);
curv2_bezier_plot(ppr3, np, 'r', 3);

%% Regione superiore (bianca)
v_up = curv2_mdppbezier_join(ppr1, ppr3, tol);
[~, t1, t2] = curv2_intersect(ppP_intern, v_up);

% Test suddivisioni
[sx1, dx1] = ppbezier_subdiv(ppP_intern, t1(1));
% curv2_ppbezier_plot(sx1, np, 'b', 3);
% curv2_ppbezier_plot(dx1, np, 'r', 3);

[sxr1, dxr1] = ppbezier_subdiv(v_up, t2(1));
% curv2_ppbezier_plot(sxr1, np, 'b', 3);
% curv2_ppbezier_plot(dxr1, np, 'r', 3);

[sxr1_1, dxr1_1] = ppbezier_subdiv(dxr1, t2(2));
% curv2_ppbezier_plot(sxr1_1, np, 'b', 3);
% curv2_ppbezier_plot(dxr1_1, np, 'r', 3);

v_up = curv2_mdppbezier_join(sxr1_1, sx1, tol);
v_up = curv2_mdppbezier_close(v_up);
v_up_point = curv2_mdppbezier_plot(v_up, -np, 'r', 3);

%% Regione inferiore (rossa)
v_low = curv2_mdppbezier_join(ppr2, ppr3, tol);
[~, t3, t4] = curv2_intersect(ppP_intern, v_low);

% Test suddivisioni
[sx2, dx2] = ppbezier_subdiv(ppP_intern, t3(1));
% curv2_ppbezier_plot(sx2, np, 'b', 3);
% curv2_ppbezier_plot(dx2, np, 'r', 3);

[sxr2, dxr2] = ppbezier_subdiv(v_low, t2(1));
% curv2_ppbezier_plot(sxr2, np, 'b', 3);
% curv2_ppbezier_plot(dxr2, np, 'r', 3);

[sxr2_2, dxr2_2] = ppbezier_subdiv(dxr2, t2(2));
% curv2_ppbezier_plot(sxr2_2, np, 'b', 3);
% curv2_ppbezier_plot(dxr2_2, np, 'r', 3);

v_low = curv2_mdppbezier_join(sxr2_2, dx2, tol);
v_low = curv2_mdppbezier_close(v_low);
v_low_point = curv2_mdppbezier_plot(v_low, -np, 'r', 3);

%% Regione centrale (blu)
v_cent = curv2_mdppbezier_join(ppr1, ppr2, tol);
[~, t5, t6] = curv2_intersect(ppP_intern, v_cent);

% Test suddivisioni
[sx3, dx3] = ppbezier_subdiv(ppP_intern, t5(2));
% curv2_ppbezier_plot(sx3, np, 'b', 3);
% curv2_ppbezier_plot(dx3, np, 'r', 3);

[sx3_3, dx3_3] = ppbezier_subdiv(dx3, t5(1));
% curv2_ppbezier_plot(sx3_3, np, 'b', 3);
% curv2_ppbezier_plot(dx3_3, np, 'r', 3);

[sxr3, dxr3] = ppbezier_subdiv(v_cent, t6(2));
% curv2_ppbezier_plot(sxr3, np, 'b', 3);
% curv2_ppbezier_plot(dxr3, np, 'r', 3);

[sxr3_3, dxr3_3] = ppbezier_subdiv(dxr3, t6(1));
% curv2_ppbezier_plot(sxr3_3, np, 'y', 3);
% curv2_ppbezier_plot(dxr3_3, np, 'g', 3);

v_cent = curv2_mdppbezier_join(sxr3_3, sx3_3, tol);
v_cent = curv2_mdppbezier_close(v_cent);
v_cent_point = curv2_mdppbezier_plot(v_cent, -np, 'r', 3);

%% Colorazione finale
open_figure(3);
curv2_ppbezier_plot(ppP, np, 'k', 3);
point_fill(v_up_point, 'white');
point_fill(v_low_point, 'r');
point_fill(v_cent_point, 'b');

%% Funzioni locali

function [x, y, xp, yp] = cp2_circle(t)
% Espressione parametrica della circonferenza e sue derivate
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end