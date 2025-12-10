%Fare uno script per riprodurre il seguente disegno di una farfalla
% (vedi Figura 1) . Lo script si chiami sppbezerinterp p2d farfalla.m.
% Sugg. Le due ali a destra si ottengano effettuando due interpolazione
% con curve di B´ezier dei seguenti due set di punti: (218,385),(231,512),
% (330,517),(349,404) e (349,404),(490,381),(500,237),(321,241).
% Si sfrutti poi la simmetria per le altre due ali di sinistra.
% Infine tutte le curve vengano unite in una cur- va di B´ezier a
% tratti utilizzando la function curv2 mdppbezier join della libreria anmglib 5.0.

% con un pezzo di carta puntualizzare le cose da fare prima di scrivere il codice
% segui passo passo le istruzioni del testo

% 1.interpolare il primo set di punti con una curva di Bézier

% 2.interpolare il secondo set

% 3.unire le due curve in un’unica curva a tratti di Bézier si utilizzi la
% function curv2_mdppbezier_join del toolbox.

% 4.sfruttare la simmetria del disegno ed applicare una riflessione della
% curva appena determinata rispetto alla retta passante per i suoi estremi;
% si usino le function get_mat2_symm e point_trans.

% 5.si uniscano le due curve di Bézier a tratti sempre con la function
% curv2_mdppbezier_join.

% 6.una delle due antenne gialle può essere modellata con un triangolo
% di vertici (321,241),(450,144),(445,132) o meglio come una lineare a
% tratti composta da tre tratti;

% 7.la seconda antenna può essere ottenuta per rotazione della prima.

% HELP UTILI :

% function mdppbez = curv2_mdppbezier_join(pp1, pp2, tol)
% Calcola la curva 2D di Bezier a tratti multi-degree, join delle due
% curve di Bézier o di Bézier a tratti o di Bézier a tratti multi-degree
% pp1 e pp2
% Se due estremi delle due curve distano meno di tol, le due curve
% verranno unite come se gli estremi fossero uguali, in alternativa
% verrà generata un'unica curva collegando gli estremi con segmento
% retto (tratto di Bezier di grado 1)
% pp1,pp2 --> strutture delle curve 2D in input:
%             pp1.deg --> grado/array di gradi della curva
%             pp1.cp  --> lista dei punti di controllo
%             pp1.ab  --> partizione nodale di [a b]
% tol   --> tolleranza entro cui gli estremi delle due curve
%           vengono considerati uguali
% mdppbez <-- struttura della curva 2D di output:
%           mdppbez.deg --> grado/array di gradi della curva
%           mdppbez.cp  --> lista dei punti di controllo
%           mdppbez.ab  --> partizione nodale di [a b]
% Nota: se le due curve in input sono semplici curve di Bézier o
%       Bézier a tratti dello stesso grado, la curva in output
%       sarà una Bézier a tratti


%% Inizializzazioni

clear all;
clc;

%% 1. Interpolazione del primo set di punti con una curva di Bézier

a = 0;
b = 1;
param = 0;

open_figure();
grid on;

P1 = [218 385; 231 512; 330 517; 349 404];
Adx1 = curv2_bezier_interp(P1, a, b, param);

%curv2_bezier_plot(A1, 100, 'r', 2)

%% 2. Interpolazione del secondo set di punti con una curva di Bézier

P2 = [349 404; 490 381; 500 237; 321 241];
Adx2 = curv2_bezier_interp(P2, a, b, param);

%curv2_bezier_plot(A2, 100, 'r', 2)

%% 3. Unione delle due curve in un'unica curva a tratti di Bézier

tol = 1e-2;

Adx = curv2_mdppbezier_join(Adx1, Adx2, tol);
%K = curv2_ppbezier_plot(Adx, 100, 'r-', 2);

%% 4. Riflesssione della curva rispetto alla retta passante per i suoi estremi

SY = get_mat2_symm(Adx.cp(1,:), Adx.cp(end,:));
%A3 = point_trans(K, SY);

%% 5. Unione delle due curve di Bézier a tratti

Asx = Adx;
Asx.cp = point_trans(Adx.cp, SY);

Atot = curv2_mdppbezier_join(Adx, Asx, tol);
% mettendo i punti di valutazione a -200, le valutazioni vengono fatte ma
% non viene disegnato nulla.
Area = curv2_ppbezier_plot(Atot, -200, 'k-', 3);

% coloro il baunding box della figura
[ymin,ymax]=mm_vect(Area(:,2));
[x, y] = rectangle_plot(0,600,ymin,ymax,'k',3)
Rec = [x', y'];
col = [204, 255, 204] / 255; % verde chiaro
point_fill(Rec, col);

point_plot(Area, 'k-', 3);
point_fill(Area, 'r');

%% 6. Modello della prima antenna con una lineare a tratti composta da tre tratti

antennadx.deg = 1;
antennadx.cp = [321, 241; 450, 144; 445, 132; 321, 241];
antennadx.ab = [0, 1, 2, 3];

curv2_ppbezier_plot(antennadx, 100, 'k-', 3);
point_fill(antennadx.cp, 'y');

%% 7. Modello della seconda antenna per rotazione della prima

% Calcolo della matrice di rotazione attorno al punto (321, 241) di un angolo di -pi/6
% che corrisponde a una rotazione in senso orario di 30 gradi.
T = get_mat_trasl([-321, -241]);
Tinv = get_mat_trasl([321, 241]);
R = get_mat2_rot(-pi/6);
M = Tinv * R * T;

antenna_sx = antennadx;
antenna_sx.cp = point_trans(antennadx.cp, M);

curv2_ppbezier_plot(antenna_sx, 100, 'k', 3);
point_fill(antenna_sx.cp, 'y');

%% Funzione per calolare il bounding box

function [vmin,vmax] = mm_vect(lista)
%determina valore minimo e massimo di una lista di valori
vmin=min(lista);
vmax=max(lista);
end

