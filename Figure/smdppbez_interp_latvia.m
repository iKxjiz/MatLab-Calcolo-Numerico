% =========================================================================
% SCRIPT: Cerchio con fasce orizzontali (stile bandiera)
% =========================================================================
% Disegna un cerchio con due fasce rosse (sopra e sotto) usando curve di
% Bézier, intersezioni e trasformazioni geometriche
% =========================================================================

close all;
clear all;

% PARAMETRI

np = 40;
tol = 1.0e-2;
a = 0;
b = 2*pi;
m = 8;

% CERCHIO ESTERNO

open_figure(1);

% Interpolazione cerchio con derivate
t = linspace(a, b, m);
[x, y, xder, yder] = cerchio(t);
Q = [x', y'];
Q1 = [xder', yder'];

c1 = curv2_ppbezierCC1_interp_der(Q, Q1, t);
curv2_ppbezier_plot(c1, np, 'k');

% CERCHIO INTERNO (scalato al 97%)

S = get_mat_scale([0.97, 0.97]);
c2 = c1;
c2.cp = point_trans(c2.cp, S);

% SEGMENTO ORIZZONTALE (per intersezione)

ppB.deg = 1;
ppB.ab = [0, 1];
ppB.cp = [
    -1.1, -0.2;
    1.2, -0.2
    ];
ppB = curv2_ppbezier_de(ppB, 2);  % Eleva grado per compatibilità

% INTERSEZIONE

[c, t1, t2] = curv2_intersect(c2, ppB);

% FASCIA INFERIORE

% Suddivisione segmento
[~, s] = ppbezier_subdiv(ppB, t2(1));
[t_seg, ~] = ppbezier_subdiv(s, t2(2));

% Suddivisione cerchio
[~, ss] = ppbezier_subdiv(c2, t1(1));
[tt, ~] = ppbezier_subdiv(ss, t1(2));

% Unione
sotto = curv2_mdppbezier_join(t_seg, tt, tol);
Px = curv2_ppbezier_plot(sotto, -20, 'r');
point_fill(Px, 'r');

% FASCIA SUPERIORE (per simmetria)

R = get_mat2_rot(pi);
sopra = sotto;
sopra.cp = point_trans(sopra.cp, R);
Px = curv2_ppbezier_plot(sopra, -20, 'r');
point_fill(Px, 'r');

% FUNZIONE LOCALE

function [x, y, xder, yder] = cerchio(t)
% Parametrizzazione circonferenza unitaria con derivate
x = cos(t);
y = sin(t);
xder = -sin(t);
yder = cos(t);
end