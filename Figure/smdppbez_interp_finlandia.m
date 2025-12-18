% =========================================================================
% SCRIPT: Cerchio con croce (bandiera stile nordico)
% =========================================================================
% Disegna un cerchio con una croce blu all'interno usando curve di Bézier,
% intersezioni e trasformazioni geometriche
% =========================================================================

close all;
clear all;

% PARAMETRI

np = 30;
tol = 1.0e-2;

% CERCHIO ESTERNO

open_figure(1);

% Interpolazione cerchio con derivate
t = linspace(0, 2*pi, 8);
[x, y, xd, yd] = cerchio(t);
ppC = curv2_ppbezierCC1_interp_der([x', y'], [xd', yd'], t);
curv2_ppbezier_plot(ppC, 40, 'k-', 2, 'k');

% CERCHIO INTERNO (scalato al 97%)

ppCS = ppC;
S = get_mat_scale([0.97, 0.97]);
ppCS.cp = point_trans(ppCS.cp, S);
curv2_ppbezier_plot(ppCS, 40, 'k-', 2, 'k');

% RETTANGOLO VERTICALE

r1.ab = [0, 1, 2, 3, 4];
r1.deg = 1;
r1.cp = [
    -0.2,  1;
    -0.7,  1;
    -0.7, -1;
    -0.2, -1;
    -0.2,  1
    ];
curv2_ppbezier_plot(r1, np, 'k');
r1 = curv2_ppbezier_de(r1, 2);  % Eleva grado per compatibilità

% RETTANGOLO ORIZZONTALE

r2.ab = [0, 1, 2, 3, 4];
r2.deg = 1;
r2.cp = [
    -1,  0.25;
    -1, -0.25;
    1, -0.25;
    1,  0.25;
    -1,  0.25
    ];
curv2_ppbezier_plot(r2, np, 'k');
r2 = curv2_ppbezier_de(r2, 2);  % Eleva grado per compatibilità

% STRISCIA VERTICALE

% Intersezione cerchio-rettangolo verticale
[I, t1, t2] = curv2_intersect(ppCS, r1);

% Suddivisione curva sopra
[~, c1] = ppbezier_subdiv(ppCS, t1(3));
[c1, ~] = ppbezier_subdiv(c1, t1(2));

% Suddivisione rettangolo sinistra
[~, r11] = ppbezier_subdiv(r1, t2(2));
[r11, ~] = ppbezier_subdiv(r11, t2(1));

verticale1 = curv2_mdppbezier_join(c1, r11, tol);

% Suddivisione curva sotto
[~, c2] = ppbezier_subdiv(ppCS, t1(1));
[c2, ~] = ppbezier_subdiv(c2, t1(4));

% Suddivisione rettangolo destra
[~, r12] = ppbezier_subdiv(r1, t2(4));
[r12, ~] = ppbezier_subdiv(r12, t2(3));

verticale2 = curv2_mdppbezier_join(c2, r12, 1.0e-1);
verticale = curv2_mdppbezier_join(verticale1, verticale2, 1.0e-1);
curv2_ppbezier_plot(verticale, np, 'b');

% STRISCIA ORIZZONTALE

% Intersezione cerchio-rettangolo orizzontale
[I, t1, t2] = curv2_intersect(ppCS, r2);

% Suddivisione curva sinistra
[~, c2] = ppbezier_subdiv(ppCS, t1(1));
[c2, ~] = ppbezier_subdiv(c2, t1(2));

% Suddivisione rettangolo sinistra
[~, r21] = ppbezier_subdiv(r2, t2(3));
[r21, ~] = ppbezier_subdiv(r21, t2(1));

orizzontale1 = curv2_mdppbezier_join(c2, r21, tol);

% Parte destra per simmetria (ruota di 180°)
orizzontale2 = orizzontale1;
R = get_mat2_rot(pi);
orizzontale2.cp = point_trans(orizzontale2.cp, R);

orizzontale = curv2_mdppbezier_join(orizzontale1, orizzontale2, 1.0e-1);

% DISEGNO FINALE CON COLORI

open_figure(2);

% Bordo cerchio esterno
curv2_ppbezier_plot(ppC, 40, 'k-', 2, 'k');

% Striscia verticale blu
Px = curv2_ppbezier_plot(verticale, -np);
point_fill(Px, 'b');

% Striscia orizzontale blu
Px = curv2_ppbezier_plot(orizzontale, -np);
point_fill(Px, 'b');

% FUNZIONE LOCALE

function [x, y, xd, yd] = cerchio(t)
% Parametrizzazione circonferenza unitaria con derivate
x = cos(t);
y = sin(t);
xd = -sin(t);
yd = cos(t);
end