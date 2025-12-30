% =========================================================================
% SCRIPT: Ricerca degli zeri di funzioni con il metodo di Newton
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
% METODO DI NEWTON (o delle tangenti):
% main_tangmet chiama la function tangmet per il metodo di Newton
% e visualizza graficamente la funzione di cui si cercano gli zeri.
%   fun    --> indice della funzione test
%   x0     --> iterato iniziale
%   tol    --> tolleranza richiesta
%   ftrace --> se >0 stampa successione iterati, 0 no
% =========================================================================

close all;
clear;
clc;

% CONFIGURAZIONE: seleziona funzione (da 1 a 8)

id_funzione = 4;
tolleranza = 1e-6;
ftrace = 1;  % 1 = stampa iterati, 0 = no

% METODO DI NEWTON

switch id_funzione

    case 1
        % ID 1: x0 = 1.745
        main_tangmet(1, 1.745, tolleranza, ftrace);

    case 2
        % ID 2: x0 = 0.95
        main_tangmet(2, 0.95, tolleranza, ftrace);

    case 3
        % ID 3: due radici
        %   - Prima radice (semplice): x0 = 1.95 → ~4 iterazioni
        %   - Seconda radice (molteplicità 2): x0 = 0.9 → ~17 iterazioni

        main_tangmet(3, 1.95, tolleranza, ftrace);  % radice semplice
        % main_tangmet(3, 0.9, tolleranza, ftrace);   % radice multipla

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
        main_tangmet(4, 1.25, tolleranza, ftrace);

    case 5
        % ID 5: due radici
        %   - Prima radice (semplice, x=-2): x0 = -2.005 → convergenza quadratica
        %   - Seconda radice (molteplicità 2, x=1): x0 = 0.95 → convergenza lineare

        main_tangmet(5, -2.005, tolleranza, ftrace);  % radice semplice (p=2)
        % main_tangmet(5, 0.95, tolleranza, ftrace);    % radice multipla (p=1)

    case 6
        % ID 6: x0 = 0.45
        main_tangmet(6, 0.45, tolleranza, ftrace);

    case 7
        % ID 7: x0 = 0.95
        main_tangmet(7, 0.95, tolleranza, ftrace);

    case 8
        % ID 8: x0 = 0.35
        % Radice con molteplicità 2 → convergenza lineare, ~17 iterazioni
        main_tangmet(8, 0.35, tolleranza, ftrace);

    otherwise
        fprintf('Errore: id_funzione deve essere tra 1 e 8\n');

end

%% ========================================================================
% NOTE SULLA CONVERGENZA DEL METODO DI NEWTON
% =========================================================================
%
% FORMULA ITERATIVA:
%   x_{k+1} = x_k - f(x_k) / f'(x_k)
%
% ORDINE DI CONVERGENZA:
%   - Radice semplice (m=1): convergenza QUADRATICA (p=2)
%     L'errore al passo k+1 è proporzionale al quadrato dell'errore al passo k:
%     e_{k+1} ≈ C * e_k^2
%     Significa che il numero di cifre corrette RADDOPPIA ad ogni iterazione.
%
%   - Radice multipla (m>1): convergenza LINEARE (p=1)
%     L'errore si riduce di un fattore costante ad ogni iterazione:
%     e_{k+1} ≈ (1 - 1/m) * e_k
%     Per m=2: e_{k+1} ≈ 0.5 * e_k (simile alla bisezione)
%
% CONFRONTO ITERAZIONI (esempio pratico):
%   - Radice semplice con tol=1e-6: ~4-6 iterazioni
%   - Radice doppia con tol=1e-6: ~15-20 iterazioni
%
% EFFETTO DELLA TOLLERANZA:
%   - Newton può convergere fino alla precisione macchina (~1e-15 in double)
%   - Tolleranza piccola (1e-15) → più iterazioni, massima precisione
%   - Tolleranza grande (1e-6) → meno iterazioni, precisione sufficiente
%
% VANTAGGI DI NEWTON:
%   - Molto veloce per radici semplici (quadratico)
%   - Poche iterazioni per alta precisione
%
% SVANTAGGI DI NEWTON:
%   - Richiede il calcolo della derivata f'(x)
%   - Può divergere se x0 è scelto male
%   - Può fallire se f'(x) ≈ 0 vicino alla radice
%   - Lento per radici multiple (diventa lineare)
%
% SOLUZIONE PER RADICI MULTIPLE:
%   Newton modificato: x_{k+1} = x_k - m * f(x_k) / f'(x_k)
%   dove m è la molteplicità nota. Ripristina convergenza quadratica.
% =========================================================================