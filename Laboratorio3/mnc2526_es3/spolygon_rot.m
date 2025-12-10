%script spolygon_rot.m
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

%calcola il baricentro
%TO DO

%definisce matrice di traslazione T e la sua inversa Tinv
%TO DO

%definisce angolo alpha di rotazione
alpha=0.2*pi;

%definisce matrice di rotazione
%TO DO

%definisce matrice composta di rotazione rispetto al baricentro
%TO DO

%apre nuova figure
open_figure();
%disegna gli assi
axis_plot(0.5,0.05);

%applica matrice di rotazione alla poligonale
%TO DO

%calcola bounding-box oggetto trasformato
%TO DO

%disegna poligonale e bounding-box in rosso
%TO DO
