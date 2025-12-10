% script spolint_C1_fun.m
% Interpolante cubica a tratti C1 di una funzione test:
% definire una function con la funzione test e settare
% n      : numero dei tratti
% tipo   : di distribuzione dei punti 1=equispaziati 2=chebyshev
% Viene prodotto il grafico della funzione test, del polinomio
% interpolante e dei punti di interpolazione
clear
%close all

%definire la funzione test: vedere le funzioni test presenti nella cartella
%funzione test ed estremi intervallo di definizione
fun =@(x) rungep(x);
a=-5;
b=5;

%definisce numero tratti e punti di interpolazione
n=8;
tipo=1;
switch (tipo)
    case 1
        %n+1 punti equispaziati
        x=linspace(a,b,n+1);
    case 2
        %n+1 punti secondo la distribuzione di Chebyshev
        x=chebyshev2(a,b,n);
end

%n+1 osservazioni campionate dalla funzione test
[y,y1]=fun(x);

m=21;
%punti su cui valutare l'interpolante polinomiale modo 1
% xv=linspace(a,b,m*n+1);

%punti su cui valutare l'interpolante polinomiale modo 2
in=0;
for i=1:n
    xv(in+1:in+m)=linspace(x(i),x(i+1),m);
    in=in+m-1;
end

%Metodo di interpolazione cubica tratti C1 di Hermite
ppP=ppbezierCC1_interp_der(x,y,y1);
%valutazione cubica a tratti
yvc=ppbezier_val(ppP,xv);
yvc=yvc';

%valori funzione test nei punti di valutazione
yf=fun(xv);

%grafico funzione test e interpolante Lagrange
figure(1);
%grafico funzione test e interpolante cubita a tratti
subplot(3,1,3);
hold on;
title('Cubica a tratti C1')
%disegno punti di interpolazione
plot(x,y,'ro');
%grafico funzione test
plot(xv,yf,'r-','LineWidth',2);
%grafico polinomio interpolante forma di Bernstein
plot(xv,yvc,'g-','LineWidth',2);

%errore di interpolazione in valore assoluto
yvcubic=abs(yf-yvc);

%grafici errori assoluti analitici
figure(2);
subplot(3,1,3);

plot(xv,yvcubic,'g-','LineWidth',2);
title('Eanal: cubica a tratti C1')

%grafici errori assoluti analitici in scala logaritmica
figure(3);
subplot(3,1,3);
semilogy(xv,yvcubic,'g-','LineWidth',2);
title('scala log. Eanal: cubica a tratti C1')

%stampa max errori assoluti di interpolazione in [a,b]
fprintf('Errore interp.  cubica a tratti: %22.15e\n',max(yvcubic));