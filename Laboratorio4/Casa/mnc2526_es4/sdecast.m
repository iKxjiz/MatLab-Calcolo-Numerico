%script sdecast.m
%richiama la function def_pol e valuta i polinomi 
%nella base di Bernstein con Alg.2
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
%TO DO

figure('Name','Polinomio test')
plot(t,yB,'-','Color','b','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')

% valutazione polinomio nella base monomiale (polyval di MATLAB)
% yP = polyval(fliplr(cP),t);
% hold on
% plot(t,yP,'--','Color','r','LineWidth',1.5)
% legend('p_P(x)','p_B(x)')
