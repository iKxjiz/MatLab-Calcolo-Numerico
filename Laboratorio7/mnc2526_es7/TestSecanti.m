% =========================================================================
% SCRIPT: Ricerca degli zeri di funzioni con il metodo delle Secanti
% =========================================================================
% Si considerino le seguenti funzioni test di cui si vogliono
% determinare gli zeri o radici dell'equazione associata.
% Nella cartella è presente la function def_fun.m che le implementa:
%
% zfunf01 f(x) = (4x − 7)/(x − 2)                                x ∈ [1, 1.9]
% zfunf02 f(x) = 1 + 3/x^2 − 4/x^3                               x ∈ [0.5, 6]
% zfunf03 f(x) = 1 − 2.5x + 3x^2 − 3x^3 + 2x^4 − 0.5x^5          x ∈ [0, 3]
% zfunf04 f(x) = x^n − 2                                         x ∈ [0, 2], n = 2,3,4
% zfunf05 f(x) = x^3 − 3x + 2                                    x ∈ [−2.5, 2]
% zfunf06 f(x) = 1/x − 2                                         x ∈ (0, 4]
% zfunf07 f(x) = tanh(x − 1)                                     x ∈ [−1, 3]
% zfunf08 f(x) = (1−x)^3 − 13/3(1−x)^2*x + 25/4(1−x)x^2 − 3x^3   x ∈ [0, 1]
%
% Si noti che la function def_fun.m contiene anche le derivate prime,
% nella forma zfunp0x.
%
% METODO DELLE SECANTI:
% main_secmet chiama la function secmet per il metodo delle secanti
% e visualizza graficamente la funzione di cui si cercano gli zeri.
%   ifun   --> indice della funzione test
%   x0,x1  --> iterati iniziali
%   tol    --> tolleranza richiesta
%   ftrace --> se >0 stampa successione iterati, 0 no
% =========================================================================

close all;
clear;
clc;

% CONFIGURAZIONE: seleziona funzione (da 1 a 8)

id_funzione = 8;
tolleranza = 1e-6;
ftrace = 1;  % 1 = stampa iterati, 0 = no

% METODO DELLE SECANTI

switch id_funzione

    case 1
        % ID 1: x0 = 1.725, x1 = 1.735
        main_secmet(1, 1.725, 1.735, tolleranza, ftrace);

    case 2
        % ID 2: x0 = 0.90, x1 = 0.95
        main_secmet(2, 0.90, 0.95, tolleranza, ftrace);

    case 3
        % ID 3: due radici
        %   - Prima radice (semplice): x0 = 1.90, x1 = 1.95 → ~6 iterazioni
        %   - Seconda radice (molteplicità 2): x0 = 0.9, x1 = 0.95 → ~22 iterazioni

        main_secmet(3, 1.90, 1.95, tolleranza, ftrace);  % radice semplice
        % main_secmet(3, 0.9, 0.95, tolleranza, ftrace);   % radice multipla

        % NOTA: si noti come il numero di iterazioni cambi drasticamente.
        % Per la "prima radice" (radice semplice), l'ordine di convergenza
        % del metodo rimane 1.618... (sezione aurea).
        % Per la "seconda radice" (radice con molteplicità m=2), l'ordine
        % di convergenza passa da 1.618... a lineare (p=1).
        %
        % REGOLA GENERALE:
        %   radice semplice → convergenza superlineare (p ≈ 1.618)
        %   radice multipla di molteplicità m>1 → convergenza lineare (p=1)

    case 4
        % ID 4: x0 = 1.20, x1 = 1.22
        main_secmet(4, 1.20, 1.22, tolleranza, ftrace);

    case 5
        % ID 5: due radici
        %   - Prima radice (semplice, x=-2): x0 = -2.015, x1 = -2.010 → ord.conv. ≈ 1.618
        %   - Seconda radice (molteplicità 2, x=1): x0 = 0.90, x1 = 0.95 → ord.conv. = 1

        main_secmet(5, -2.015, -2.010, tolleranza, ftrace);  % radice semplice
        % main_secmet(5, 0.90, 0.95, tolleranza, ftrace);      % radice multipla (~22 iter)

        % NOTA: troppe iterazioni (22) per la radice multipla.
        % Questo perché vicino a una radice multipla, il grafico della funzione
        % è molto piatto.
        % Le secanti SI TAGLIANO MALE: il punto di intersezione della secante
        % con l'asse x avanza "molto lentamente" → ordine 1.

    case 6
        % ID 6: x0 = 0.40, x1 = 0.45
        main_secmet(6, 0.40, 0.45, tolleranza, ftrace);

    case 7
        % ID 7: x0 = 0.90, x1 = 0.95
        main_secmet(7, 0.90, 0.95, tolleranza, ftrace);

    case 8
        % ID 8: x0 = 0.32, x1 = 0.35
        % Radice con molteplicità 2 → convergenza lineare, ~17 iterazioni
        main_secmet(8, 0.32, 0.35, tolleranza, ftrace);

        % Anche in questo caso: vicino a una radice multipla, il grafico della
        % funzione è molto piatto.
        % Le secanti SI TAGLIANO MALE: il punto di intersezione della secante
        % con l'asse x avanza "molto lentamente" → ordine 1.

    otherwise
        fprintf('Errore: id_funzione deve essere tra 1 e 8\n');

