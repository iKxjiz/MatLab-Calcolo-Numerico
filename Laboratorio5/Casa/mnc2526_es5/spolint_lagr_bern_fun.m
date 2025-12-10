% script spolint_lagr_bern_fun.m
% Interpolante polinomiale di grado n di una funzione test:
% si utilizzano le forme sia di Lagrange che di Bernstein;
% definire una function con la funzione test e settare
% n      : grado del polinomio interpolante
% tipo   : di distribuzione dei punti 1=equispaziati 2=chebyshev
% Viene prodotto il grafico della funzione test, del polinomio 
% interpolante e dei punti di interpolazione
clear
close all

%definire la funzione test: vedere le funzioni test presenti nella cartella
%funzione test ed estremi intervallo di definizione
fun =@(x) runge(x);
a=-5;
b=5;

%definisce grado del polinomio e punti di interpolazione
n=17;
tipo=2;
switch (tipo)
    case 1
%n+1 punti equispaziati
      x=linspace(a,b,n+1);
    case 2
%n+1 punti secondo la distribuzione di Chebyshev
      x=chebyshev2(a,b,n);
end

%n+1 osservazioni campionate dalla funzione test
y=fun(x);

m=21;
%punti su cui valutare l'interpolante polinomiale modo 1
% xv=linspace(a,b,m*n+1);
%punti su cui valutare l'interpolante polinomiale modo 2
in=0;
for i=1:n
   xv(in+1:in+m)=linspace(x(i),x(i+1),m);
   in=in+m-1;
end

%Metodo di interpolazione: forma di Lagrange
%i coeff. del polinomio sono i dati y(i);
 
%valutazione nella II forma di Lagrange
yvl=lagrval2(y,x,xv);

%Metodo di interpolazione: forma di Bernstein
%i coeff. sono calcolati risolvendo un sistema lineare 
%(operatore left division di MATLAB);
t=(x-a)./(b-a);
B=bernst_val(n,t);
c=B\y';
bern.deg=n;
bern.ab=[a,b];
bern.cp=c;
%valutazione con l'algoritmo di de Casteljau
yvb=decast_val(bern,xv);
yvb=yvb';

%valutazione della funzione test
yf=fun(xv);

%errore di interpolazione in valore assoluto dei due interpolanti
yvlerr=abs(yf-yvl);
yvberr=abs(yf-yvb);

%grafico funzione test e interpolante Lagrange
figure(1);
subplot(2,1,1);
hold on;
title('Forma di Lagrange')
%disegno punti di interpolazione
plot(x,y,'ro');
%grafico funzione test
plot(xv,yf,'r-','LineWidth',2);
%grafico polinomio interpolante forma di Lagrange
plot(xv,yvl,'b-','LineWidth',2);

%grafico funzione test e interpolante Bernstein
subplot(2,1,2);
hold on;
title('Forma di Bernstein')
%disegno punti di interpolazione
plot(x,y,'ro');
%grafico funzione test
plot(xv,yf,'r-','LineWidth',2);
%grafico polinomio interpolante forma di Bernstein
plot(xv,yvb,'g-','LineWidth',2);

%grafici degli errori di interpolazione in valore assoluto 
%dei due interpolanti
figure(2);
subplot(2,1,1);
title('Eanal: forma di Lagrange')
plot(xv,yvlerr,'b-','LineWidth',2);
title('Eanal: forma di Lagrange')
subplot(2,1,2);
title('Eanal: forma di Bernstein')
plot(xv,yvberr,'g-','LineWidth',2);
title('Eanal: forma di Bernstein')

%grafici degli errori di interpolazione in valore assoluto 
%dei due interpolanti in scala logaritmica
figure(3);
subplot(2,1,1);
semilogy(xv,yvlerr,'b-','LineWidth',2);
title('scala log. Eanal: forma di Lagrange')
subplot(2,1,2);
semilogy(xv,yvberr,'g-','LineWidth',2);
title('scala log. Eanal: forma di Bernstein')

%stampa max errori assoluti di interpolazione in [a,b]
fprintf('Errore interpolazione Lagrange : %22.15e\n',max(yvlerr));
fprintf('Errore interpolazione Bernstein: %22.15e\n',max(yvberr));

% %calcolo e grafico del numero di condizione
% Lin=lagrange(n,x,xv);
% CI=sum(abs(Lin'));
% %grafico
% figure(10)
% hold on
% title('Condizionamento Interpolazione')
% plot(xv,CI,'b-','LineWidth',2);