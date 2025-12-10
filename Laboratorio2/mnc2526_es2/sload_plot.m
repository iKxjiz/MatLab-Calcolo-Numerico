%main di esempio per leggere file di punti e disegnarli
close all
clear

%apre una figure e disegna gli assi
% figure('Position', [10 10 700 600])
open_figure(1);
axis_plot(0.4,0.05)

%legge i punti di un disegno da file

P = load('paperino.txt');

%determina il bounding-box e lo disegna
[xmin, xmax] = mm_vect(P(:,1));
[ymin, ymax] = mm_vect(P(:,2));
rectangle_plot(xmin, xmax, ymin, ymax, 'r-');

%disegna la poligonale di vertici i punti

point_plot(P,'b-', 2);
point_fill(P,'b', 'r', 1.5);

