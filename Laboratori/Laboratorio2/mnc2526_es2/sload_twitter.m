% sload_twitter.m
clear all
close all
clear
clc

%apre una figure e disegna gli assi
% figure('Position', [10 10 700 600])
open_figure(1);
grid on

%legge i punti di un disegno da file

info = load('twitter.txt'); % Leggo tutte le informazioni dal file (Nota : x è una matrice)
x = info(:,1); % Tutte le righe prima colonna
y = info(:,2); % Tutte le rigeh seconda colonna
point_plot([x,y], 'black-', 3);
hold on
point_fill([x, y], 'cyan');

%determina il bounding-box e lo disegna
[max_x, max_y, min_x, min_y] = quad(x, y);

%disegna la poligonale di vertici i punti
rectangle_plot(min_x, max_x, min_y, max_y, 'r', 4);

%funzione per determinare i massimi e i minimi :
function [max_x, max_y, min_x, min_y] = quad(x, y)
max_x = max(x);
max_y = max(y);
min_x = min(x);
min_y = min(y);
end

