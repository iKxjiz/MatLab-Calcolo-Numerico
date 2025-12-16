% =========================================================================
% SCRIPT: Ricerca degli zeri di funzioni con il metodo di Bisezione
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
% METODO DI BISEZIONE:
% La function main_bisez.m fa uso della function bisez.m che
% implementa il metodo di bisezione.
% Viene effettuato il grafico della funzione f(x) così
% da poter localizzare visivamente gli zeri della funzione
% nell'intervallo e poter definire l'intervallo di innesco
% del metodo.
% =========================================================================

close all;
clear;
clc;

% CONFIGURAZIONE: seleziona funzione (da 1 a 8)

id_funzione = 1;
tolleranza = 1e-6;

% METODO DI BISEZIONE

switch id_funzione

    case 1
        % ID 1: intervallo di innesco [1.7, 1.8]
        main_bisez(1, tolleranza);

    case 2
        % ID 2: intervallo di innesco [0.9, 1.1]
        main_bisez(2, tolleranza);

    case 3
        % ID 3: radici:
        %   1) [1.95, 2.05]
        %   2) [0.9, 1.1] (due radici coincidenti, ordine di convergenza 1)
        main_bisez(3, tolleranza);

        % Verifica radici teoriche:
        % roots([-0.5, 2, -3, 3, -2.5, 1])
        %   2.0000 + 0.0000i  (radice reale)
        %   0.0000 + 1.0000i  (radice complessa i)
        %   0.0000 - 1.0000i  (radice complessa -i)
        %   1.0000 + 0.0000i  (radice con molteplicità due)
        %   1.0000 - 0.0000i

    case 4
        % ID 4: intervallo di innesco [1.25, 1.26]
        main_bisez(4, tolleranza);

        % NOTA: si noti come al variare della tolleranza variano anche
        % il numero di iterazioni del metodo di bisezione per cercare
        % le radici.

        % Per tolleranze grandi come 1e-1, ci vogliono pochissime iterazioni
        % ma la precisione della radice è pessima, lo si può vedere graficamente.
        % main_bisez(4, 1e-1);

        % Per tolleranze piccole come 1e-15, il numero di iterazioni aumenta
        % di molto così come aumenta di molto la precisione della radice.
        % main_bisez(4, 1e-15);

        % IMPORTANTE: dopo un certo punto il numero di iterazioni non aumenta più,
        % questo perché il metodo arriva al limite della precisione
        % macchina, circa eps ≈ 2.2e-16 (1e-15).
        % Non esistono numeri distinti più vicini tra loro di circa 1e-15.
        % Il metodo non può più migliorare l'approssimazione.

    case 5
        % ID 5: radici:
        %   1) [-2.005, -1.995]
        %   2) [0.95, 1.05] (radice con molteplicità 2)
        main_bisez(5, tolleranza);

        % Verifica: roots([1, 0, -3, 2]) = [-2, 1, 1]

    case 6
        % ID 6: intervallo di innesco [0.495, 0.505]
        main_bisez(6, tolleranza);

    case 7
        % ID 7: intervallo di innesco [0.995, 1.005]
        main_bisez(7, tolleranza);

    case 8
        % ID 8: intervallo di innesco [0.35, 0.45]
        main_bisez(8, tolleranza);

    otherwise
        fprintf('Errore: id_funzione deve essere tra 1 e 8\n');

end

% NOTE SULLA CONVERGENZA DEL METODO DI BISEZIONE
%
% CONVERGENZA LINEARE:
% Il metodo di bisezione ha sempre convergenza lineare con fattore 1/2.
% Ad ogni iterazione l'intervallo si dimezza: e_k+1 = e_k / 2
% Questo significa che servono circa 3.3 iterazioni per guadagnare una
% cifra decimale di precisione (log2(10) ≈ 3.3).
%
% NUMERO DI ITERAZIONI:
% Il numero di iterazioni necessarie per raggiungere tolleranza tol è:
%   k = ceil(log2((b-a)/tol))
% Esempio: [a,b] = [0,2], tol = 1e-6 → k = ceil(log2(2e6)) ≈ 21 iterazioni
%
% EFFETTO DELLA TOLLERANZA:
% - Tolleranza grande (1e-1): poche iterazioni, bassa precisione
% - Tolleranza piccola (1e-15): molte iterazioni, alta precisione
% - Tolleranza < eps (~2.2e-16): inutile, si raggiunge il limite della
%   precisione macchina e il metodo non può più migliorare
%
% RADICI CON MOLTEPLICITÀ > 1:
% Per radici multiple (es. x=1 in x^3-3x+2), il metodo converge comunque
% ma la funzione è "piatta" vicino alla radice, quindi:
% - L'intervallo si riduce sempre di 1/2 (convergenza lineare garantita)
% - Ma l'errore sulla radice può essere maggiore a parità di tolleranza
%
% CONFRONTO CON ALTRI METODI:
% - Bisezione: lento ma GARANTITO (converge sempre se f(a)*f(b) < 0, cioè se
%   considero un intervallo che contiene uno zero)
% - Newton: veloce (quadratico) ma può divergere o ciclare
% - Secanti: veloce (~1.618) ma può fallire
% La bisezione è il metodo più robusto quando non si conosce bene la funzione.
% =========================================================================