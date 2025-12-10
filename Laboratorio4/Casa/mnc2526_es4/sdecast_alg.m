%script sdecast_alg.m
%richiama def_pol e valuta i polinomi con Alg.2
%si vuole determinare sperimentalmente l'errore algoritmico
%utilizzando le precisioni single e double
clear
close all

ex=7;
[g,a,b,cP,cB]=def_pol(ex);

%definizione polinomio nella base di Bernstein in double
p.deg=g;
% TO DO
%definizione polinomio nella base di Bernstein in single
sp.deg=g;
% TO DO

% punti di valutazione in [a,b]
h=2^-5;
t=a:h:b;
np=length(t);
% altri punti di valutazione in [a,b]
% np = 100;
% t = linspace(10,16,np)';

st=single(t);

% valutazione polinomio nella base di Bernstein con Alg.2
% function decast_val del toolbox anmglib_5.0
% Alg.2 sia in double che in single
yB=...;
syB=...;

figure('Position', [10 10 500 600]);
subplot(2,1,1);
hold on;
plot(t,yB,'-','Color','r','LineWidth',1.5)
plot(t,zeros(1,np),'k-','LineWidth',1.5);
title('Polinomio test','FontWeight','bold')

subplot(2,1,2);
%calcola errore relativo
relerr=...;
plot(t,relerr,'b.-');

% valutazione polinomio nella base monomiale (polyval di MATLAB)
% yP = polyval(fliplr(cP),t);
% hold on
% plot(t,yP,'--','Color','r','LineWidth',1.5)
% legend('p_P(x)','p_B(x)')
