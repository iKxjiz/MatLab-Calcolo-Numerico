%==========================================================================
% Script: sppbezierinterp_curve2d_bicorn.m
%==========================================================================
% DESCRIZIONE:
%   Interpolazione di due curve parametriche (bicorn) mediante curve di
%   Bézier. Il programma:
%   1. Campiona le due curve bicorn in n+1 punti (equispaziati o Chebyshev)
%   2. Costruisce due curve di Bézier che interpolano i punti campionati
%   3. Visualizza le curve originali, i punti di interpolazione e le
%      curve di Bézier risultanti
%==========================================================================

function main()
% Pulizia ambiente
close all
clc


%%  PARAMETRI DI CONFIGURAZIONE

n = 5;          % Grado della curva di Bézier (n+1 punti di controllo)
mp = 150;       % Numero di punti per il plot delle curve
a = -1;         % Estremo sinistro dell'intervallo parametrico
b = 1;          % Estremo destro dell'intervallo parametrico
tipo = 2;       % Tipo di distribuzione: 1=equispaziata, 2=Chebyshev


%% INIZIALIZZAZIONE FIGURA

open_figure();
axis_plot(1.5, 0.125);
hold on;
grid on;


%% PLOT DELLE CURVE ORIGINALI (alta risoluzione)

% Disegna le curve bicorn originali con molti punti per mostrare
% la forma "reale" delle curve da interpolare
%[x_plot, y1_plot] = curv2_plot('c2_bicorn1', a, b, mp, 'k-', 1.5);
%[x_plot, y2_plot] = curv2_plot('c2_bicorn2', a, b, mp, 'k-', 1.5);


%% SELEZIONE PUNTI DI INTERPOLAZIONE

switch tipo
    case 1
        % Distribuzione EQUISPAZIATA
        % Usata per interpolazione a tratti o quando i dati sono
        % già campionati uniformemente
        t = linspace(a, b, n+1);
        fprintf('Distribuzione: EQUISPAZIATA\n');

    case 2
        % Distribuzione di CHEBYSHEV
        % Ottimale per minimizzare l'errore di interpolazione globale
        % e ridurre il fenomeno di Runge
        t = chebyshev2(a, b, n);
        fprintf('Distribuzione: CHEBYSHEV\n');

    otherwise
        error('Tipo di distribuzione non valido. Usare 1 o 2.');
end

fprintf('Numero di punti di interpolazione: %d\n', n+1);
fprintf('Grado della curva di Bézier: %d\n\n', n);


%% CAMPIONAMENTO DELLE CURVE NEI PUNTI SELEZIONATI

% Valuta le due curve bicorn nei punti t scelti
[x, y1] = c2_bicorn1(t);
[x, y2] = c2_bicorn2(t);

% Conversione in vettori colonna (necessario per la risoluzione
% dei sistemi lineari)
x = x(:);   % Assicura vettore colonna
y1 = y1(:);
y2 = y2(:);


%% COSTRUZIONE MATRICI DI PUNTI

% Q1 e Q2 sono matrici (n+1)x2 con le coordinate (x,y) dei punti
Q1 = [x, y1];   % Punti della prima bicorn
Q2 = [x, y2];   % Punti della seconda bicorn

fprintf('Punti di interpolazione per la curva 1:\n');
disp(Q1);
fprintf('Punti di interpolazione per la curva 2:\n');
disp(Q2);

% Visualizza i punti di interpolazione
point_plot(Q1, 'bo', 6, 'b');  % Punti curva 1 in blu
point_plot(Q2, 'ro', 6, 'r');  % Punti curva 2 in rosso


%% CAMBIO DI VARIABILE: [a,b] → [0,1]

% Le curve di Bézier sono definite canonicamente su [0,1]
% Mappiamo i parametri t dall'intervallo [a,b] a [0,1]
tt = (t - a) / (b - a);


%% COSTRUZIONE MATRICE DI INTERPOLAZIONE

% Calcola i polinomi di Bernstein di grado n nei punti tt
% B è una matrice (n+1)x(n+1) dove B(i,j) = B_j^n(tt_i)
% Questa è la matrice del sistema lineare per l'interpolazione
B = bernst_val(n, tt);

%fprintf('Matrice di Bernstein B:\n');
%disp(B);
%fprintf('Condizionamento della matrice: %.2e\n\n', cond(B));


%% RISOLUZIONE SISTEMI LINEARI

% Per trovare i punti di controllo della curva di Bézier interpolante:
% B * cx = x   →  cx = B \ x  (coordinate x dei punti di controllo)
% B * cy = y   →  cy = B \ y  (coordinate y dei punti di controllo)

% Punti di controllo per coordinate x (comuni ad entrambe le curve)
cx = B \ x;

% Punti di controllo per coordinate y della prima curva
cy1 = B \ y1;

% Punti di controllo per coordinate y della seconda curva
cy2 = B \ y2;

fprintf('Punti di controllo curva Bézier 1:\n');
disp([cx, cy1]);
fprintf('Punti di controllo curva Bézier 2:\n');
disp([cx, cy2]);


%% DEFINIZIONE STRUTTURE CURVE DI BÉZIER

% Prima curva di Bézier (interpola bicorn1)
Pbez1.deg = n;              % Grado della curva
Pbez1.ab = [a, b];          % Intervallo parametrico
Pbez1.cp = [cx, cy1];       % Matrice (n+1)x2 dei punti di controllo

% Seconda curva di Bézier (interpola bicorn2)
Pbez2.deg = n;
Pbez2.ab = [a, b];
Pbez2.cp = [cx, cy2];


