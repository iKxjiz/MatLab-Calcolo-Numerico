%script sbernst.m
%richiama la function def_pol e valuta i polinomi
%nella base di Bernstein con Alg.1
clear
close all

ex=6;
[g,a,b,cP,cB]=def_pol(ex);

% def_pol restituisce:
% g   <-- grado del polinomio test
% a,b <-- intervallo di definizione
% cP  <-- coefficienti nella base canonica (1,x,x^2,...,x^g):
% cB  <-- coefficienti nella base di Bernstein
% Questi polinomi sono definiti nell'intervallo [0,1],
% ma si possono facilmente mappare in un qualsiasi intervallo [a,b].
% Le caratteristiche dei polinomi test sono descritte nella function def_pol.

% punti di valutazione in [a,b]
% h = 2^-5;
% t = a:h:b;
% altri punti di valutazione in [a,b]
np = 100;
t = linspace(a,b,np);

% valutazione polinomiale nella base di Bernstein con Alg.1
% utilizzare la function bernst_val del toolbox anmglib_5.0

%cambio di variabile
x = (t - a)./(b - a); % mappa [a,b] in [0,1]

%valutazione matrice funzioni base di Bernstein
B = bernst_val(g,x); % g : grado del polinomio, x : punti di valutazione in [0,1]

% Complessità per punto : O(g) operazioni
% Sabilità : ottima
% Semplicità : richiuede la costruzione della matrice B

%combinazione lineare
yB = B * cB(:); % cB : coefficienti del polinomio nella base di Bernstein

figure('Name','Polinomio test')
plot(t,yB,'-','Color','r','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')

% valutazione polinomio nella base monomiale (polyval di MATLAB)
% yP = polyval(fliplr(cP),t);

% hold on
% plot(t,yP,'--','Color','r','LineWidth',1.5)
% legend('p_P(x)','p_B(x)')
