%script di esempio per curva 2d di Bezier
clear
close all

open_figure(1);
axis_plot(1,1/16);

%caricare la curva c2_bezier_heart.db da file
cbez = curv2_bezier_load("c2_bezier_heart.db");

%disegnare la curva
curv2_bezier_plot(cbez, 50, 'b-', 1.5);

%open_figure(2);
open_figure(2);
Pxy = curv2_bezier_plot(cbez, 50, 'b-', 5);
%definizione vettore di colori
vcol=['r','g','b','c','m','cyan','k'];

%definire la/le trasformazione/i geometrica/che, applicarla/e alla curva
%e disegnarla/e ognuna con un differente colore
ncurve=7;
teta=2*pi/ncurve;

R = get_mat2_rot(teta);

%disegno delle curve ognuna ruotata e con colore differente
for i=1:ncurve
    cbez.cp = point_trans(cbez.cp, R);
    curv2_bezier_plot(cbez, 50, [vcol(i), '-'], 1.5);
    %col=vcol(i);
    %Pxy=point_trans_plot(Pxy, R, col);
end





