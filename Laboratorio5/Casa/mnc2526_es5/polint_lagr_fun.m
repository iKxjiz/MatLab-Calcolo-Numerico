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
%TO DO

%n+1 osservazioni campionate dalla funzione test
%TO DO

%punti su cui valutare l'interpolante polinomiale, modo 2
%TO DO

%Metodo di interpolazione: forma di Lagrange
%i coeff. del polinomio sono i dati y(i);

%valutazione nella II forma di Lagrange
%TO DO

%valutazione funzione test
%TO DO
%errore di interpolazione in valore assoluto
%TO DO

if (fig==1)
%TO DO
end

%max dell'errore
err=max(yerr);
%stampa max errore assoluto di interpolazione in [a,b]
%TO DO
end