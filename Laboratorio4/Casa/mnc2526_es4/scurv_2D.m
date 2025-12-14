%script scurv2D.m
%Disegno di curve in forma parametrica
clear
close all

open_figure(1);
axis_plot(15,1.0)


% Disegno delle Curve piane :
% C(t) = (6t − 9t2 + 4t3, −3t2 + 4t3)T t ∈ [−0.5, 1.5]
a1 = -0.5;
b1 = 1.5;

% C(t) = (t cos(t), t sin(t))T t ∈ [0, 16]
a2 = 0;
b2 = 16; % Nota cosa succede se metti b2 = 8 oppure lo aumenti tipo a b2 = 32

np = 200; % numero di punti di valutazione della curva

% Function curva_piana_1 per la prima curva (cuspide NON regolare)
curv2_plot('curva_piana_1',a1, b1, np, 'r-', 2); % Disegno della prima curva

% Function curva_piana_2 per la seconda curva
curv2_plot('curva_piana_2',a2, b2, np, 'b-', 2); % Disegno della seconda curva


