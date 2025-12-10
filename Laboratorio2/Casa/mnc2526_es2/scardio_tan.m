clear all;
clc;

open_figure(1);
axis_plot(4, 0.5);

% Parametri
a = 0;
b = 2*pi;
np = 150;

% Punto in cui calcola la tangente e la disegna
tbar = pi/2; % Parametro del punto dove calcolare la tangente

% Disegna la curva
curv2_plot('c2_cardioide', a, b, np, 'b-', 2);

% Calcola il punto P0 = C(tbar)
[P0_x, P0_y] = c2_cardioide(tbar);
P0 = [P0_x, P0_y];
% Disegna il punto P0
point_plot(P0, 'bo', 2, 'b');

% Calcola il punto e il vettore tangente
[P0_x, P0_y, vT_x, vT_y] = cp2_cardioide(tbar);
vT = [vT_x, vT_y];

% Il vettore vT è normalizzato? ||C'(t)|| = sqrt(x'(t)² + y'(t)²)
% NO! Ha la lunghezza della velocità
modulo_vT = norm(vT, 2);
fprintf('Modulo del vettore tangente: %.4f\n', modulo_vT);
% Disegna il vettore tangente
vect2_plot(P0, vT, 'r-', 2);
% Opzionale: disegna anche il versore tangente normalizzato
vT_norm = vT / modulo_vT;
vect2_plot(P0, vT_norm, 'g-', 2);
legend('Cardioide', 'Punto P0', 'Vettore tangente', 'Versore tangente');
