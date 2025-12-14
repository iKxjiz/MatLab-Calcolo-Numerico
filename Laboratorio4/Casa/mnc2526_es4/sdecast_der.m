%script sdecast_der.m
%richiama la function def_pol e valuta i polinomi e loro derivata
%nella base di Bernstein con Alg.2. Si usi la function decast_valder.
clear
close all

ex=7;
[g,a,b,cP,cB]=def_pol(ex);

%definizione polinomio nella base di Bernstein
p.deg=g;
p.ab=[a,b];
p.cp=cB';

%punti di valutazione in [a,b]
% h=2^-5;
% t=a:h:b;
%altri punti di valutazione in [a,b]
np = 100;
t = linspace(a,b,np)';

% valutazione polinomio nella base di Bernstein con Alg.2
% utilizzare function decast_val del toolbox anmglib_5.0
%
yB = decast_valder(p,1,t);
% a differenza dell'algoritmo di Bernstein, qui non è necessario il
% cambio di variabile perché l'algoritmo di De Casteljau è definito
% direttamente in [a,b]

% Px=decast_valder(bezier,k,t)
% bezier : struttura che definisce il polinomio
% k : numero di derivate da calcolare (k=1 per prima derivata)
% t : punti di valutazione in [a,b]

% disp(size(yB));

% grafico polinomio nella base di Bernstein
figure('Name','Polinomio test')
plot(t,yB(1, :),'-','Color','b','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')

% grafico derivata polinomio nella base di Bernstein
figure('Name','Derivata polinomio test')
plot(t,yB(2, :),'-','Color','r','LineWidth',1.5)
title('Derivata polinomio test','FontWeight','bold')

% valutazione polinomio nella base monomiale (polyval di MATLAB)
% yP = polyval(fliplr(cP),t);
% hold on
% plot(t,yP,'--','Color','r','LineWidth',1.5)
% legend('p_P(x)','p_B(x)')