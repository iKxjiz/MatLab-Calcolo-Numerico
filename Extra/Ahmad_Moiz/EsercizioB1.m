% Es A : 7 punti l'uno
% Es B : 15 punti

close all;
clear all;
clc

open_figure(1);
axis_plot(1.5, 0.125);
hold on;
grid on;

a = 0;
b = 2*pi;
n = 20;
mp = 100;
tol = 1.0e-2; % Tolleranza buona in molti casi
param=0;

%Determinare la circonferenza per interpolazione di Hermite con una curva
%cubica a tratti ppP
t = linspace(a, b, n);
[x, y, x1, y1] = cp2_circle(t); % SEMBRA ESSERE IL MIGLIORE TRA TUTTI
ppP = curv2_ppbezierCC1_interp_der([x', y'], [x1', y1'], t);
curv2_ppbezier_plot(ppP, mp, 'b', 2);

% Stima dell'errore di interpolazione
npt = 150;
t = linspace(a, b, npt);
Pxy = ppbezier_val(ppP, t);
[x, y] = cp2_circle(t);
Qxy = [x', y'];

MaxErr = max(vecnorm((Pxy-Qxy)'));
fprintf("Massimo errore %e\n", MaxErr);
% Domanda, come lo si gestisce ? cioè se è grande, come lo si diminuisce ?

S = get_mat_scale([0.92, 0.92]);
R = get_mat2_rot(pi/2);

M = R * S;

ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP_intern.cp, M);
%ppP_intern = curv2_bezier_reverse(ppP_intern);

curv2_ppbezier_plot(ppP, mp, 'b', 2);
curv2_ppbezier_plot(ppP_intern, mp, 'b', 2);

ppr1.cp = [-1 -0.2; 1 -0.2];
ppr1.deg = 1;
ppr1.ab = [0,1];
curv2_bezier_plot(ppr1, mp, 'b', 2);

ppr2.cp = [-1 0.2; 1 0.2];
ppr2.deg = 1;
ppr2.ab = [0,1];
curv2_bezier_plot(ppr2, mp, 'r', 2);

[IP1P2, t1, t2] = curv2_intersect(ppP_intern, ppr1);
IP1P2 = IP1P2';

[IP3P4, t3, t4] = curv2_intersect(ppP_intern, ppr2);
IP3P4 = IP3P4';

[ppRsx, ppRdx] = ppbezier_subdiv(ppP_intern, t1(1));
[ppsx, ppRdx] = ppbezier_subdiv(ppRsx, t3(1));
%curv2_ppbezier_plot(ppRdx, mp, 'g', 2);

[ppRsx2, ppRdx2] = ppbezier_subdiv(ppr1, t2(1));
%curv2_ppbezier_plot(ppRdx2, mp, 'g', 2);
[k1, k2] = ppbezier_subdiv(ppRdx2, t2(2));
%curv2_ppbezier_plot(k1, mp, 'g', 2);

L_sotto = curv2_mdppbezier_join(ppRdx, k1, tol);
%curv2_mdppbezier_plot(L_sotto, mp, 'g', 2);

R = get_mat2_rot(pi);

L_sopra = L_sotto;
L_sopra.cp = point_trans(L_sopra.cp, R);
%curv2_mdppbezier_plot(L_sopra, mp, 'g', 2);

seg_centrale = curv2_mdppbezier_join(L_sopra, L_sotto, tol);
punti_centrale = curv2_mdppbezier_plot(seg_centrale, -mp, 'g', 2);
punti_esterno = curv2_ppbezier_plot(ppP, -mp, 'b', 2);

open_figure(2);

point_fill(punti_esterno, 'r', 'b', 2);
point_fill(punti_centrale, 'w', 'b', 2);