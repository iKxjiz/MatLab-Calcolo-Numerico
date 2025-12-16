% Esercizio d'esame di MNC2324
% Fare uno script per riprodurre il seguente disegno.
% Ricostruire la curva esterna per interpolazione della seguente curva
% in forma paramaterica: [x = r*cos(t), y = r*sin(t)] per t [0,2*pi]
% dove r=(abs(cos(t)/2)^5+abs(sin(t))^5)^(-1/5), con una curva di
% di Bézier a tratti con errore di interpolazione MaxErr <= 0.5e-02.
% La curva interna sia una curva di Bézier a tratti di grado 1.

clear; clc; close all;
open_figure(1);
grid on;

% Parametri
tol = 1.0e-6;
np = 50;
a = 0;
b = 2*pi;

t = linspace(a, b, np);
[x, y] = cp2_curv(t);
Q = [x', y'];
ppP = curv2_ppbezierCC1_interp(Q, a, b, 0);

% Calcolo dell'errore :
t = linspace(a, b, np);
Pxy = ppbezier_val(ppP, t);
[xc, yc] = cp2_curv(t);
Cxy = [xc', yc'];

MaxErr = max((vecnorm(Pxy-Cxy)'));
fprintf('MaxErr: %e\n',MaxErr);

curv2_ppbezier_plot(ppP, np, 'b', 2);

% Costruisco il rettangolo :
rect.cp = [
    1.3 -0.3;
    1.3 0.3;
    -1.3 0.3;
    -1.3 -0.3;
    1.3 -0.3;
    ];
rect.ab = linspace(0, 1, length(rect.cp(:,1)));
rect.deg = 1;

curv2_ppbezier_plot(rect, np, 'b', 2);

open_figure(2);

% Metto in posizione il rettangolo come il rettangolo verde
R = get_mat2_rot(pi/4);
ppP_dx = ppP;
ppP_dx.cp = point_trans(ppP_dx.cp, R);
rect_dx = rect;
rect_dx.cp = point_trans(rect_dx.cp, R);
curv2_ppbezier_plot(ppP_dx , np, 'b', 2);
curv2_ppbezier_plot(rect_dx , np, 'b', 2);
point_plot(ppP_dx.cp(1,:), 'ko', 10);
point_plot(rect_dx.cp(1,:), 'ko', 10);

% cerco bar per np = 1000 una volta sola perchè non mi dia problemi (crash) nel codice più avanti
%bar = mean(Pxy);
bar = [0.0020 0];
Qr_vert = [bar; bar(1, 1) 1];
%point_plot(Qr_vert, 'r', 3)
Qr_oriz = [bar; 1 bar(1, 2)];
%point_plot(Qr_oriz, 'r', 3)


Sy1 = get_mat2_symm(Qr_vert(1, :), Qr_vert(2, :));

ppP_sx = ppP_dx;
ppP_sx.cp = point_trans(ppP_sx.cp, Sy1);
rect_sx = rect_dx;
rect_sx.cp = point_trans(rect_sx.cp, Sy1);
curv2_ppbezier_plot(ppP_sx , np, 'r', 2);
curv2_ppbezier_plot(rect_sx , np, 'r', 2);

% trovo le intersezioni :
[~, v1, v2] = curv2_intersect(ppP_dx, ppP_sx);
[~, v3, v4] = curv2_intersect(ppP_dx, rect_sx);
[~, v5, v6] = curv2_intersect(ppP_sx, rect_dx);
[~, v7, v8] = curv2_intersect(rect_sx, rect_dx);

[sx, ~] = ppbezier_subdiv(ppP_dx, v1(3));
% sx va unito a destra con l'altro pezzo
%curv2_ppbezier_plot(sx, np, 'g',4);
%curv2_ppbezier_plot(dx, np, 'y',4);

[~, dx] = ppbezier_subdiv(ppP_dx, v3(3));
%curv2_ppbezier_plot(sx, np, 'g',4);
%curv2_ppbezier_plot(dx, np, 'y',4);

lato_est_verd = curv2_mdppbezier_join(sx, dx, tol);

% lato interno :
[sx, ~] = ppbezier_subdiv(rect_dx, v6(3));
%curv2_ppbezier_plot(sx, np, 'g',4);
%curv2_ppbezier_plot(dx, np, 'y',4);
[~, dx] = ppbezier_subdiv(rect_dx, v8(3));
%curv2_ppbezier_plot(sx, np, 'g',4);
%curv2_ppbezier_plot(dx, np, 'y',4);

lato_inter_verd = curv2_mdppbezier_join(sx, dx, tol);

open_figure(3);
curv2_ppbezier_plot(ppP_dx , np, 'b', 2);
curv2_ppbezier_plot(rect_dx , np, 'b', 2);
curv2_mdppbezier_plot(lato_est_verd, np, 'm', 3);
curv2_mdppbezier_plot(lato_inter_verd, np, 'y', 3);

lato_verde_sup = curv2_mdppbezier_join(lato_est_verd, lato_inter_verd, tol);
lato_verde_sup = curv2_mdppbezier_close(lato_verde_sup);

open_figure(4);
curv2_ppbezier_plot(ppP_dx , np, 'b', 2);
curv2_ppbezier_plot(rect_dx , np, 'b', 2);
curv2_mdppbezier_plot(lato_verde_sup, np, 'm', 4);

Sy2 = get_mat2_symm(Qr_oriz(1, :), Qr_oriz(2, :));
lato_blu_sup = lato_verde_sup;
lato_blu_sup.cp = point_trans(lato_blu_sup.cp, Sy2);
curv2_mdppbezier_plot(lato_blu_sup, np, 'k', 4);


% Funzioni Locali :
function [x, y] = cp2_curv(t)
r = (abs(cos(t)/2).^5+abs(sin(t)).^5).^(-1/5);
x = r.*cos(t);
y = r.*sin(t);
end
