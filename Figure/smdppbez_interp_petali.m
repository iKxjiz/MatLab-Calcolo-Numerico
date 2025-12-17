% =========================================================================
% SCRIPT: Pattern circolare con petali - Interpolazione con derivate
% =========================================================================
% OBIETTIVO:
% Creare un disegno con petali disposti circolarmente usando:
% - Interpolazione di Bézier C1 con derivate specificate
% - Intersezioni tra cerchi ruotati
% - Trasformazioni geometriche (scala, rotazione, traslazione)
%
% STRUTTURA:
% 1. Due cerchi unitari traslati che si intersecano
% 2. Ritaglio delle intersezioni per formare un petalo
% 3. Rotazione del petalo per creare:
%    - 7 petali rossi esterni
%    - 7 petali verdi interni (scalati al 50%)
% 4. Cerchio centrale blu (25% del raggio originale)
% =========================================================================

close all;
clear;
clc;

% PARAMETRI

np = 50;         % Numero di punti per plotting/valutazione
tol = 1e-6;      % Tolleranza per unione curve
a = 0;           % Estremo inferiore intervallo parametrico
b = 2*pi;        % Estremo superiore intervallo parametrico

% STEP 1: INTERPOLAZIONE CERCHIO CON CURVE DI BÉZIER C1

open_figure(1);
axis_plot(1, 0.1);
axis equal;
title('Costruzione cerchi e intersezioni');

% Campionamento del cerchio unitario e delle sue derivate
t = linspace(a, b, np);
[x, y, xder, yder] = cerchio(t);

% Punti del cerchio e derivate per interpolazione C1
Q = [x', y'];           % Punti sul cerchio
Q2 = [xder', yder'];    % Derivate nei punti

% Interpolazione con curve di Bézier a tratti C1 usando le derivate
% Questo garantisce che la curva sia liscia (continua fino alla derivata prima)
c1 = curv2_ppbezierCC1_interp_der(Q, Q2, t);
curv2_ppbezier_plot(c1, np, 'b', 2);

% STEP 2: CERCHIO PICCOLO CENTRALE (verrà usato alla fine)

% Scala il cerchio al 25% per il cerchio centrale
S = get_mat_scale([0.25, 0.25]);
cerchio_piccolo = c1;
cerchio_piccolo.cp = point_trans(c1.cp, S);

% STEP 3: TRASLAZIONE E ROTAZIONE PER CREARE INTERSEZIONI

% Trasla il primo cerchio in posizione (1, 1)
T = get_mat_trasl([1, 1]);
c1.cp = point_trans(c1.cp, T);
curv2_ppbezier_plot(c1, np, 'b', 2);

% Crea il secondo cerchio ruotando di 2π/7 ≈ 51.43° attorno all'origine
R = get_mat2_rot(2*pi/7);
c2 = c1;
c2.cp = point_trans(c1.cp, R);
curv2_ppbezier_plot(c2, np, 'r', 2);

% STEP 4: CALCOLO INTERSEZIONI E CREAZIONE PETALO

% Trova i punti di intersezione tra i due cerchi
[~, t1, t2] = curv2_intersect(c1, c2);


[~, dx1] = ppbezier_subdiv(c1, t1(2));
[~, dx2] = ppbezier_subdiv(c2, t2(1));

[l1, ~] = ppbezier_subdiv(dx1, t1(1));
[l2, ~] = ppbezier_subdiv(dx2, t2(2));

% Unisci le due parti per formare il petalo (regione di intersezione)
Petalo = curv2_mdppbezier_join(l1, l2, tol);

% Disegna e riempie il primo petalo
Px = curv2_mdppbezier_plot(Petalo, np, 'r', 4);
point_fill(Px, 'r', 'k');

% STEP 5: LIVELLO ESTERNO - 7 PETALI ROSSI

open_figure(2);
axis equal;
title('Disegno finale con petali');

% Disegna il primo petalo rosso
point_fill(Px, 'r', 'k');

% Ruota il petalo di 2π/7 per creare gli altri 6 petali rossi
pet1 = Petalo;
for i = 1:6
    pet1.cp = point_trans(pet1.cp, R);
    Px2 = curv2_mdppbezier_plot(pet1, np, 'k');
    point_fill(Px2, 'r');
end

% STEP 6: LIVELLO INTERNO - 7 PETALI VERDI

% Trasformazioni per i petali interni:
% - Scala al 50%
% - Ruota di π (180°) per orientamento diverso
S = get_mat_scale([0.5, 0.5]);
R3 = get_mat2_rot(2*pi/2);  % π radianti = 180°
M = S * R3;

% Applica le trasformazioni al petalo base
pet2 = Petalo;
pet2.cp = point_trans(pet2.cp, M);

% Disegna il primo petalo verde
Px3 = curv2_mdppbezier_plot(pet2, np, 'k');
point_fill(Px3, 'r');  % Primo petalo rosso (poi sovrascriviamo)

% Ruota il petalo di 2π/7 per creare tutti i 7 petali verdi
R = get_mat2_rot(2*pi/7);
for i = 0:6  % 7 petali totali (0 a 6)
    pet2.cp = point_trans(pet2.cp, R);
    Px = curv2_mdppbezier_plot(pet2, np, 'k');
    point_fill(Px, 'g');
end

% STEP 7: CERCHIO CENTRALE BLU

% Disegna il cerchio centrale (25% del raggio originale)
points = curv2_ppbezier_plot(cerchio_piccolo, -np, 'b', 2);
point_fill(points, 'b', 'k');

% FUNZIONE LOCALE

function [x, y, xder, yder] = cerchio(t)
% Parametrizzazione del cerchio unitario e sue derivate
% Input:  t = parametro angolare [0, 2π]
% Output: x, y = coordinate punti
%         xder, yder = derivate dx/dt, dy/dt

x = cos(t);
y = sin(t);
xder = -sin(t);  % dx/dt
yder = cos(t);   % dy/dt
end

% NOTE FINALI
%
% STRUTTURA DEL DISEGNO:
% - 7 petali rossi esterni (raggio unitario)
% - 7 petali verdi interni (50% del raggio, ruotati di 180°)
% - 1 cerchio blu centrale (25% del raggio)
%
% TECNICA DI COSTRUZIONE DEL PETALO:
% 1. Due cerchi unitari traslati in (1,1) e ruotati di 2π/7
% 2. Calcolo intersezioni tra i cerchi
% 3. Ritaglio della "mandorla" (regione di intersezione)
% 4. La mandorla diventa il petalo base
%
% INTERPOLAZIONE C1 CON DERIVATE:
% - curv2_ppbezierCC1_interp_der crea curve di Bézier a tratti
% - Le derivate specificate garantiscono continuità C1 (curva liscia)
% - Questo è essenziale per avere cerchi "perfetti" senza spigoli
%
% TRASFORMAZIONI:
% - Traslazione T: sposta il centro del cerchio
% - Rotazione R: ruota attorno all'origine
% - Scala S: ridimensiona mantenendo il centro nell'origine
% - Composizione M = S*R: prima ruota, poi scala
%
% =========================================================================