%script spolint_lagr_fun_test.m
%Codice main che richiama la function polint_lagr_fun
close all
clear
ifun=2;
tipo=2;
fig=1;
% mrange=2.^(2:8);
mrange=4:10:80;
k=1;
for n=mrange
   err(k)=polint_lagr_fun(ifun,n,tipo,fig);
   k=k+1;
end
figure
loglog(mrange,err,'r*-','LineWidth',1.5);

% Convergenza dell'interpolazione (funzione 1: fun1):
% All'aumentare del numero di nodi n, l'errore massimo di interpolazione
% decresce, indicando che il polinomio approssima sempre meglio la funzione.
% L'errore scende da ~10^0 fino a ~10^-15, dopodiché si stabilizza.
% Questo plateau corrisponde alla precisione di macchina (eps ~ 2.2e-16):
% non è possibile ottenere errori più piccoli in aritmetica floating point
% a doppia precisione. La convergenza è quindi "completa".

% Convergenza dell'interpolazione (funzione 2: fun2):
% All'aumentare del numero di nodi n, l'errore massimo di interpolazione
% decresce molto lentamente, rimanendo sempre intorno a ~0.91.
% Questo indica una convergenza estremamente lenta o quasi assente.
% La causa tipica è una funzione con scarsa regolarità (es. discontinuità
% nella funzione o nelle derivate), che limita la velocità di convergenza
% dell'interpolazione polinomiale indipendentemente dalla scelta dei nodi.

% Convergenza dell'interpolazione (funzione 3: fun3):
% L'errore massimo è già alla precisione di macchina (~10^-15) fin dal
% primo test con soli 5 nodi, e rimane costante all'aumentare di n.
% Questo indica che la funzione test è un polinomio di grado <= 4:
% l'interpolazione è esatta (a meno degli errori di arrotondamento)
% già con 5 punti, e aggiungere nodi non migliora ulteriormente.

% Convergenza dell'interpolazione (funzione 4: fun4):
% All'aumentare del numero di nodi n, l'errore massimo decresce in modo
% regolare e costante, passando da ~10^-1 a ~10^-7.
% Questo indica una convergenza algebrica (polinomiale): l'errore si riduce
% di circa un ordine di grandezza ogni 10 nodi aggiuntivi.
% La funzione è regolare ma non analitica, oppure ha derivate limitate,
% il che impedisce la convergenza esponenziale vista nella funzione 1.

% Convergenza dell'interpolazione (funzione 5: fun5):
% L'errore decresce molto rapidamente: da ~10^-3 con 5 nodi a ~10^-14
% già con 15 nodi, poi si stabilizza alla precisione di macchina (~10^-15).
% Questo indica convergenza esponenziale, tipica di funzioni analitiche
% (infinitamente differenziabili). La convergenza è "completa" già con
% pochi nodi, e aumentare ulteriormente n non porta miglioramenti
% perché si è raggiunto il limite dell'aritmetica floating point.
