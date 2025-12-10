%script di esempio
function main()
close all
clc
open_figure(1);
axis_plot(0.2, 0.02, 0.43);
grid on;

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

bezP_os = curv2_bezier_offset(bezP2, d);
curv2_mdppbezier_plot(bezP_os, np, 'm', 2);

% Crea la retta con intervallo [0, 1]
r1.ab = [0 0.3 0.6 1];
r1.deg = [1 1 1];
r1.cp = [0.07 0; 0.07 0.13; 0.07 0.26; 0.07 0.4];

curv2_mdppbezier_plot(r1, np, 'r', 2);
[IP1P2, t1, t2] = curv2_intersect(r1, bezP_os);


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

