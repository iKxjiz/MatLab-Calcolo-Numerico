%script smdppbez_cuore_france.m
function main()
close all
clc

open_figure(1);
axis_plot(0.2, 0.02, 0.43);
axis equal;
hold on;

np = 200;
n = 6;
d = 0.009;
param = 0;

% Carica curva di Bézier cuore di grado 9
bezP = curv2_bezier_load('c2_bezier_heart.db');
a = bezP.ab(1);
b = bezP.ab(2);
c = (a + b) / 2;

% Plot curva originale
curv2_bezier_plot(bezP, np, 'k', 1);

%% INTERPOLAZIONE METÀ DESTRA (VERDE)
% Genera parametri di Chebyshev solo per la metà destra [a, c]
t = chebyshev2(a, c, n);

% Valuta la curva originale nei parametri di Chebyshev
points_cheb = decast_val(bezP, t);
x = points_cheb(:, 1);
y = points_cheb(:, 2);

% Calcola la base di Bernstein
tt = (t - a) ./ (c - a);
B = bernst_val(n, tt);

% Risolvi il sistema lineare
cx = B \ x;
cy = B \ y;

% Crea la nuova curva di Bézier interpolata (parte verde)
bezP_verde. deg = n;
bezP_verde.ab = [a, c];
bezP_verde.cp = [cx, cy];

% Plot curva interpolata verde
curv2_bezier_plot(bezP_verde, np, 'g', 2);

%% CURVA OFFSET (MAGENTA)
% Genera la curva offset della curva verde
bezP_os = curv2_bezier_offset(bezP_verde, d);
curv2_mdppbezier_plot(bezP_os, np, 'm', 2);

%% RETTA VERTICALE
% Crea la retta verticale x = 0.07
r1_points = [0.07 0; 0.07 0.4];
r1 = curv2_bezier_interp(r1_points, 0, 1, param);
curv2_bezier_plot(r1, 30, 'r', 2);

%% INTERSEZIONI (WORKAROUND MANUALE)
% Invece di usare curv2_intersect, valutiamo manualmente i punti

% Valuta la retta
np_int = 100;
r1_xy = curv2_bezier_plot(r1, -np_int);
t_r1 = linspace(r1.ab(1), r1.ab(2), np_int);

% Valuta la curva offset (mdppbezier)
bezP_os_xy = curv2_mdppbezier_plot(bezP_os, -np_int);
nc = length(bezP_os. ab) - 1;
t_os = [];
for i = 1:nc
    t_os = [t_os, linspace(bezP_os.ab(i), bezP_os.ab(i+1), np_int)];
end

% Usa InterX per trovare le intersezioni
IP1 = InterX(r1_xy', bezP_os_xy');

if ~isempty(IP1)
    fprintf('Trovate %d intersezioni tra retta e curva offset\n', size(IP1, 2));
    point_plot(IP1', 'ko', 2, 'k', 'y', 8);

    % Trova i parametri delle intersezioni
    for i = 1:size(IP1, 2)
        % Per la retta
        [~, k] = gc_dist3(IP1(1,i), IP1(2,i), r1_xy(: ,1), r1_xy(:,2));
        t1_r(i) = t_r1(k(1));

        % Per la curva offset
        [~, k] = gc_dist3(IP1(1,i), IP1(2,i), bezP_os_xy(:,1), bezP_os_xy(:,2));
        t1_os(i) = t_os(k(1));
    end
end

% Intersezione tra retta e curva verde (questa funziona)
[IP2, t2_r, t2_verde] = curv2_intersect(r1, bezP_verde);
fprintf('Trovate %d intersezioni tra retta e curva verde\n', length(t2_r));
if ~isempty(IP2)
    point_plot(IP2', 'ko', 2, 'k', 'c', 8);
end

%% PARTE SIMMETRICA (BLU)
% Genera la parte simmetrica rispetto all'asse y (x=0)
S = get_mat2_symm([0, 0], [0, 1]); % Simmetria rispetto all'asse y

% Curva verde simmetrica (blu)
bezP_blu = bezP_verde;
bezP_blu.cp = point_trans(bezP_verde.cp, S);
curv2_bezier_plot(bezP_blu, np, 'b', 2);

% Curva offset simmetrica
bezP_os_sym = bezP_os;
bezP_os_sym.cp = point_trans(bezP_os.cp, S);
curv2_mdppbezier_plot(bezP_os_sym, np, 'c', 2);

%% COLORAZIONE FINALE
open_figure(2);
axis equal;
axis off;
hold on;

% Disegna e colora le regioni
% REGIONE BLU (sinistra)
Pxy_blu = curv2_bezier_plot(bezP_blu, -np);
point_fill(Pxy_blu, [0, 0.35, 0.78], 'k', 2);

% REGIONE BIANCA (centro - tra offset e curva verde)
Pxy_offset_sym = curv2_mdppbezier_plot(bezP_os_sym, -np);
point_fill(Pxy_offset_sym, [1, 1, 1], 'k', 2);

% REGIONE ROSSA (destra)
Pxy_verde = curv2_bezier_plot(bezP_verde, -np);
point_fill(Pxy_verde, [0. 93, 0.16, 0.22], 'k', 2);

% Bordo esterno
curv2_bezier_plot(bezP, np, 'k', 3);

title('Cuore Bandiera Francia - Curve di Bézier');

fprintf('Script completato!\n');
end

%% Funzioni Locali
function x = chebyshev2(a, b, n)
% Punti di Chebyshev di seconda specie
for i = 0:n
    x(i+1) = 0.5 * (a + b) + 0.5 * (a - b) * cos(i * pi / n);
end
end

function [vval, vind] = gc_dist3(x0, y0, x, y)
% Determina i tre punti più vicini a (x0,y0)
vdist = sqrt((x0-x).^2 + (y0-y).^2);
[val, ind] = min(vdist);
vval(1) = val;
vind(1) = ind;
vdist(ind) = realmax;
[val, ind] = min(vdist);
vval(2) = val;
vind(2) = ind;
vdist(ind) = realmax;
[val, ind] = min(vdist);
vval(3) = val;
vind(3) = ind;
end