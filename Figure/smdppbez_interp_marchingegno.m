% =========================================================================
% SCRIPT: Esercizio d'esame MNC2324 - Disegno geometrico con curve di Bézier
% =========================================================================
% OBIETTIVO:
% Riprodurre un disegno composto da quattro "petali" simmetrici ottenuti
% tramite rotazioni successive di una forma base.
%
% DESCRIZIONE:
% 1. Ricostruire la curva esterna per interpolazione della curva parametrica:
%    x = r*cos(t), y = r*sin(t)  con t ∈ [0, 2π]
%    dove r = (|cos(t)/2|^5 + |sin(t)|^5)^(-1/5)
%    utilizzando una curva di Bézier a tratti con errore MaxErr ≤ 0.5e-02
%
% 2. La curva interna è un rettangolo (curva di Bézier a tratti di grado 1)
%
% 3. Creare un "petalo" tramite intersezioni e unioni di curve
%
% 4. Ruotare il petalo di 90° per 4 volte per ottenere il disegno completo
% =========================================================================

clear;
clc;
close all;

% PARAMETRI

tol = 1.0e-6;    % Tolleranza per unione curve
np = 50;         % Numero di punti per valutazione/plotting
a = 0;           % Estremo inferiore intervallo parametrico
b = 2*pi;        % Estremo superiore intervallo parametrico

% STEP 1: COSTRUZIONE CURVA ESTERNA (curva parametrica)

% Campionamento della curva parametrica
t = linspace(a, b, np);
[x, y] = cp2_funzione(t);
Q = [x', y'];

% Interpolazione con curva di Bézier a tratti C1
ppP = curv2_ppbezierCC1_interp(Q, a, b, 0);

