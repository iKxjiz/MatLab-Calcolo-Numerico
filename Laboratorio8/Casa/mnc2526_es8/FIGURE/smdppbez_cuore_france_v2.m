function main()
close all
clc

%% Parametri iniziali
np = 100;           % numero di punti per il plot
tol = 1.0e-4;       % tolleranza per il join
d = 0.009;          % distanza per l'offset
param = 0;          % parametro di interpolazione

%% Caricamento e visualizzazione curva originale
open_figure(1);

% Carica curva di Bézier cuore di grado 9
bezP = curv2_bezier_load('c2_bezier_heart.db');
a = bezP.ab(1);
b = bezP.ab(2);
c = (a + b) / 2;

curv2_bezier_plot(bezP, np, 'b-', 1.5);

%% Interpolazione della curva
% Campionamento di n+1 punti sulla prima metà della curva
n = 6;
t = linspace(a, c, n+1);
Q = ppbezier_val(bezP, t);
point_plot(Q, 'bo', 2);

% Interpolazione con nuova curva di Bézier
bezQ = curv2_bezier_interp(Q, a, b, param);
curv2_bezier_plot(bezQ, np, 'g');

%% Riflessione simmetrica della curva
S = get_mat2_symm([0 0], [0 1]);
bezR = bezQ;
bezR.cp = point_trans(bezR.cp, S);
curv2_bezier_plot(bezR, np, 'r');

%% Join delle curve e verifica errore
ppP = curv2_mdppbezier_join(bezQ, bezR, tol);

open_figure(2);
curv2_mdppbezier_plot(ppP, np, 'k', 2);
curv2_bezier_plot(bezQ, np, 'g', 2);

% Stima dell'errore di interpolazione
npt = 150;
t = linspace(a, b, npt);
Pxy = ppbezier_val(ppP, t);
[x, y] = cp2_circle(t);
Qxy = [x', y'];
MaxErr = max(vecnorm((Pxy - Qxy)'));
fprintf("Massimo errore %e\n", MaxErr);

%% Curva offset e segmento verticale
mdppbezQ = curv2_bezier_offset(bezQ, d);
curv2_mdppbezier_plot(mdppbezQ, np, 'm', 3);

% Ridefinizione del grado per consistenza
if length(mdppbezQ.deg) > 1
    mdppbezQ.deg = mdppbezQ.deg(1);
end

% Definizione segmento verticale
ppL1.cp = [0.055 0; 0.055 0.4];
ppL1.deg = 1;
ppL1.ab = [0, 1];
curv2_ppbezier_plot(ppL1, np, 'r', 2);

%% Intersezione e suddivisione
open_figure(3);
curv2_bezier_plot(ppP, np, 'k', 2);
curv2_bezier_plot(bezQ, np, 'g', 2);
curv2_mdppbezier_plot(mdppbezQ, np, 'm', 3);
curv2_bezier_plot(ppL1, np, 'r', 2);

% Calcolo punti di intersezione
[IP1P2, t1, t2] = curv2_intersect(mdppbezQ, ppL1);

% Prima suddivisione
[sx1, dx1] = ppbezier_subdiv(mdppbezQ, t1(1));
curv2_mdppbezier_plot(sx1, np, 'r', 3);

% Seconda suddivisione
[sx2, dx2] = ppbezier_subdiv(dx1, t1(2));
curv2_mdppbezier_plot(sx2, np, 'b', 3);
curv2_mdppbezier_plot(dx2, np, 'r', 3);

%% Chiusura e riflessione finale
open_figure(4);
curv2_bezier_plot(bezP, np, 'k', 2);

% Chiusura della curva destra
ppS = curv2_mdppbezier_close(sx2);
punti_dx = curv2_mdppbezier_plot(ppS, -np, 'b', 3);

% Riflessione per ottenere la curva sinistra
ppT = ppS;
ppT.cp = point_trans(ppT.cp, S);
punti_sx = curv2_mdppbezier_plot(ppT, -np, 'b', 3);

% Riempimento dei punti
point_fill(punti_sx, 'b');
point_fill(punti_dx, 'r');

end