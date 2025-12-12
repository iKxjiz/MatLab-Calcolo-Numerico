%script di esempio
function main()
close all
clc
open_figure(1);

np = 100;
n = 6;
tol = 1.0e-2;
d = 0.009;
param = 0;

% Carica curva di Bézier cuore di grado 9
bezP = curv2_bezier_load('c2_bezier_heart.db');
a = bezP.ab(1);
b = bezP.ab(2);
c = (a + b) / 2;

% Plot curva originale
curv2_bezier_plot(bezP, np, 'b', 3);

% Genera parametri di Chebyshev
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

% Crea la nuova curva di Bézier
bezP2.deg = n;
bezP2.ab = [a, c];
bezP2.cp = [cx, cy];

% Plot curva approssimata
curv2_bezier_plot(bezP2, np, 'g', 3);

r1 = [0.05 0; 0.05 0.4];
r1 = curv2_bezier_interp(r1, 0, 1, param);
curv2_ppbezier_plot(r1, 30, 'r', 2);

[IP1P2, t1, t2] = curv2_intersect(r1, bezP2);
IP1P2 = IP1P2';

point_plot(IP1P2(1,:), 'ko', 10, 'k', 'k', 4);
point_plot(IP1P2(2,:), 'ro', 10, 'r', 'r', 4);

open_figure(2);

curv2_bezier_plot(bezP, np, 'k', 3);

[~, p1_dx] = ppbezier_subdiv(bezP2, t2(1));
%curv2_ppbezier_plot(p1_dx, np, 'r', 2);
%curv2_ppbezier_plot(p1_sx, np, 'b', 2);
[p2_sx, ~] = ppbezier_subdiv(p1_dx, t2(2));
%curv2_ppbezier_plot(p2_dx, np, 'r', 2);
%curv2_ppbezier_plot(p2_sx, np, 'b', 2);

curv_dx = p2_sx;

curv_dx = curv2_bezier_offset(curv_dx, d);
%curv2_mdppbezier_plot(curv_dx, np, 'm', 2);
curv_dx = curv2_mdppbezier_close(curv_dx);
curv_dx_points = curv2_mdppbezier_plot(curv_dx, -np, 'm', 2);
point_fill(curv_dx_points, 'r');

S = get_mat2_symm([0 0],[0 0.4]);

curv_sx = curv_dx;
curv_sx.cp = point_trans(curv_sx.cp, S);
curv_sx_points = curv2_mdppbezier_plot(curv_sx, -np, 'm', 2);
point_fill(curv_sx_points, 'b');

end

%% Funzioni Locali :
function x=chebyshev2( a,b,n )
%input:
%  a,b --> estremi intervalo in cui mappare i punti
%  n+1 --> numero di zeri del polinomio di Chebyshev di grado n+1
%punti di Chebishev seconda specie
for i=0:n
    x(i+1)=0.5.*(a+b)+0.5.*(a-b).*cos(i*pi/n);
end
end

