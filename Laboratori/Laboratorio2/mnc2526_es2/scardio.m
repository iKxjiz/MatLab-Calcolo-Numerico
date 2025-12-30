%script di prova per disegno della cardioide e animazione
%figure('Renderer', 'painters', 'Position', [10 10 1000 800])
clear all
close all
clc

% Intervallo t ∈ [a,b] e numeri di punti da valutare (np)
a = 0;
b = 2*pi;
np = 200;

open_figure(1);
axis_plot(2, 0.5);
curv2_plot('c2_cardioide',a, b, np, 'b-', 4);