% Verifica errore di interpolazione
t = linspace(a, b, np);
Pxy = ppbezier_val(ppP, t);
[xc, yc] = cp2_funzione(t);
Cxy = [xc', yc'];
MaxErr = max(vecnorm(Pxy - Cxy)');
fprintf('Errore di interpolazione curva esterna: MaxErr = %e\n', MaxErr);

% Visualizzazione curva esterna
open_figure(1);
grid on;
title('Curva esterna parametrica');
curv2_ppbezier_plot(ppP, np, 'b', 2);

% STEP 2: COSTRUZIONE CURVA INTERNA (rettangolo)

% Definizione vertici del rettangolo centrato nell'origine
rect.cp = [
    1.3, -0.3;
    1.3,  0.3;
    -1.3,  0.3;
    -1.3, -0.3;
    1.3, -0.3   % Chiusura
    ];
rect.ab = linspace(0, 1, size(rect.cp, 1));
rect.deg = 1;  % Grado 1 → segmenti rettilinei

% Visualizzazione rettangolo
curv2_ppbezier_plot(rect, np, 'b', 2);

% STEP 3: ROTAZIONI E INTERSEZIONI

open_figure(2);
title('Curve ruotate e intersezioni');

% --- Rotazione di +45° (π/4) - petalo verde ---
R_dx = get_mat2_rot(pi/4);
ppP_dx = ppP;
ppP_dx.cp = point_trans(ppP_dx.cp, R_dx);
rect_dx = rect;
rect_dx.cp = point_trans(rect_dx.cp, R_dx);

curv2_ppbezier_plot(ppP_dx, np, 'b', 2);
curv2_ppbezier_plot(rect_dx, np, 'b', 2);
point_plot(ppP_dx.cp(1,:), 'ko', 10);
point_plot(rect_dx.cp(1,:), 'ko', 10);

% --- Rotazione di -45° (-π/4) - petalo blu ---
R_sx = get_mat2_rot(-pi/4);
ppP_sx = ppP;
ppP_sx.cp = point_trans(ppP_sx.cp, R_sx);
rect_sx = rect;
rect_sx.cp = point_trans(rect_sx.cp, R_sx);

curv2_ppbezier_plot(ppP_sx, np, 'b', 2);
curv2_ppbezier_plot(rect_sx, np, 'b', 2);
point_plot(ppP_sx.cp(1,:), 'ko', 10);
point_plot(rect_sx.cp(1,:), 'ko', 10);

% STEP 4: CALCOLO INTERSEZIONI

% Trova i punti di intersezione tra le curve
[~, v1, ~] = curv2_intersect(ppP_dx, ppP_sx);     % Curve esterne destra-sinistra
[~, v3, ~] = curv2_intersect(ppP_dx, rect_sx);    % Curva destra - rettangolo sinistro
[~, ~, v6] = curv2_intersect(ppP_sx, rect_dx);    % Curva sinistra - rettangolo destro
[~, ~, v8] = curv2_intersect(rect_sx, rect_dx);   % Rettangoli

% STEP 5: COSTRUZIONE LATO VERDE (esterno)

% Suddividi la curva esterna destra nei punti di intersezione
[sx, ~] = ppbezier_subdiv(ppP_dx, v1(3));  % Pezzo sinistro
[~, dx] = ppbezier_subdiv(ppP_dx, v3(3));  % Pezzo destro

% Unisci i due pezzi per formare il lato esterno del petalo verde
lato_est_verd = curv2_mdppbezier_join(sx, dx, tol);

% STEP 6: COSTRUZIONE LATO VERDE (interno)

% Suddividi il rettangolo destro nei punti di intersezione
[sx, ~] = ppbezier_subdiv(rect_dx, v6(3));  % Pezzo sinistro
[~, dx] = ppbezier_subdiv(rect_dx, v8(3));  % Pezzo destro

% Unisci i due pezzi per formare il lato interno del petalo verde
lato_inter_verd = curv2_mdppbezier_join(sx, dx, tol);

% STEP 7: UNIONE E CHIUSURA PETALO VERDE

open_figure(3);
title('Petalo verde - costruzione');
curv2_ppbezier_plot(ppP_dx, np, 'b', 2);
curv2_ppbezier_plot(rect_dx, np, 'b', 2);
curv2_mdppbezier_plot(lato_est_verd, np, 'm', 3);
curv2_mdppbezier_plot(lato_inter_verd, np, 'y', 3);

% Unisci lato esterno e interno
lato_verde_sup = curv2_mdppbezier_join(lato_est_verd, lato_inter_verd, tol);

% Chiudi la curva (connetti inizio e fine)
lato_verde_sup = curv2_mdppbezier_close(lato_verde_sup);

% Ottieni i punti per il riempimento
lato_verde_sup_points = curv2_mdppbezier_plot(lato_verde_sup, -np);

% STEP 8: DISEGNO FINALE CON ROTAZIONI

open_figure(4);
title('Disegno finale con 4 lati');
col = [204, 204, 204]/255;  % Colore grigio chiaro per lo sfondo
set(gca, 'Color', col);

% Primo petalo (verde)
point_fill(lato_verde_sup_points, 'g', 'b', 2);

% Rotazioni successive di 90° per creare i 4 petali
alpha = pi/2;  % Angolo di rotazione: 90°
R = get_mat2_rot(alpha);
ppK = lato_verde_sup;

for i = 1:3
    ppK.cp = point_trans(ppK.cp, R);  % Ruota i punti di controllo
    punti = curv2_mdppbezier_plot(ppK, -np);

    % Alterna i colori: petali dispari blu, petali pari verdi
    if mod(i, 2) > 0
        point_fill(punti, 'b', 'b', 2);
    else
        point_fill(punti, 'g', 'b', 2);
    end
end

% FUNZIONI LOCALI

function [x, y] = cp2_funzione(t)
% Curva parametrica con forma simile a una stella arrotondata
% r(t) definisce il raggio in funzione dell'angolo t
r = (abs(cos(t)/2).^5 + abs(sin(t)).^5).^(-1/5);
x = r .* cos(t);
y = r .* sin(t);
end

% NOTE FINALI
%
% STRUTTURA DEL DISEGNO:
% 1. Si parte da una curva parametrica "stellata" e un rettangolo
% 2. Si ruotano entrambe le curve di ±45°
% 3. Si trovano le intersezioni tra le curve ruotate
% 4. Si ritagliano e uniscono i pezzi per formare un "petalo"
% 5. Si ruota il petalo di 90° per 4 volte ottenendo una simmetria a 4 vie
%
% TECNICHE UTILIZZATE:
% - Interpolazione con curve di Bézier a tratti C1
% - Trasformazioni geometriche (rotazioni)
% - Calcolo di intersezioni tra curve
% - Suddivisione e unione di curve
% - Riempimento di regioni chiuse