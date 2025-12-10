%script di prova per disegno della cardioide e animazione
%figure('Renderer', 'painters', 'Position', [10 10 1000 800])
clear
close all

open_figure(1);
axis_plot();

t = linspace(0.2*pi, 100);
curv2_plot('c2_cardioide', 0,2*pi, 100, 'b-', 2);

% Che cosa succede se cambio intervallo ?
% Che cosa succede se gli altri parametri ?


