% =========================================================================
% SCRIPT: Integrazione numerica con metodi dei Trapezi e Simpson composti
% =========================================================================
% Si considerano le seguenti funzioni test di cui si vuole calcolare
% l'integrale definito sul loro dominio di definizione:
%
% f1 = e^sqrt(x) * sin(x) + 2x - 4    x ∈ [0, 12]   Integrale esatto: 68.3532891202483
% f2 = 32 / (1 + 1024x^2)             x ∈ [0, 4]    Integrale esatto: 1.56298398573480
% f3 = e^(-x) / x                     x ∈ [1, 2]    Integrale esatto: 0.170483423687459
% f4 = 4 / (1 + x^2)                  x ∈ [0, 1]    Integrale esatto: 3.14159265358979 (π)
% f5 = sqrt(1 - x^2) * e^x            x ∈ [0, 1]    Integrale esatto: 1.24395050141647
%
% TEORIA - Ordine di convergenza:
% - Trapezi composto: errore O(h^2), dove h = (b-a)/n
% - Simpson composto: errore O(h^4), quindi converge molto più velocemente
% Aumentando n (riducendo h), l'errore diminuisce significativamente.
% =========================================================================

clear all;
clc;
close all;

%% ========================================================================
% CONFIGURAZIONE GENERALE
% =========================================================================

% Seleziona quali funzioni analizzare (1 = attiva, 0 = disattiva)
analizza_f1 = 1;
analizza_f2 = 1;
analizza_f3 = 1;
analizza_f4 = 1;
analizza_f5 = 1;

% Seleziona quali output produrre
mostra_plot = 0;         % 1 = mostra grafici delle funzioni
mostra_errori = 0;       % 1 = mostra analisi dettagliata degli errori
mostra_derivate = 0;     % 1 = mostra grafici delle derivate (per analisi errore)

%% ========================================================================
% DEFINIZIONE DELLE FUNZIONI TEST
% =========================================================================
% Struttura dati per ogni funzione: nome, estremi, n_trapezi, n_simpson

funzioni = struct();

funzioni(1).nome = 'effe1';
funzioni(1).a = 0;
funzioni(1).b = 12;
funzioni(1).n_trap = 200;
funzioni(1).n_simp = 25;
funzioni(1).descrizione = 'f1 = e^sqrt(x)*sin(x) + 2x - 4';

funzioni(2).nome = 'effe2';
funzioni(2).a = 0;
funzioni(2).b = 4;
funzioni(2).n_trap = 25;
funzioni(2).n_simp = 12;
funzioni(2).descrizione = 'f2 = 32/(1 + 1024x^2)';

funzioni(3).nome = 'effe3';
funzioni(3).a = 1;
funzioni(3).b = 2;
funzioni(3).n_trap = 40;
funzioni(3).n_simp = 20;
funzioni(3).descrizione = 'f3 = e^(-x)/x';

funzioni(4).nome = 'effe4';
funzioni(4).a = 0;
funzioni(4).b = 1;
funzioni(4).n_trap = 30;
funzioni(4).n_simp = 15;
funzioni(4).descrizione = 'f4 = 4/(1+x^2)  [integrale = pi]';

funzioni(5).nome = 'effe5';
funzioni(5).a = 0;
funzioni(5).b = 1;
funzioni(5).n_trap = 50;
funzioni(5).n_simp = 25;
funzioni(5).descrizione = 'f5 = sqrt(1-x^2)*e^x';

% Vettore per selezionare quali funzioni analizzare
attive = [analizza_f1, analizza_f2, analizza_f3, analizza_f4, analizza_f5];

%% ========================================================================
% CICLO PRINCIPALE: INTEGRAZIONE E ANALISI
% =========================================================================

