%script spolygon_symm.m
clear
close all

%definisce vettore colori
col=['r','g','b','k','m','y','c'];

%legge i punti di un disegno da file
P=load('paperino2.txt');
%P=load('twitter2.txt');

%calcolo della bounding-box dell'oggetto creato
[xmin,xmax]=mm_vect(P(:,1));
[ymin,ymax]=mm_vect(P(:,2));
%disegno del bounding-box
[x, y] = rectangle_plot(xmin,xmax,ymin,ymax,'k-',2);
%bbox = matrice con le colonne la varibile (vettori) x e y trasposte
bbox = [x', y'];

%vettore traslazione della poligonale
d = [1/8 1/8];
%definisco la matrice di traslazione del vettore d (vettore traslazione)
T = get_mat_trasl(d);

%disegno delle varie riflessioni e la figura di partenza traslata
open_figure();
%disegno delle assi (x,y) axis_plot :
% - il primo valore determina la lunghezza del delle assi
% - il secondo valore determina la grandezza delle frecce
axis_plot(1, 0.090);
%mostra la griglia
grid on;
%uso la function point_trans_plot per disegnare la trasformazione
%NOTA : la function ritorna anche la matrice trasformata che posso, volendo,
%memorizzare dentro ad una variabile da riutilizzare per trasformazioni successive
Q = point_trans_plot(P, T,[col(4), '-o'], 4);
%point_plot(Q,[col(4),'-o'],2,col(4));
point_fill(Q, 'cyan');
%applico la trasformazione anche alla bounding-box
bbox2 = point_trans_plot(bbox, T, 'b-', 3);
%calcolo la matrice simmetria rispetto ad una retta tracciata da due punti
SY = get_mat2_symm([0 0], [0 1]);
%SY = SY*T;
Q = point_trans_plot(Q, SY,[col(4), '-o'], 4);
point_fill(Q, 'green')
bbox2 = point_trans_plot(bbox2, SY, 'b-', 3);

SY = get_mat2_symm([0 0], [1 0]);
%SY = SY*T;
Q = point_trans_plot(Q, SY, [col(4), '-o'], 4);
point_fill(Q, 'magenta')
bbox2 = point_trans_plot(bbox2, SY, 'b-', 3);

SY = get_mat2_symm([0 0], [0 1]);
%SY = SY*T;
Q = point_trans_plot(Q, SY, [col(4), '-o'], 4);
point_fill(Q, 'yellow')
bbox2 = point_trans_plot(bbox2, SY, 'b-', 3);


