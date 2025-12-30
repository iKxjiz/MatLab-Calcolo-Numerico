%script sppbezierinterp_curve2d.m
%Interpolazione con curva cubica a tratti C^1 di Hermite (interpolazione di
%valori e derivate) di una curva in forma parametrica (cp2_circle.m)
clear
close all
col = ['r','g','b','k'];
open_figure(1);
grid on;
hold on;

%% Punti della curva da interpolare; parametri equispaziati
m = 6;
a = 0;
b = 2*pi;
tpar = linspace(a, b, m);

%% Campiona valori e derivate (punti e tangenti)
[xp, yp, xp1, yp1] = cp2_circle(tpar);
Q = [xp', yp'];
Q1 = [xp1', yp1'];

%% Disegna i punti da interpolare
point_plot(Q, 'k:o', 1, 'k');

%% Disegna la curva analitica originale
curv2_plot('cp2_circle', a, b, 100, 'r', 1);

%% Chiama function curv2_ppbezierCC1_interp_der per interpolare
ppP = curv2_ppbezierCC1_interp_der(Q, Q1, tpar);

%vedi help : curv2_ppbezierCC1_interp_der

%% 1. Punti equispaziati per test sull'errore
npt = 100;
t = linspace(a, b, npt);

%% 2. Valuta curva interpolante usando ppbezier_val (SENZA disegnare)
Pxy = ppbezier_val(ppP, t);

%vedi help : ppbezier_val

%% 3. Valuta curva analitica
[x, y] = cp2_circle(t);
Qxy = [x', y'];

%% 4. Calcola l'errore di interpolazione
% Errore separato per X e Y
MaxErrX = max(abs(Pxy(:,1) - Qxy(:,1)));
MaxErrY = max(abs(Pxy(:,2) - Qxy(:,2)));

% Errore euclideo (distanza tra i punti)
errori_euclidei = vecnorm(Pxy - Qxy, 2, 2);  % Norma euclidea per ogni riga
MaxErr = max(errori_euclidei);

% calcola l'errore di interpolazione (distanza euclidea fra i punti
% della curva analitica e della curva cubica di Bézier a tratti
% interpolante) e considera il valore massimo

%% Stampa risultati
fprintf('\n=== ANALISI ERRORE DI INTERPOLAZIONE ===\n');
fprintf('Numero di punti di interpolazione: %d\n', m);
fprintf('Numero di punti di valutazione: %d\n', npt);
fprintf('Errore massimo in X: %e\n', MaxErrX);
fprintf('Errore massimo in Y: %e\n', MaxErrY);
fprintf('Errore massimo Euclideo: %e\n', MaxErr);
fprintf('=========================================\n\n');

%% Disegna la curva interpolante
curv2_ppbezier_plot(ppP, 50, 'b', 2);

%% Aggiungi legenda
legend('Punti di interpolazione', 'Curva analitica (cerchio)', ...
    'Curva interpolante (Bézier C^1)', 'Location', 'best');
title('Interpolazione C^1 di Hermite di un cerchio');

%% Salva su file la curva a tratti generata per interpolazione
%curv2_ppbezier_save('c2_ppbez_circ.db', ppP);
%fprintf('Curva salvata in: c2_ppbez_circ.db\n');