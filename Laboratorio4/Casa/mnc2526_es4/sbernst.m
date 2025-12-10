%script sbernst.m
%richiama la function def_pol e valuta i polinomi 
%nella base di Bernstein con Alg.1
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
%TO DO
%valutazione matrice funzioni base di Bernstein
%TODO
%combinazione lineare
%TO DO

figure('Name','Polinomio test')
plot(t,yB,'-','Color','g','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')

% valutazione polinomio nella base monomiale (polyval di MATLAB)
% yP = polyval(fliplr(cP),t);

% hold on
% plot(t,yP,'--','Color','r','LineWidth',1.5)
% legend('p_P(x)','p_B(x)')