end

%% ========================================================================
% NOTE SULLA CONVERGENZA DEL METODO DELLE SECANTI
% =========================================================================
%
% FORMULA ITERATIVA:
%   x_{k+1} = x_k - f(x_k) * (x_k - x_{k-1}) / (f(x_k) - f(x_{k-1}))
%
% Il metodo approssima la derivata f'(x_k) con il rapporto incrementale:
%   f'(x_k) ≈ (f(x_k) - f(x_{k-1})) / (x_k - x_{k-1})
%
% ORDINE DI CONVERGENZA:
%   - Radice semplice (m=1): convergenza SUPERLINEARE (p = φ ≈ 1.618)
%     dove φ = (1 + √5)/2 è la sezione aurea.
%     L'errore soddisfa: e_{k+1} ≈ C * e_k^1.618
%     Più lento di Newton (p=2), ma non richiede la derivata.
%
%   - Radice multipla (m>1): convergenza LINEARE (p=1)
%     Vicino a una radice multipla la funzione è "piatta" (f'(x*) = 0).
%     La secante diventa quasi orizzontale e il punto di intersezione
%     con l'asse x avanza molto lentamente.
%
% CONFRONTO ITERAZIONI (esempio pratico):
%   - Radice semplice con tol=1e-6: ~5-7 iterazioni
%   - Radice doppia con tol=1e-6: ~20-25 iterazioni
%
% CONFRONTO CON ALTRI METODI:
%   | Metodo     | Ordine (rad. semplice) | Ordine (rad. multipla) | Derivata |
%   |------------|------------------------|------------------------|----------|
%   | Bisezione  | 1 (lineare)            | 1 (lineare)            | No       |
%   | Secanti    | 1.618 (superlineare)   | 1 (lineare)            | No       |
%   | Newton     | 2 (quadratico)         | 1 (lineare)            | Sì       |
%
% VANTAGGI DELLE SECANTI:
%   - Non richiede il calcolo della derivata f'(x)
%   - Più veloce della bisezione
%   - Buon compromesso tra velocità e semplicità
%
% SVANTAGGI DELLE SECANTI:
%   - Più lento di Newton per radici semplici
%   - Richiede due punti iniziali x0 e x1
%   - Può divergere se i punti iniziali sono scelti male
%   - Può fallire se f(x_k) ≈ f(x_{k-1}) (secante quasi orizzontale)
%   - Lento per radici multiple (diventa lineare)
%
% PERCHÉ LE SECANTI "SI TAGLIANO MALE" PER RADICI MULTIPLE:
%   Vicino a una radice multipla x*, la funzione si comporta come
%   f(x) ≈ C(x - x*)^m, quindi è molto piatta.
%   La secante tra due punti vicini alla radice ha pendenza quasi nulla,
%   e la sua intersezione con l'asse x è molto lontana dalla radice.
%   Risultato: convergenza lenta (lineare invece di superlineare).
%
% =========================================================================