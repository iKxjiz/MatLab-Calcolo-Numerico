% =========================================================================
% SCRIPT: Ricerca degli zeri con Newton e analisi dell'ordine di convergenza
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
% METODO DI NEWTON CON ANALISI ORDINE DI CONVERGENZA:
% main_tangmet_ordconv chiama tangmet per il metodo di Newton
% e visualizza graficamente la funzione di cui si cercano gli zeri,
% oltre a stampare le quantità |e_{k+1}|/|e_k| e |e_{k+1}|/|e_k|^2
% per analizzare l'ordine di convergenza.
%   ifun   --> indice della funzione test
%   x0     --> iterato iniziale
%   tol    --> tolleranza richiesta
%   ftrace --> se >0 produce stampe informative
% =========================================================================

close all;
clear;
clc;

% CONFIGURAZIONE: seleziona funzione (da 1 a 8)

id_funzione = 6;
tolleranza = 1e-6;
ftrace = 1;  % 1 = stampa iterati e analisi convergenza, 0 = no

% METODO DI NEWTON CON ORDINE DI CONVERGENZA

switch id_funzione

    case 1
        % ID 1: x0 = 1.745
        main_tangmet_ordconv(1, 1.745, tolleranza, ftrace);

    case 2
        % ID 2: x0 = 0.95
        main_tangmet_ordconv(2, 0.95, tolleranza, ftrace);

    case 3
        % ID 3: due radici
        %   - Prima radice (semplice): x0 = 1.95 → ~4 iterazioni
        %   - Seconda radice (molteplicità 2): x0 = 0.9 → ~17 iterazioni

        main_tangmet_ordconv(3, 1.95, tolleranza, ftrace);  % radice semplice
        % main_tangmet_ordconv(3, 0.9, tolleranza, ftrace);   % radice multipla

        % NOTA: si noti come il numero di iterazioni cambi drasticamente.
        % Per la "prima radice" (radice semplice), l'ordine di convergenza
        % di Newton rimane quadratico (p=2).
        % Per la "seconda radice" (radice con molteplicità m=2), l'ordine
        % di convergenza passa da quadratico a lineare (p=1).
        %
        % REGOLA GENERALE:
        %   radice semplice → convergenza quadratica (p=2)
        %   radice multipla di molteplicità m>1 → convergenza lineare (p=1)

    case 4
        % ID 4: x0 = 1.25
        main_tangmet_ordconv(4, 1.25, tolleranza, ftrace);

    case 5
        % ID 5: due radici
        %   - Prima radice (semplice, x=-2): x0 = -2.005 → convergenza quadratica
        %   - Seconda radice (molteplicità 2, x=1): x0 = 0.95 → convergenza lineare

        main_tangmet_ordconv(5, -2.005, tolleranza, ftrace);  % radice semplice (p=2)
        % main_tangmet_ordconv(5, 0.95, tolleranza, ftrace);    % radice multipla (p=1)

    case 6
        % ID 6: x0 = 0.45
        main_tangmet_ordconv(6, 0.45, tolleranza, ftrace);

    case 7
        % ID 7: x0 = 0.95
        main_tangmet_ordconv(7, 0.95, tolleranza, ftrace);

    case 8
        % ID 8: x0 = 0.35
        % Radice con molteplicità 2 → convergenza lineare, ~17 iterazioni
        main_tangmet_ordconv(8, 0.35, tolleranza, ftrace);

    otherwise
        fprintf('Errore: id_funzione deve essere tra 1 e 8\n');

end

%% ========================================================================
% NOTE SULL'ORDINE DI CONVERGENZA DEL METODO DI NEWTON
% =========================================================================
%
% ANALISI DELLE QUANTITÀ |e_{k+1}|/|e_k| E |e_{k+1}|/|e_k|^2:
%
% Per zeri (radici) multipli, le ultime colonne della tabella cambiano
% drasticamente. Nel metodo di Newton il comportamento delle quantità
% |e_{k+1}|/|e_k| e |e_{k+1}|/|e_k|^2 cambia in modo significativo a
% seconda che la radice sia semplice oppure multipla.
%
% CASO 1: RADICE SEMPLICE (m=1)
%   Newton converge quadraticamente: l'errore soddisfa approssimativamente
%       |e_{k+1}| ≈ C |e_k|^2
%   (l'errore alla prossima iterazione è circa il quadrato dell'errore attuale).
%
%   Di conseguenza, nella tabella si osserva che:
%   - |e_{k+1}|/|e_k|^2 → C (costante finita e non nulla)
%   - |e_{k+1}|/|e_k| → 0 (rapidamente, perché l'errore cala quadraticamente)
%
% CASO 2: RADICE MULTIPLA (m>1)
%   La convergenza di Newton non è più quadratica ma solo lineare.
%   L'errore soddisfa approssimativamente:
%       |e_{k+1}| ≈ (1 - 1/m) |e_k|
%   (per m=2: |e_{k+1}| ≈ 0.5 |e_k|)
%
%   Di conseguenza, nella tabella si osserva che:
%   - |e_{k+1}|/|e_k| → costante in (0,1) (es. 0.5 per radice doppia)
%   - |e_{k+1}|/|e_k|^2 → +∞ (esplode!)
%
%   Il rapporto |e_{k+1}|/|e_k|^2 esplode perché numeratore e denominatore
%   non sono più dello stesso ordine: l'errore non diminuisce come il quadrato,
%   ma soltanto come un multiplo lineare dell'errore precedente.
%
% RIEPILOGO:
%   | Tipo radice     | |e_{k+1}|/|e_k| | |e_{k+1}|/|e_k|^2 | Ordine |
%   |-----------------|-----------------|-------------------|--------|
%   | Semplice (m=1)  | → 0             | → C (costante)    | p = 2  |
%   | Multipla (m>1)  | → costante      | → +∞              | p = 1  |
%
% INTERPRETAZIONE PRATICA:
%   - Se |e_{k+1}|/|e_k|^2 si stabilizza → convergenza quadratica (radice semplice)
%   - Se |e_{k+1}|/|e_k|^2 esplode → convergenza lineare (radice multipla)
%   - Se |e_{k+1}|/|e_k| si stabilizza su un valore < 1 → convergenza lineare
% =========================================================================