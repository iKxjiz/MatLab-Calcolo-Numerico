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

%valutazione con Alg.2
yB = decast_val(p,x); % p : struttura che definisce il polinomio, x : punti di valutazione in [0,1]

% A differenza della valutazione con Alg.1, qui non e' necessario
% effettuare il cambio di variabile in [0,1], in quanto la function
% decast_val gestisce internamente tale operazione.
% yB sono i valori del polinomio nei punti t in [a,b] ed anche i
% punti della curva nei punti t in [a,b]

% COmplessità per punto : O(g^2) operazioni
% Stabilità : estremamente stabile (meglio di Alg.1 per g grandi)
% Semplicità : non richiede la costruzione della matrice B, solo
% combinazioni convesse.

% Nessun rischio di overflow o cancellazione.
% È il metodo preferito in grafica/CAD per le curve di Bézier.

figure('Name','Polinomio test')
plot(t,yB,'-','Color','b','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')

% valutazione polinomio nella base monomiale (polyval di MATLAB)
% yP = polyval(fliplr(cP),t);
% hold on
% plot(t,yP,'--','Color','r','LineWidth',1.5)
% legend('p_P(x)','p_B(x)')
