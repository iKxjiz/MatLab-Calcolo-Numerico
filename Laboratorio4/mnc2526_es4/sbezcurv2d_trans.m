%script di esempio per curva 2d di Bezier
clear
close all

open_figure(1);
axis_plot(1,1/16);

%caricare la curva c2_bezier_heart.db da file
cbez = curv2_bezier_load('c2_bezier_heart.db');

%disegnare la curva
P = curv2_bezier_plot(cbez, 200, 'r-', 5);

open_figure(2);

%definizione vettore di colori
vcol=['r','g','b','c','m','y','k'];

%definire la/le trasformazione/i geometrica/che, applicarla/e alla curva
%e disegnarla/e ognuna con un differente colore
ncurve=7;
teta=2*pi/ncurve;

% matrice di rotazione
R = get_mat2_rot(teta);


% Proprietà di "invarianza per trasformazioni affini" delle
% curve 2D di Bézier
for i = 1:ncurve
    col = vcol(i);
    % applico continuamente per "ncurve" volte la trasformazione sui punti
    % di controllo trasformati.
    P = point_trans_plot(P, R, col, 4);
end
% Questa proprietà dice che la curva di Bézier trasformata
% equivale alla curva di Bézier ottenuta a partire dai punti
% di controllo trasformati.






