% =========================================================================
% SCRIPT: Pattern a eliche rotanti (stile ventola/turbina)
% =========================================================================
% Disegna un pattern circolare con 10 "eliche" alternate rosse e blu
% usando curve di Bézier, intersezioni e rotazioni
% =========================================================================

close all;
clear;
clc;

% PARAMETRI

n = 6;
np = 150;
tol = 1.0e-6;
param = 0;
a = 0;
b = 2*pi;

% CIRCONFERENZA ESTERNA

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

% Scala a raggio 11
S = get_mat_scale([11, 11]);
ppC.cp = point_trans(ppC.cp, S);
curv2_ppbezier_plot(ppC, np, 'b', 2);

% CURVA BASE DELL'ELICA

P = [
    5.2, 10.3;
    1.9,  8.3;
    2.0,  5.7;
    3.0,  3.2;
    3.1,  1.2;
    0.0,  0.0
    ];

ppP1 = curv2_bezier_interp(P, 0, 1, param);
curv2_bezier_plot(ppP1, np, 'r', 2);

% Seconda curva ruotata di 2π/20 = 18°
alpha = (2*pi) / 20;
R = get_mat2_rot(alpha);
ppP2 = ppP1;
ppP2.cp = point_trans(ppP2.cp, R);
curv2_bezier_plot(ppP2, np, 'm', 2);

% COSTRUZIONE SINGOLA ELICA (intersezioni e suddivisioni)

% Intersezioni con la circonferenza
[~, t1, t2] = curv2_intersect(ppC, ppP1);
[~, t3, t4] = curv2_intersect(ppC, ppP2);

% Suddivisioni per estrarre i pezzi
[~, p1] = ppbezier_subdiv(ppP1, t2);
[~, p2] = ppbezier_subdiv(ppP2, t4);
[~, dx] = ppbezier_subdiv(ppC, t1);
[p3, ~] = ppbezier_subdiv(dx, t3);

% Unione dei pezzi per formare l'elica
elica = curv2_mdppbezier_join(p1, p2, tol);
elica = curv2_mdppbezier_join(elica, p3, tol);
curv2_mdppbezier_plot(elica, np, 'cyan', 3);

% Calcolo lunghezza e area
lung = curv2_mdppbezier_len(elica);
area = curv2_mdppbezier_area(elica);
fprintf("Lunghezza della curva: %.4f\n", lung);
fprintf("Area della curva: %.4f\n", -area);

% DISEGNO FINALE CON 10 ELICHE ALTERNATE

open_figure(2);
col = [179, 255, 179] / 255;
set(gca, 'Color', col);

% Prima elica rossa
punti = curv2_mdppbezier_plot(elica, -np, 'k', 2);
point_fill(punti, 'r', 'b', 2);

% Rotazione di 36° (360°/10) per creare le altre 9 eliche
alpha = (2*pi) / 10;
R = get_mat2_rot(alpha);

for i = 1:9
    elica.cp = point_trans(elica.cp, R);
    punti = curv2_mdppbezier_plot(elica, -np);

    % Alterna colori: dispari blu, pari rosso
    if mod(i, 2) > 0
        point_fill(punti, 'b', 'r', 2);
    else
        point_fill(punti, 'r', 'b', 2);
    end
end

% FUNZIONE LOCALE

function [x, y, xp, yp] = cp2_circle(t)
% Parametrizzazione circonferenza unitaria con derivate
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end