%% VISUALIZZAZIONE CURVE DI BÉZIER INTERPOLANTI

% Disegna le curve di Bézier interpolanti con alta risoluzione
curv2_bezier_plot(Pbez1, mp, 'b', 2);  % Curva 1 in blu (spessa)
curv2_bezier_plot(Pbez2, mp, 'r', 2);  % Curva 2 in rosso (spessa)


%% SEZIONE: INTERSEZIONE E COSTRUZIONE CURVA CHIUSA


%% VISUALIZZAZIONE PUNTI INIZIALI DELLE CURVE

% Evidenzia i primi punti di controllo (estremi iniziali) delle due curve
point_plot(Pbez1.cp(1,:), 'ko', 10);  % Primo punto curva 1 (nero)
point_plot(Pbez2.cp(1,:), 'ko', 10);  % Primo punto curva 2 (nero)


%% CALCOLO PUNTI DI INTERSEZIONE

% Trova le intersezioni tra le due curve di Bézier
% INPUT:  Pbez1, Pbez2 - strutture delle curve di Bézier
% OUTPUT: IP1P2 - coordinate (x,y) dei punti di intersezione [2 x num_intersez]
%         t1    - parametri di intersezione sulla curva 1
%         t2    - parametri di intersezione sulla curva 2
[IP1P2, t1, t2] = curv2_intersect(Pbez1, Pbez2);

if (length(t1)>0)
    % Visualizza i punti di intersezione trovati
    point_plot(IP1P2','go',1,'g','g',8);
    % Stampa informazioni sulle intersezioni
    fprintf('IP1P2 = %e %e\n',IP1P2);
    fprintf('t1 = %e\n',t1);
    fprintf('t2 = %e\n',t2);
end


%% NUOVA FIGURA PER LA CURVA COMPOSTA

open_figure();
axis_plot(1.5, 0.125);
hold on;
title('Curva chiusa ottenuta da tratti interpolanti');
grid on;
axis equal;


%% ESTRAZIONE TRATTI CENTRALI DELLE CURVE

% CURVA 1: Suddivide Pbez1 nei punti di intersezione per estrarre
%          il tratto compreso tra le due intersezioni

% Prima suddivisione: separa la parte sinistra dal resto
% p1_sx: tratto prima della prima intersezione (scartato)
% p1:    tratto dalla prima intersezione in poi
[p1_sx, p1] = decast_subdiv(Pbez1, t1(1));

% Seconda suddivisione: isola il tratto centrale
% Nota: il parametro t1(2) va riscalato sull'intervallo residuo
% p1:    tratto centrale tra le due intersezioni (UTILIZZATO)
% p1_dx: tratto dopo la seconda intersezione (scartato)
[p1, p1_dx] = decast_subdiv(p1, t1(2));

% CURVA 2: Suddivide Pbez2 nei punti di intersezione per estrarre
%          il tratto compreso tra le due intersezioni

% Prima suddivisione
[p2_sx, p2] = decast_subdiv(Pbez2, t2(1));

% Seconda suddivisione
[p2, p2_dx] = decast_subdiv(p2, t2(2));


%% COSTRUZIONE CURVA COMPOSITA (JOIN)

% Unisce i due tratti centrali p1 e p2 in una curva di Bézier a tratti
% mantenendo la continuità desiderata

tol = 1.0e-2;  % Tolleranza per la continuità geometrica

% curv2_mdppbezier_join: unisce due curve di Bézier garantendo continuità
% INPUT:  p1, p2 - curve di Bézier da unire
%         tol    - tolleranza per la verifica di continuità
% OUTPUT: ppQ    - struttura curva di Bézier a tratti (piecewise polynomial)
ppQ = curv2_mdppbezier_join(p1, p2, tol);


%% CHIUSURA DELLA CURVA

% Chiude la curva composita connettendo l'ultimo punto con il primo
% per ottenere una curva chiusa
ppQ = curv2_mdppbezier_close(ppQ);


%% VISUALIZZAZIONE CURVA FINALE

% Plot della curva di Bézier a tratti chiusa
np = 100;  % Numero di punti per il plot di ogni tratto

% curv2_ppbezier_plot: disegna la curva a tratti
% -np indica di usare np punti per tratto (segno negativo per opzioni speciali)
% OUTPUT: Px - matrice con i punti campionati sulla curva
Px = curv2_ppbezier_plot(ppQ, -np);


%% RIEMPIMENTO REGIONE

% Riempie l'interno della curva chiusa con colore
% point_fill: riempie la regione definita dai punti Px
% 'g': colore bordo (green)
% 'b': colore riempimento (blue)
% 1.5: spessore linea bordo
point_fill(Px, 'g', 'b', 1.5);

%% Rotazione

%Determinare la circonferenza per interpolazione di Hermite con una curva
%cubica a tratti ppP
t = chebyshev2(0, 2*pi, 20);
[x, y, xp, yp] = cp2_circle(t);
ppP = curv2_ppbezierCC1_interp([x', y'], 0, 2*pi, 2);

%scaliamo la circonferenza per avere raggio 0.25
ppPC=ppP;
S=get_mat_scale([0.25,0.25]);
ppPC.cp=point_trans(ppPC.cp,S);

%trasliamo opportunamente la curva chiusa per farla ruotare intorno
%all'origine
C=ppQ.cp(1,:);
T=get_mat_trasl(-C);
alfa=pi;
T1=get_mat_trasl([0.3,0]);
M=T1*T;
ppQ.cp=point_trans(ppQ.cp,M);
% point_plot(ppbez1.cp(1,:),'bo');
curv2_ppbezier_plot(ppQ, 30);

end
