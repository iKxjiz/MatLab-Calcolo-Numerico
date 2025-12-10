%% script sbezierinterp_curve2d.m
%script per l'interpolazione di curve 2D con curve di Bezier;
%i punti/parametri vengono scelti equispaziati o di Chebyscev
%di seconda specie (estremi compresi).
%Si risolvono due sistemi lineari.
clear
clc
close all

col=['r','g','b','k'];
open_figure(1);
axis_plot(10,1.0);
title('Interpolazione Polinomiale curva 2D');

%% determina la curva 2D di Bézier di interpolazione di una curva 2D in forma parametrica

%la curva 2D analitica da ricostruire per interpolazione
%è definita in forma parametrica nel file c2_curv3_pol.m

%intervallo parametrico di definizione
a = 0;
b = 8;

%valutazione e disegno della curva analitica

% numero di punti di valutazione
np=100;

[x,y]=curv2_plot('c2_curv3_pol',a,b,np,'b',1.5);
% %in alternativa
% t=linspace(a,b,np);
% [x,y]=c2_curv3_pol(t);
% P=[x',y'];
% point_plot(P,'b-',1.5);

%definisce grado del polinomio e punti di interpolazione
n=8;
tipo=1; % 1 punti equispaziati, 2 punti di Chebyshev
switch (tipo)
    case 1
        %n+1 punti equispaziati
        t=linspace(a,b,n+1);
    case 2
        %n+1 punti (i nodi) secondo la distribuzione di Chebyshev
        t=chebyshev2(a,b,n);
end

% per n = 6 e "tipo = 1", nota la "u" che si crea tra i primi due pinti dal centro.
% per la distribuzionde di punti equispaziati la curva è peggiore rispetto
% alla distribuzione di Chebyshev.

%n+1 punti campionati dalla curva c2_curv3_pol test
[x, y] = c2_curv3_pol(t);
x = x'; % x = alla sua trasposta perchè i sistemi lineari vanno risolti con vettori colonna
y = y'; % y = alla sua trasposta perchè i sistemi lineari vanno risolti con vettori colonna
Q = [x,y];

%disegno punti di interpolazione
point_plot(Q,'ko',1,'k');

%cambio di variabile
tt = (t-a)./(b-a); % i punti sono ora tt

%calcolo i polinomi di Bernstein di grado n nei punti tt
%valutazione con l'algoritmo di de Casteljau
B=bernst_val(n,tt);
%calcolo matrice del sistema lineare è già calcolata con i polinomi di Bernstein B

%soluzione dei due sistemi lineari
cx=B\x;
cy=B\y;

%definizione curva di Bézier di interpolazione
Pbez.deg=n;
Pbez.ab=[a,b];
Pbez.cp=[cx,cy];

%valutazione e disegno curva di Bézier interpolante
xy=curv2_bezier_plot(Pbez,np,'r--',1.5');

%calcola l'errore di interpolazione (distanza euclidea fra i punti
%della curva analitica e della curva di Bézier interpolante) e
%stampa il valore massimo (usare function vecnorm)
MaxErr=max(vecnorm(xy'-[x;y]));
fprintf('MaxErr: %e\n',MaxErr);
%in alternativa
%MaxErr=max(sqrt((xy(:,1)'-x).^2+(xy(:,2)'-y).^2));
%fprintf('MaxErr: %e\n',MaxErr);

% %disegno poligonale di controllo
% point_plot(Pbez.cp,[col(3),'-o'],1,'k');

% % disegno delle componenti la curva
% figure(2);
% subplot(2,1,1);
% hold on;
% plot(t, x, 'b-', 'LineWidth', 1.5);
% plot(tpar, xp, 'bo');
% xx=xy(:,1)';
% plot(t, xx, 'r.-','LineWidth',1.5);
% title('Interpolazione polinomiale della componente X della curva');
%
% subplot(2,1,2);
% hold on;
% plot(t, y, 'b-', 'LineWidth', 1.5);
% plot(tpar, yp, 'bo');
% yy=xy(:,2)';
% plot(t, yy, 'r.-','LineWidth',1.5);
% title('Interpolazione polinomiale della componente Y della curva');

%calcola e stampa il Max degli errori di interpolazione
%delle funzioni componenti

err_x=max(abs(x - xy(:,1)'));
err_y=max(abs(y - xy(:,2)'));

fprintf('MaxErrX: %e\n',err_x);
fprintf('MaxErrY: %e\n',err_y);



