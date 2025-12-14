%script sbernst_der.m
%richiama la function def_pol e valuta i polinomi e loro derivata
%nella base di Bernstein con Alg.1. Si usi la function bernst_valder.

clear
close all

ex=7;
[g,a,b,cP,cB]=def_pol(ex);

% punti di valutazione in [a,b]
% h = 2^-5;
% t = a:h:b;
% altri punti di valutazione in [a,b]
np = 100;
t = linspace(a,b,np);

% valutazione polinomiale nella base di Bernstein con Alg.1
% utilizzare la function bernst_val del toolbox anmglib_5.0
%
%cambio di variabile
% necessario perché l'algoritmo di Bernstein è definito in [0,1]
x = (t - a)./(b - a); % mappatura in [0,1]
%valutazione matrice funzioni base di Bernstein
[B, Bder] = bernst_valder(g,x);

% [bs,bsp]=bernst_valder(g,x)
% g : grado del polinomio
% x : punti di valutazione in [0,1]
% bs : matrice delle funzioni base di Bernstein nei punti x
% bsp : matrice delle derivate delle funzioni base di Bernstein nei punti x

%combinazione lineare
yB = B * cB'; % rappresenta il valore trasposto del polinomio in t
yBder = Bder * cB'; % derivata del polinomio in t

% grafico polinomio nella base di Bernstein
figure('Name','Polinomio test')
plot(t,yB,'-','Color','r','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')

% grafico derivata polinomio nella base di Bernstein
figure('Name','Derivata polinomio test')
plot(t,yBder,'-','Color','b','LineWidth',1.5)
title('Derivata polinomio test','FontWeight','bold')

% valutazione polinomio nella base monomiale (polyval di MATLAB)
% yP = polyval(fliplr(cP),t);

% hold on
% plot(t,yP,'--','Color','r','LineWidth',1.5)
% legend('p_P(x)','p_B(x)')