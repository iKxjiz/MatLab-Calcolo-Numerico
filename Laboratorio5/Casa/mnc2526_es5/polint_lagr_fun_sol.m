function err=polint_lagr_fun(ifun,n,tipo,fig)
% Interpolante polinomiale di grado n di una funzione test:
% si utilizza la forma di Lagrange;
% input
% ifun   : indice funzione test
% n      : grado del polinomio interpolante
% tipo   : di distribuzione dei punti 1=equispaziati 2=chebyshev
% Viene prodotto il grafico della funzione test, del polinomio interpolante
% e dei punti di interpolazione

%setting per la funzione test:
%funzione test ed estremi intervallo di definizione
switch ifun
    case 1
        f =@(x) fun1(x);
        a=-pi;
        b=pi;
    case 2
        f =@(x) fun2(x);
        a=-2;
        b=2;
    case 3
        f =@(x) polfun1(x);
        a=-1;
        b=3.5;
    case 4
        f =@(x) runge(x);
        a=-5.0;
        b=5.0;
    case 5
        f =@(x) fun3(x);
        a=-2;
        b=1;
end

%definisce punti di interpolazione
switch (tipo)
    case 1
%n+1 punti equispaziati
      x=linspace(a,b,n+1);
    case 2
%n+1 punti secondo la distribuzione di chebyshev
      x=chebyshev2(a,b,n);
end

%n+1 osservazioni campionate dalla funzione test
y=f(x);

%punti su cui valutare l'interpolante polinomiale
m=20;
in=0;
for i=1:n
   xv(in+1:in+m)=linspace(x(i),x(i+1),m);
   in=in+m-1;
end

%Metodo di interpolazione: forma di Lagrange
%i coeff. del polinomio sono i dati y(i);

%valutazione nella II forma di Lagrange
yv=lagrval2(y,x,xv);

%valutazione funzione test
yf=f(xv);
%errore di interpolazione in valore assoluto
yerr=abs(yf-yv);

if (fig==1)
    %apertura finestra per grafico funzione analitica e interpolante
    figure;
    subplot(3,1,1);
    hold on;
    %grafico funzione test
    plot(xv,yf,'r-','LineWidth',2);
    %disegno punti di interpolazione
    plot(x,y,'ro');
    %grafico polinomio interpolante
    plot(xv,yv,'g-','LineWidth',2);
    title(['Interpolazione forma di Lagrange; n=',num2str(n)])
    %grafico errore analitico e stampa max errore assoluto in [a,b]
    subplot(3,1,2)
    plot(xv,yerr,'g-','LineWidth',2);
    title('Eanal: forma di Lagrange')
    %grafico errore analitico assoluto in scala logaritmica
    subplot(3,1,3)
    semilogy(xv,yerr,'g-','LineWidth',2);
    title('Eanal scala log.: forma di Lagrange')
end

err=max(yerr);
%stampa max errore assoluto di interpolazione in [a,b]
fprintf('Forma di Lagrange:  n.punti: %3d MaxErr: %22.15e\n',n+1,err);
end