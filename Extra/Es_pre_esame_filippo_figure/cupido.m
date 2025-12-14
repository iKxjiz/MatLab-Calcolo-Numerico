function main()

close all;
clear all;
clc;

open_figure(1);

%% Cuore iniziale
% cuore di grado 11 con cp
bezCuore.deg = 11;
bezCuore.cp = [[0.0,0.0];[0.15,0.2];[0.4,0.2];[0.3,0.6];[0.0,0.6];[-0.5,0.0];[0.5,0.0];
    [0.0,0.6];[-0.3,0.6];[-0.4,0.2];[-0.15,0.2];[0.0,0.0]];
bezCuore.ab = [0,1];

% valutiamo la prima metà del cerchio (prima metà dell'intervallo) in 7 punti
tm = linspace(0, 0.5, 7);
Q = decast_val(bezCuore, tm);
% ATTENZIONE!!! usato decast_val dato che le curve di Bézier sono polinomi in base Berstein
% per restituire i punti della curva di Bézier dati i suoi coefficienti

% metodo alternativo: valutare in 13 punti il cuore
% Px = curv2_bezier_plot(bezCuore, -13, 'k-');

%% Cuore destro
% metà cuore come curva di interpolazione di grado 6
bezD = curv2_bezier_interp(Q, 0, 1, 0);
% stampa cuore destro
% curv2_bezier_plot(bezD, 40, 'r-',2);

% metodo alternativo: interpoliamo per i primi 7 punti
% Q = Px(1:7,:);
% curv2_bezier_plot(bezD, 40, 'r-',2);

%% Calcolo errore
% crea un vettore di 61 punti equidistanti tra 0 e 0.5
% (considero metà del cuore grande rosso originale)
t1 = linspace(0, 0.5, 61);
% implementa l'algoritmo di De Casteljau per calcolare i punti
% della curva di Bézier dati i suoi coefficienti bezCuore
Qxy = decast_val(bezCuore, t1);

% crea un vettore di 61 punti equidistanti tra 0 e 1
% (considero tuta la parte della metà destra del cuore interpolata)
t2 = linspace(0, 1, 61);
% implementa l'algoritmo di De Casteljau per calcolare i punti
% della curva di Bézier dati i suoi coefficienti bezD
Pxy = decast_val(bezD, t2);

% distanza massima tra le norme di ciascun vettore di differenza,
% rappresentando la distanza massima tra le due curve nei
% punti dati da t1 a t2
MaxErr = max(vecnorm((Qxy-Pxy)',2,1)); % 2 = norma Euclidea, 1 = lungo le colonne
fprintf('MaxErr: %e\n',MaxErr);

%% Cuore sinistro
% curva del cuore destro riflessa a sinistra rispetto all'asse y
bezS = bezD;
bezS.cp(:, 1) = -bezS.cp(:, 1);
% stampa cuore destro
% curv2_bezier_plot(bezS, 40, 'c-',2);

%% Cuore unito a tratti
tol = 1.0e-2;
cuore = curv2_mdppbezier_join(bezS, bezD, tol);
% stampa intero cuore a tratti
cuoreCol = curv2_mdppbezier_plot(cuore, 40, 'k-',2);
point_fill(cuoreCol,'g');

%% FRECCIA

%% Segmento verticale destra
sd.ab = [0,1];
sd.deg = 1;
x = 0.04;
sd.cp = [x, 0.2; x,-1.75];

% elevato il grado della verticale destra
sd = curv2_ppbezier_de(sd, 5);

% stampa punti della metà destra (senso ANTIORARIO)
disp("Verso cuore destro: ");
disp(bezD.cp);
% stampa punti del segmento sd (senso ORARIO)
disp("Verso segmento: ");
disp(sd.cp);

%% Cuore in basso (traslato)
% cuore iniziale spostato in basso per la punta della freccia
cuoreBasso = bezD;
T = get_mat_trasl([0, -2]);
cuoreBasso.cp = point_trans(cuoreBasso.cp, T);

open_figure(2);

% intersezione metà destra del cuore in alto e segmento destro
[I, t1, t2] = curv2_intersect(bezD, sd);
% stampa punti intersezione
% disp(I');

% taglio del cuore in alto --> parte destra = verso rivolto in alto
[~, c] = ppbezier_subdiv(bezD, t1);
curv2_mdppbezier_plot(c,'b');
% taglio segmento in basso --> parte destra = verso rivolto in basso
[~, s] = ppbezier_subdiv(sd, t2);

% unione cuore in alto con segmento per creare frecciaDestra
frecciaDestra = curv2_mdppbezier_join(c, s, 1.0e-2);

% stampa punti della metà destra (senso ANTIORARIO)
disp("Verso freccia (cuore + segmento): ");
disp(bezD.cp);
% stampa punti del cuore traslato (senso ANTIORARIO)
disp("Verso cuore traslato: ");
disp(cuoreBasso.cp);

% intersezione frecciaDestra (sopra) e cuore in basso per
% rimuovere parte finale del segmento verticale
[I, t1, t2] = curv2_intersect(cuoreBasso, frecciaDestra);
% stampa punti intersezione
% disp(I');

% taglio della parte finale del segmento --> parte destra = verso
% rivolto in alto
[~, frecciaDestra] = ppbezier_subdiv(frecciaDestra, t2);
curv2_mdppbezier_plot(frecciaDestra,'r');
% taglio del cuore in basso (quello traslato) --> parte destra = verso
% rivolto in alto
[c, ~] = ppbezier_subdiv(cuoreBasso, t1);
curv2_mdppbezier_plot(c,'g');

% unione fra frecciaDestra (senza parte finale del segmento sostituita
% dal cuore traslato) e cuoreBasso per ottenere la parte destra
% della freccia come curva
frecciaDestra = curv2_mdppbezier_join(c, frecciaDestra, 1.0e-2);

% otteniamo la parte sinistra della freccia come riflessione della parte
% destra rispetto all'asse y
frecciaSinistra = frecciaDestra;
frecciaSinistra.cp(:, 1) = -frecciaSinistra.cp(:, 1);
curv2_mdppbezier_plot(frecciaSinistra,'g');

% uniamo parte frecciaDestra e frecciaSinistra per ottenere la freccia
% completa
freccia = curv2_mdppbezier_join(frecciaSinistra, frecciaDestra, 1.0e-2);

%% Disegno finale
open_figure(3);
set(gca,'color',[0.3, 1, 0.7]);
np = 40;

%% MODO 1 - (cuore sinistro, poi freccia completa, metà cuore destro)
% %% Disegno cuore rosso metà sinistra
% Px = curv2_ppbezier_plot(bezS, -np);
% point_fill(Px, 'r', 'b-', 1.5);
%
% %% Disegno Freccia
% % baricentro freccia
% b = mean(freccia.cp); % restituisce sia per x che per y
% % stampa valore baricentro
% % disp(b);
%
% % posizionare baricentro freccia nell'origine
% % traslare da baricentro ad origine
% T = get_mat_trasl([-b(1), -b(2)]);
% % scalare dato che la freccia è molto più grande del cuore
% S = get_mat_scale([0.25, 0.25]);
% % rotazione di pi/2 + pi/6
% R = get_mat2_rot(2*pi/3);
% % traslare da origine a punto nel cuore
% T1 = get_mat_trasl([0.04, 0.2]);
% % definire matrice composta
% M = T1 * R * S * T;
% freccia.cp = point_trans(freccia.cp, M);
%
% % disegno freccia con bordo blu e sfondo rosso
% Px = curv2_ppbezier_plot(freccia, -np);
% point_fill(Px, 'b', 'r-', 1.5);
%
% %% Disegno cuore rosso metà destra
% Px = curv2_ppbezier_plot(bezD, -np);
% point_fill(Px, 'r', 'b-', 1.5);

%% MODO 2 - (freccia destra, cuore intero, freccia sinistra)
%% Disegno Freccia
% baricentro freccia
b = mean(freccia.cp); % restituisce sia per x che per y
% stampa valore baricentro
% disp(b);

% posizionare baricentro freccia nell'origine
% traslare da baricentro ad origine
T = get_mat_trasl([-b(1), -b(2)]);
% scalare dato che la freccia è molto più grande del cuore
S = get_mat_scale([0.25, 0.25]);
% rotazione di pi/2 + pi/6
R = get_mat2_rot(2*pi/3);
% traslare da origine a punto nel cuore
T1 = get_mat_trasl([0.04, 0.2]);
% definire matrice composta
M = T1 * R * S * T;
freccia.cp = point_trans(freccia.cp, M);

% disegno freccia con bordo blu e sfondo rosso
disFreccia = curv2_ppbezier_plot(freccia, -np);
point_fill(disFreccia, 'b', 'r-', 1.5);

%% Cuore rosso base
disCuore = curv2_ppbezier_plot(cuore, -np);
point_fill(disCuore, 'r', 'b-', 1.5);
%% Segmento verticale centrale cuore-freccia
segCen.ab = [0,1];
segCen.deg = 1;
x = 0;
segCen.cp = [x, 0; x,0.4];

% elevato il grado della verticale destra
segCen = curv2_ppbezier_de(segCen, 5);
curv2_bezier_plot(segCen,'k');

% stampa punti freccia (senso ORARIO)
disp("Verso freccia: ");
disp(freccia.cp);
% stampa punti del segmento segCen (senso ORARIO)
disp("Verso segmento centrale: ");
disp(segCen.cp);

%% Taglio freccia e segmento
[I, t1, t2] = curv2_intersect(freccia, segCen);
disp(I');
disp(t1);
disp(t2);
% taglio segmento
[~, scdx] = ppbezier_subdiv(segCen, t2(1));
[scsx, ~] = ppbezier_subdiv(scdx, t2(2));
% taglio freccia
[frecciaS, ~] = ppbezier_subdiv(freccia, t1(2));
[~, frecciaD] = ppbezier_subdiv(frecciaS, t1(1));

frecciaD = curv2_mdppbezier_join(frecciaD, scsx, 1.0e-2);
Px = curv2_mdppbezier_plot(frecciaD, np);
point_fill(Px, 'b', 'r', 1.5);
end