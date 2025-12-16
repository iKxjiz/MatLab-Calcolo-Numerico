%==========================================================================
% Script: sppbezierinterp_curve2d_bicorn.m
%==========================================================================
% DESCRIZIONE:
%   Interpolazione di due curve parametriche (bicorn) mediante curve di
%   Bézier, calcolo intersezioni, costruzione curva chiusa e rotazione.
%==========================================================================

function main()
close all;
clc

%% PARAMETRI
mp = 100;
a = -1;
b = 1;

%% FIGURA 1: INTERPOLAZIONE
open_figure(1);
axis_plot(1.5, 0.125);
hold on;
grid on;
[x_plot, y1_plot] = curv2_plot('c2_bicorn1', a, b, mp, 'k-', 1.5);
[x_plot, y2_plot] = curv2_plot('c2_bicorn2', a, b, mp, 'k-', 1.5);

n = 4;
tipo = 2;
% Selezione punti
if tipo == 1
    t = linspace(a, b, n+1);
else
    t = chebyshev2(a, b, n);
end

% Campionamento
[x, y1] = c2_bicorn1(t);
[x, y2] = c2_bicorn2(t);

x = x(:);
y1 = y1(:);
y2 = y2(:);

Q1 = [x, y1]; Q2 = [x, y2];
point_plot(Q1, 'bo', 6, 'b');
point_plot(Q2, 'ro', 6, 'r');

% Interpolazione con Bézier
tt = (t - a) / (b - a);

B = bernst_val(n, tt);

cx = B \ x;
cy1 = B \ y1;
cy2 = B \ y2;

% Curve di Bézier
Pbez1.deg = n;
Pbez1.ab = [a, b];
Pbez1.cp = [cx, cy1];

Pbez2.deg = n;
Pbez2.ab = [a, b];
Pbez2.cp = [cx, cy2];

curv2_bezier_plot(Pbez1, mp, 'b', 2);
curv2_bezier_plot(Pbez2, mp, 'r', 2);

point_plot(Pbez1.cp(1,:), 'ko', 10);
point_plot(Pbez2.cp(1,:), 'ko', 10);

% Intersezioni
[IP1P2, t1, t2] = curv2_intersect(Pbez1, Pbez2);

if length(t1) == 0,
    error('Nessuna intersezione trovata!');
end
point_plot(IP1P2', 'go', 1, 'g', 'g', 8);

%% FIGURA 2: CURVA CHIUSA
open_figure(2);
axis_plot(1.5, 0.125);
hold on;
grid on;
axis equal;
title('Curva chiusa ottenuta da tratti interpolanti');

% Estrazione tratti centrali
[p1_sx, p1] = decast_subdiv(Pbez1, t1(1));
[p1, p1_dx] = decast_subdiv(p1, t1(2));

[p2_sx, p2] = decast_subdiv(Pbez2, t2(1));
[p2, p2_dx] = decast_subdiv(p2, t2(2));

% Costruzione e chiusura curva
tol = 1.0e-2;
ppQ = curv2_mdppbezier_join(p1, p2, tol);
ppQ = curv2_mdppbezier_close(ppQ);

Px = curv2_ppbezier_plot(ppQ, -100);
point_fill(Px, 'g', 'b', 1.5);

% Trasformazione
C = ppQ.cp(1,:);
T = get_mat_trasl(-C);
T1 = get_mat_trasl([0.25, 0]);

% Matrice composta
M = T1 * T;

ppQ.cp = point_trans(ppQ.cp, M);
curv2_ppbezier_plot(ppQ, 30);

%% FIGURA 3: ROTAZIONI
open_figure(3);
set(gca,'color',[1.0,1.0,0.8]);
hold on;
axis equal;
title('Rotazioni multiple della curva chiusa');

ncurv = 12;
bezQ = ppQ;
teta = linspace(0, 2*pi, ncurv);
np = 50;

for i = 1:ncurv
    R = get_mat2_rot(teta(i));
    bezQ.cp = point_trans(ppQ.cp, R);
    Px_rot = curv2_ppbezier_plot(bezQ, -np, 'b-', 1.5);
    point_fill(Px_rot, 'g', 'b', 3);
end

end
