%script spolygon_scale.m
clear
close all

%definisce vettore colori
col=['r','g','b','k','m','y','c'];

%legge i punti di un disegno da file
P=load('paperino2.txt');
% P=load('twitter2.txt');

%calcola il bounding-box
[xmin,xmax]=mm_vect(P(:,1));
[ymin,ymax]=mm_vect(P(:,2));

%apre figure
figure('Position', [10 10 500 400])
open_figure(1);
%disegna gli assi
axis_plot(0.7,0.05,0.65);

%disegna poligonale in nero
point_plot(P,[col(4),'-o'],2,col(4));

%disegna il bounding-box in nero
rectangle_plot(xmin,xmax,ymin,ymax,'k-',2);

%calcola il baricentro (la metà)
B = 0.5 * [xmin+xmax, ymin+ymax];

%definisce matrice di traslazione T e la sua inversa Tinv
T = get_mat_trasl(-B);
Tinv = get_mat_trasl(B);

%definisce il vettore di scala
s = [0.50 0.50];

%definisce matrice di scala
S = get_mat_scale(s);

%definisce matrice composta di scala rispetto al baricentro
M = Tinv * S * T;

%apre nuova figure
open_figure();
%disegna gli assi
axis_plot(0.5,0.05);

%applica matrice di scala alla poligonale
P = point_trans_plot(P, M, 'r-', 3);
point_plot(P,[col(4),'-o'],2,col(4));

%calcola bounding-box oggetto trasformato
[xmin,xmax]=mm_vect(P(:,1));
[ymin,ymax]=mm_vect(P(:,2));

%disegna bounding-box
rectangle_plot(xmin,xmax,ymin,ymax,'b-',2);
