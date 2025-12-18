% =========================================================================
% SCRIPT: Scudo con stella a 5 punte
% =========================================================================
% Disegna uno scudo verde con una stella gialla a 5 punte e cerchi rossi
% usando curve di Bézier, intersezioni e trasformazioni geometriche
% =========================================================================

close all;
clear;
clc;

% PARAMETRI

np = 100;
tol = 1.0e-2;
param = 0;

% COSTRUZIONE SCUDO

open_figure(1);
axis_plot(2, 0.2);

% Punti della curva da interpolare (metà scudo)
P = [
    0.83,  0.8;
    0.825, 0.493;
    0.72,  0.26;
    0.5,   0.1
    ];

% Interpolazione della curva
ppP = curv2_bezier_interp(P, 0, 1, param);

% Trasformazione: trasla e scala
T = get_mat_trasl([-0.5, -0.5]);
S = get_mat_scale([5, 5]);
M = S * T;
ppP.cp = point_trans(ppP.cp, M);
curv2_bezier_plot(ppP, np, 'b', 2);

% Riflessione per simmetria rispetto all'asse Y
Sy = get_mat2_symm([0 0], [0 1]);
temp = ppP;
temp.cp = point_trans(temp.cp, Sy);

% Unione e chiusura dello scudo
ppP = curv2_mdppbezier_join(ppP, temp, tol);
ppP = curv2_mdppbezier_close(ppP);
curv2_mdppbezier_plot(ppP, np, 'r', 3);

% COSTRUZIONE CIRCONFERENZA (Hermite con derivate)

n = 5;
a = 0;
b = 2*pi;
t = linspace(a, b, n + 1);
[x, y, xp, yp] = cp2_circle(t);
Q = [x', y'];
Q1 = [xp', yp'];

ppC = curv2_ppbezierCC1_interp_der(Q, Q1, t);
curv2_ppbezier_plot(ppC, np, 'r', 3);

% Calcolo errore di interpolazione
Cxy = ppbezier_val(ppC, t);
[x, y] = cp2_circle(t);
Qxy = [x', y'];
MaxErr = max(vecnorm((Cxy - Qxy)'));
fprintf("Massimo errore: %e\n", MaxErr);

% CIRCONFERENZA PICCOLA (sul bordo)

% Scala e trasla al bordo della circonferenza grande
S = get_mat_scale([0.3105, 0.3105]);
C = ppC.cp(1, :);
T = get_mat_trasl(C);
M = T * S;

ppC_small = ppC;
ppC_small.cp = point_trans(ppC_small.cp, M);
curv2_mdppbezier_plot(ppC_small, np, 'm', 3);

% INTERSEZIONI PER COSTRUIRE LA STELLA

% Ruota la circonferenza grande per evitare problemi con le intersezioni
R = get_mat2_rot(-pi/2);
temp = ppC;
temp.cp = point_trans(temp.cp, R);

% Trova intersezioni
[~, t1, t2] = curv2_intersect(temp, ppC_small);

% Estrai p1: parte della circonferenza grande (interno alla piccola)
[sx, ~] = ppbezier_subdiv(temp, t1(1));
[~, p1] = ppbezier_subdiv(sx, t1(2));

% Estrai p2: parte della circonferenza piccola (interno alla grande)
[~, dx] = ppbezier_subdiv(ppC_small, t2(1));
[p2, ~] = ppbezier_subdiv(dx, t2(2));

% pr: curva chiusa piccola rossa (intersezione)
pr = curv2_mdppbezier_join(p1, p2, tol);

% Estrai p3: parte esterna della circonferenza piccola
[sx, dx] = ppbezier_subdiv(ppC_small, t2(1));
[~, p3] = ppbezier_subdiv(dx, t2(2));
p3 = curv2_mdppbezier_join(sx, p3, tol);

% COSTRUZIONE PUNTA DELLA STELLA

alpha1 = (2*pi) / 10;  % Angolo per 10 rotazioni
R1 = get_mat2_rot(alpha1);

% Ruota p2 e unisci con p3 per formare una punta
p2.cp = point_trans(p2.cp, R1);
ps = curv2_mdppbezier_join(p2, p3, tol);
curv2_mdppbezier_plot(ps, np, 'g', 4);

% DISEGNO FINALE

open_figure(2);
col = [230, 230, 230] / 255;
set(gca, 'Color', col);

% Scudo verde
punti_scudo = curv2_mdppbezier_plot(ppP, -np, 'r', 3);
point_fill(punti_scudo, 'g', 'r', 4);

% Costruzione stella completa (5 punte)
alpha2 = (2*pi) / 5;
R2 = get_mat2_rot(alpha2);
stella = ps;

for i = 1:4
    ps.cp = point_trans(ps.cp, R2);
    stella = curv2_mdppbezier_join(stella, ps, tol);
end
stella = curv2_mdppbezier_close(stella);

% Cerchi rossi decorativi
pr.cp = point_trans(pr.cp, R1);
pr_points = curv2_mdppbezier_plot(pr, -np);
point_fill(pr_points, 'r', 'r', 4);

for i = 1:4
    pr.cp = point_trans(pr.cp, R2);
    pr_points = curv2_mdppbezier_plot(pr, -np);
    point_fill(pr_points, 'r', 'r', 2);
end

% Stella gialla
punti_stella = curv2_mdppbezier_plot(stella, -np, 'm', 3);
point_fill(punti_stella, 'y', 'r', 4);

% FUNZIONE LOCALE

function [x, y, xp, yp] = cp2_circle(t)
% Parametrizzazione circonferenza unitaria con derivate
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end