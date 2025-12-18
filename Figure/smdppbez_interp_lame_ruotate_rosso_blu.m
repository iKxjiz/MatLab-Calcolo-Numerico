% =========================================================================
% SCRIPT: Ventola con lame rotanti e cerchi verdi
% =========================================================================
% Disegna una ventola con 12 lame alternate (rosse/blu) e 6 elementi verdi
% tra due circonferenze concentriche
% =========================================================================

close all;
clear;
clc;

%% ========================================================================
% PARAMETRI
% =========================================================================

n = 8;
np = 150;
tol = 1.0e-6;
param = 0;
a = 0;
b = 2*pi;

%% ========================================================================
% CIRCONFERENZA BASE
% =========================================================================

open_figure(1);
grid on;

% Interpolazione cerchio con derivate
t = linspace(a, b, n+1);
[x, y, x1, y1] = cp2_circle(t);
Q = [x', y'];
Q1 = [x1', y1'];
ppC = curv2_ppbezierCC1_interp_der(Q, Q1, t);

% Stima errore di interpolazione
npt = 200;
t = linspace(a, b, npt);
Cxy = ppbezier_val(ppC, t);
[x, y] = cp2_circle(t);
Qxy = [x', y'];
MaxErr = max(vecnorm((Cxy - Qxy)'));
fprintf("Massimo errore: %e\n", MaxErr);

if MaxErr <= 2.0e-03
    fprintf("L'errore è contenuto\n");
else
    fprintf("L'errore NON è contenuto\n");
end

%% ========================================================================
% DUE CIRCONFERENZE CONCENTRICHE
% =========================================================================

% Circonferenza esterna (raggio 0.75)
ppC1 = ppC;
ppC1.cp = point_trans(ppC1.cp, get_mat_scale([0.75, 0.75]));
curv2_ppbezier_plot(ppC1, np, 'k', 2);

% Circonferenza interna (raggio 0.6)
ppC2 = ppC;
ppC2.cp = point_trans(ppC2.cp, get_mat_scale([0.6, 0.6]));
curv2_ppbezier_plot(ppC2, np, 'k', 2);

%% ========================================================================
% COSTRUZIONE LAMA BASE
% =========================================================================

% Curva superiore della lama
P1 = [
    0.0,  0.0;
    0.037, 0.14;
    0.19, 0.44;
    0.54, 0.73
    ];
ppP1 = curv2_bezier_interp(P1, 0, 1, param);

% Curva inferiore della lama (invertita)
P2 = [
    0.7, 0.53;
    0.3, 0.4;
    0.0, 0.0
    ];
ppP2 = curv2_bezier_interp(P2, 0, 1, param);
ppP2 = curv2_bezier_reverse(ppP2);

% Segmento di chiusura
P3 = [ppP1.cp(end, :); ppP2.cp(end, :)];
ppP3 = curv2_bezier_interp(P3, 0, 1, param);

% Unione completa della lama
ppP = curv2_mdppbezier_join(ppP1, ppP2, tol);
ppP = curv2_mdppbezier_close(ppP);
ppP = curv2_mdppbezier_join(ppP, ppP3, tol);

curv2_mdppbezier_plot(ppP1, np, 'r', 2);
curv2_mdppbezier_plot(ppP2, np, 'b', 2);
curv2_mdppbezier_plot(ppP3, np, 'g', 2);

%% ========================================================================
% TRASFORMAZIONE E INTERSEZIONI PER ELEMENTO VERDE
% =========================================================================

open_figure(2);
curv2_ppbezier_plot(ppC1, np, 'k', 2);
curv2_ppbezier_plot(ppC2, np, 'k', 2);

% Rotazione + Traslazione della lama
alpha = -pi/3;
R = get_mat2_rot(alpha);
T = get_mat_trasl([0, 0.2]);
M = T * R;

ppP.cp = point_trans(ppP.cp, M);
ppP1.cp = point_trans(ppP1.cp, M);

% ppP2 con rotazione diversa
M2 = get_mat2_rot(-alpha) * M;
ppP2.cp = point_trans(ppP2.cp, M2);

% Intersezioni
[~, t1, t2] = curv2_intersect(ppC1, ppP1);
[~, t3, t4] = curv2_intersect(ppC1, ppP2);
[~, t5, t6] = curv2_intersect(ppC2, ppP1);
[~, t7, t8] = curv2_intersect(ppC2, ppP2);

% Arco superiore (circonferenza esterna)
[p1, ~] = ppbezier_subdiv(ppC1, t3);
[~, p2] = ppbezier_subdiv(p1, t1);

% Arco inferiore (circonferenza interna)
[~, p3] = ppbezier_subdiv(ppC2, t5);
[p4, ~] = ppbezier_subdiv(p3, t7);

% Lato destro (curva ppP1)
[p5, ~] = ppbezier_subdiv(ppP1, t2);
[~, p6] = ppbezier_subdiv(p5, t6);

% Lato sinistro (curva ppP2)
[p7, ~] = ppbezier_subdiv(ppP2, t4);
[~, p8] = ppbezier_subdiv(p7, t8);

% Unione elemento verde
circ_verd = curv2_mdppbezier_join(p4, p8, tol);
circ_verd = curv2_mdppbezier_join(circ_verd, curv2_mdppbezier_join(p2, p6, tol), tol);
circ_verd_points = curv2_mdppbezier_plot(circ_verd, np, 'r', 2);

%% ========================================================================
% DISEGNO FINALE
% =========================================================================

open_figure(3);
set(gca, 'Color', [0, 1, 1]);  % Sfondo ciano

% Prima lama rossa
punti = curv2_mdppbezier_plot(ppP, -np);
point_fill(punti, 'r', 'b', 2);

% 12 lame con rotazione di 30° (pi/6)
Rlam = get_mat2_rot(pi/6);
for i = 1:11
    ppP.cp = point_trans(ppP.cp, Rlam);
    punti = curv2_mdppbezier_plot(ppP, -np);

    if mod(i, 2) > 0
        point_fill(punti, 'b', 'b', 2);
    else
        point_fill(punti, 'r', 'b', 2);
    end
end

% 6 elementi verdi con rotazione di 60° (2*pi/6)
Rcirc = get_mat2_rot((2*pi)/6);
point_fill(circ_verd_points, 'g', 'b', 2);

for i = 1:5
    circ_verd.cp = point_trans(circ_verd.cp, Rcirc);
    punti = curv2_mdppbezier_plot(circ_verd, -np);
    point_fill(punti, 'g', 'b', 2);
end

%% ========================================================================
% FUNZIONE LOCALE
% =========================================================================

function [x, y, xp, yp] = cp2_circle(t)
% Parametrizzazione circonferenza unitaria con derivate
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end