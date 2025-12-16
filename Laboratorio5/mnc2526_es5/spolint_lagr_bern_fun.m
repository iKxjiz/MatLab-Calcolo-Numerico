% =========================================================================
% SCRIPT: spolint_lagr_bern_fun.m
% =========================================================================
% Confronto tra interpolazione polinomiale in forma di Lagrange e Bernstein.
%
% Input da configurare:
%   - fun  : funzione test da interpolare
%   - [a,b]: intervallo di definizione
%   - n    : grado del polinomio interpolante
%   - tipo : distribuzione dei nodi (1 = equispaziati, 2 = Chebyshev)
%
% Output:
%   - Grafici della funzione, degli interpolanti e degli errori
%   - Stampa a video degli errori massimi di interpolazione
% =========================================================================

clear
close all

% SEZIONE 1: DEFINIZIONE DEL PROBLEMA

% Funzione test da interpolare (modificare qui per cambiare funzione)
fun = @(x) rungep(x);

% Estremi dell'intervallo di definizione
a = -5;
b = 5;

% Grado del polinomio interpolante (n+1 punti di interpolazione)
n = 17;

% Risultati tipici all'aumentare di n con nodi di Chebyshev:
%  >> n = 17
%  Errore interpolazione Lagrange :  6.684633012357988e-02
%  Errore interpolazione Bernstein:  6.684633012358077e-02
%  >> n = 50
%  Errore interpolazione Lagrange :  4.621495213436022e-05
%  Errore interpolazione Bernstein:  4.619539557271235e-05
% L'errore diminuisce perché Chebyshev controlla il fenomeno di Runge.

% SEZIONE 2: GENERAZIONE DEI NODI DI INTERPOLAZIONE

tipo = 2;  % 1 = equispaziati, 2 = Chebyshev

switch (tipo)
    case 1
        % Nodi equispaziati: semplici ma soggetti al fenomeno di Runge
        x = linspace(a, b, n+1);
    case 2
        % Nodi di Chebyshev: addensati ai bordi, controllano Runge
        x = chebyshev2(a, b, n);
end

% NOTA SUL FENOMENO DI RUNGE:
% Con nodi equispaziati e n grande, l'interpolante oscilla violentemente
% ai bordi dell'intervallo. I nodi di Chebyshev risolvono questo problema
% perché sono più densi agli estremi e più radi al centro.

% Valori della funzione nei nodi di interpolazione
y = fun(x);

% SEZIONE 3: GRIGLIA DI VALUTAZIONE

% Numero di punti di valutazione per ogni sottointervallo [x(i), x(i+1)]
m = 21;

% Costruzione della griglia di valutazione xv
% La griglia è più fitta vicino ai nodi di interpolazione, dove
% tipicamente l'errore varia più rapidamente.

%punti su cui valutare l'interpolante polinomiale modo 1
% xv=linspace(a,b,m*n+1);

%punti su cui valutare l'interpolante polinomiale modo 2
in = 0;
for i = 1:n
    xv(in+1 : in+m) = linspace(x(i), x(i+1), m);
    in = in + m - 1;  % -1 per evitare duplicazione del punto di giunzione
end

% Il ciclo costruisce la griglia di valutazione xv suddividendo ogni
% sottointervallo [xi,xi+1] in m punti equispaziati. L'indice "in" tiene
% traccia della posizione corrente nel vettore xv, e viene incrementato
% di m-1 (anziché m) per evitare di duplicare i punti di giunzione tra
% sottointervalli adiacenti.

% SEZIONE 4: INTERPOLAZIONE IN FORMA DI LAGRANGE

% Nella forma di Lagrange i coefficienti sono direttamente i valori y(i).
% La valutazione usa la seconda forma baricetrica (lagrval2), che è
% numericamente più stabile della forma classica.

yvl = lagrval2(y, x, xv);

% SEZIONE 5: INTERPOLAZIONE IN FORMA DI BERNSTEIN

% Passo 1: Cambio di variabile da [a,b] a [0,1]
% I polinomi di Bernstein sono definiti su [0,1]
t = (x - a) ./ (b - a);

% Passo 2: Costruzione della matrice delle basi di Bernstein
% B(i,k) = valore della k-esima base di Bernstein nel punto t(i)
B = bernst_val(n, t);

% Passo 3: Calcolo dei coefficienti risolvendo il sistema lineare B*c = y
% (si usano i coefficienti c tali che il polinomio interpoli i dati)
c = B \ y';

% Passo 4: Struttura dati per l'algoritmo di de Casteljau
bern.deg = n;        % grado del polinomio
bern.ab = [a, b];    % intervallo di definizione
bern.cp = c;         % coefficienti nella base di Bernstein

% Passo 5: Valutazione con l'algoritmo di de Casteljau
% De Casteljau è molto stabile: usa solo combinazioni convesse
yvb = decast_val(bern, xv);
yvb = yvb';

% SEZIONE 6: CALCOLO DEGLI ERRORI

% Valori esatti della funzione test sulla griglia di valutazione
yf = fun(xv);

% Errore assoluto di interpolazione: |f(x) - p(x)|
yvlerr = abs(yf - yvl);  % errore forma di Lagrange
yvberr = abs(yf - yvb);  % errore forma di Bernstein

% SEZIONE 7: GRAFICI

% --- Figura 1: Confronto funzione test vs interpolanti ---
figure(1);

% Subplot superiore: forma di Lagrange
subplot(2,1,1);
hold on;
title('Forma di Lagrange')
plot(x, y, 'ro');              % nodi di interpolazione
plot(xv, yf, 'r-', 'LineWidth', 2);   % funzione test (rosso)
plot(xv, yvl, 'b-', 'LineWidth', 2);  % interpolante Lagrange (blu)

% Subplot inferiore: forma di Bernstein
subplot(2,1,2);
hold on;
title('Forma di Bernstein')
plot(x, y, 'ro');              % nodi di interpolazione
plot(xv, yf, 'r-', 'LineWidth', 2);   % funzione test (rosso)
plot(xv, yvb, 'g-', 'LineWidth', 2);  % interpolante Bernstein (verde)

% --- Figura 2: Errori in scala lineare ---
figure(2);

subplot(2,1,1);
plot(xv, yvlerr, 'b-', 'LineWidth', 2);
title('Errore assoluto: forma di Lagrange')

subplot(2,1,2);
plot(xv, yvberr, 'g-', 'LineWidth', 2);
title('Errore assoluto: forma di Bernstein')

% --- Figura 3: Errori in scala logaritmica ---
% La scala logaritmica evidenzia meglio le differenze su più ordini di grandezza
figure(3);

subplot(2,1,1);
semilogy(xv, yvlerr, 'b-', 'LineWidth', 2);
title('Errore assoluto (scala log): forma di Lagrange')

subplot(2,1,2);
semilogy(xv, yvberr, 'g-', 'LineWidth', 2);
title('Errore assoluto (scala log): forma di Bernstein')

% SEZIONE 8: STAMPA DEI RISULTATI

fprintf('Errore interpolazione Lagrange : %22.15e\n', max(yvlerr));
fprintf('Errore interpolazione Bernstein: %22.15e\n', max(yvberr));

% SEZIONE OPZIONALE: ANALISI DEL CONDIZIONAMENTO (commentata)

% % Calcolo del numero di condizione dell'interpolazione
% % (costante di Lebesgue approssimata)
% Lin = lagrange(n, x, xv);
% CI = sum(abs(Lin'));
%
% figure(10)
% hold on
% title('Condizionamento Interpolazione')
% plot(xv, CI, 'b-', 'LineWidth', 2)