for i = 1:length(funzioni)

    if ~attive(i)
        continue;  % Salta se la funzione non è selezionata
    end

    % Estrai parametri
    f = funzioni(i).nome;
    a = funzioni(i).a;
    b = funzioni(i).b;
    n_trap = funzioni(i).n_trap;
    n_simp = funzioni(i).n_simp;

    % Intestazione
    fprintf('==============================================================\n');
    fprintf('FUNZIONE %d: %s\n', i, funzioni(i).descrizione);
    fprintf('Intervallo: [%.1f, %.1f]\n', a, b);
    fprintf('==============================================================\n');

    % --- Calcolo integrali approssimati ---
    val_trap = trapezi_comp(f, a, b, n_trap, 0);
    val_simp = simpson_comp(f, a, b, n_simp, 0);

    % --- Valore esatto (riferimento) ---
    fhandle = str2func(['@', f]);
    val_esatto = integral(fhandle, a, b);

    % --- Stampa risultati ---
    fprintf('Metodo Trapezi  (n=%3d): %.10f\n', n_trap, val_trap);
    fprintf('Metodo Simpson  (n=%3d): %.10f\n', n_simp, val_simp);
    fprintf('Valore esatto:           %.10f\n', val_esatto);
    fprintf('Errore Trapezi:          %.2e\n', abs(val_esatto - val_trap));
    fprintf('Errore Simpson:          %.2e\n', abs(val_esatto - val_simp));
    fprintf('\n');

    % --- Plot delle funzioni (opzionale) ---
    if mostra_plot
        figure('Name', sprintf('Funzione %d - Grafici', i));

        subplot(1,2,1);
        trapezi_comp(f, a, b, n_trap, 1);
        title(sprintf('Trapezi (n=%d)', n_trap));

        subplot(1,2,2);
        simpson_comp(f, a, b, n_simp, 1);
        title(sprintf('Simpson (n=%d)', n_simp));
    end

    % --- Analisi errori dettagliata (opzionale) ---
    if mostra_errori
        fprintf('--- Analisi errori per %s ---\n', f);
        err_trapezi_comp(f, a, b, n_trap);
        fprintf('\n');
        err_simpson_comp(f, a, b, n_simp);
        fprintf('\n');
    end

    % --- Grafici derivate (opzionale, per analisi teorica errore) ---
    % L'errore dei Trapezi dipende da f''(x), quello di Simpson da f''''(x)
    if mostra_derivate
        % Nomi delle derivate (se esistono)
        d2_name = ['d2_', f];  % derivata seconda
        d4_name = ['d4_', f];  % derivata quarta

        if exist(d2_name, 'file')
            figure('Name', sprintf('Funzione %d - Derivata seconda', i));
            trapezi_comp(d2_name, a, b, 50, 1);
            title(sprintf('f''''(x) per %s - influenza errore Trapezi', f));
        end

        if exist(d4_name, 'file')
            figure('Name', sprintf('Funzione %d - Derivata quarta', i));
            trapezi_comp(d4_name, a, b, 100, 1);
            title(sprintf('f''''''''(x) per %s - influenza errore Simpson', f));
        end
    end

end

%% ========================================================================
% NOTE TEORICHE
% =========================================================================
%
% ERRORE DEL METODO DEI TRAPEZI COMPOSTO:
%   E_T = -(b-a)/12 * h^2 * f''(xi)  per qualche xi in [a,b]
%   Quindi l'errore è O(h^2) e dipende dalla derivata seconda.
%
% ERRORE DEL METODO DI SIMPSON COMPOSTO:
%   E_S = -(b-a)/180 * h^4 * f''''(xi)  per qualche xi in [a,b]
%   Quindi l'errore è O(h^4) e dipende dalla derivata quarta.
%
% OSSERVAZIONI:
% - Simpson converge molto più velocemente di Trapezi (h^4 vs h^2)
% - Per funzioni con derivate alte molto grandi, entrambi i metodi
%   possono richiedere molti sottointervalli
% - Se f''(x) o f''''(x) presentano singolarità o valori molto grandi,
%   le formule di stima dell'errore possono dare NaN
%
% =========================================================================

% HELP IMPORTANTI :
% =========================================================================
% help trapezi_comp :
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula dei trapezi composta;
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% n    --> numero di sottointervalli
% fp   --> 0 no visualizzazione grafica
%          1 visualizzazione funzione e interpolante a tratti
% I    <-- approssimazione dell'integrale
% Vengono effettuate n+1 valutazioni di funzione
% =========================================================================
% help simpson_comp :
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula di simpson composta;
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% n    --> numero di coppie di sottointervalli
% fp   --> 0 no visualizzazione grafica
%          1 visualizzazione funzione e interpolante a tratti
% I    <-- approssimazione dell'integrale
% Vengono effettuate 2n+1 valutazioni di funzione
% =========================================================================
% help err_trapezi_comp :
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula dei trapezi composta e
% calcola l'errore.
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% n    --> numero di sottointervalli
% Viene prodotta una stampa
% =========================================================================
% help err_simpson_comp :
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula di simpson composta e
% calcola l'errore.
% funz --> stringa o handle della funzione integranda
% a,b --> estremi di integrazione
% n    --> numero di sottointervalli
% Viene prodotta una stampa
% =========================================================================

fprintf('=== Fine analisi ===\n');