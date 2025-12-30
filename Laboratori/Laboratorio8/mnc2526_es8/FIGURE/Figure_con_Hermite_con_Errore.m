%% ========================================================================
%  SCRIPT:  hermite_interpolation_demo. m
%  Dimostrazione completa dell'interpolazione di Hermite C^1
%  usando curve cubiche di Bézier a tratti
%
%  Libreria: anmglib_5.0
%  Autore: Script didattico per MNC 2025-2026
%% ========================================================================

clear
close all
clc

%% ========================================================================
%  PARTE 1: DEFINIZIONE CURVA PARAMETRICA DA INTERPOLARE
%% ========================================================================

fprintf('=== INTERPOLAZIONE DI HERMITE CON CURVE DI BÉZIER ===\n\n');

% Scegli il tipo di curva da interpolare
fprintf('Curve disponibili:\n');
fprintf('1. Circonferenza (cp2_circle)\n');
fprintf('2. Spirale (cp2_spiral)\n');
fprintf('3. Lemniscata (cp2_lemniscate)\n');
scelta = input('Scegli la curva (1-3): ');

switch scelta
    case 1
        curva_nome = 'cp2_circle';
        a = 0;
        b = 2*pi;
        fprintf('\nCurva selezionata:  CIRCONFERENZA\n');
    case 2
        curva_nome = 'cp2_spiral';
        a = 0;
        b = 4*pi;
        fprintf('\nCurva selezionata:  SPIRALE\n');
    case 3
        curva_nome = 'cp2_lemniscate';
        a = -pi;
        b = pi;
        fprintf('\nCurva selezionata: LEMNISCATA\n');
    otherwise
        curva_nome = 'cp2_circle';
        a = 0;
        b = 2*pi;
        fprintf('\nValore non valido. Uso CIRCONFERENZA come default.\n');
end

%% ========================================================================
%  PARTE 2: CAMPIONAMENTO PUNTI DI INTERPOLAZIONE
%% ========================================================================

fprintf('\n--- CAMPIONAMENTO PUNTI ---\n');

% Numero di punti di interpolazione
m = input('Numero di punti di interpolazione (es. 6-12): ');
if isempty(m) || m < 3
    m = 6;
    fprintf('Valore non valido. Uso m = 6.\n');
end

% Tipo di distribuzione dei punti
fprintf('\nTipo di distribuzione:\n');
fprintf('1. Equispaziati (linspace)\n');
fprintf('2. Chebyshev 2a specie (più accurato)\n');
tipo_punti = input('Scegli distribuzione (1-2): ');

if tipo_punti == 2
    % Punti di Chebyshev (migliore per evitare fenomeno di Runge)
    tpar = chebyshev2(a, b, m-1);
    fprintf('Uso distribuzione di Chebyshev.\n');
else
    % Punti equispaziati
    tpar = linspace(a, b, m);
    fprintf('Uso distribuzione equispaziata.\n');
end

%% ========================================================================
%  PARTE 3: VALUTAZIONE PUNTI E DERIVATE
%% ========================================================================

fprintf('\n--- VALUTAZIONE CURVA ---\n');

% Valuta la curva parametrica nei punti scelti
if exist(curva_nome, 'file')
    fun_handle = str2func(curva_nome);
    [xp, yp, xp1, yp1] = fun_handle(tpar);
else
    error('Funzione curva %s non trovata! ', curva_nome);
end

% Matrice punti e derivate
Q = [xp', yp'];      % Punti da interpolare
Q1 = [xp1', yp1'];   % Derivate (tangenti) nei punti

fprintf('Punti campionati:  %d\n', m);
fprintf('Intervallo parametrico: [%. 2f, %.2f]\n', a, b);

%% ========================================================================
%  PARTE 4: INTERPOLAZIONE DI HERMITE C^1
%% ========================================================================

fprintf('\n--- INTERPOLAZIONE HERMITE ---\n');

% Chiamata alla function di interpolazione cubica a tratti C^1
% con valori e derivate (Hermite)
ppP = curv2_ppbezierCC1_interp_der(Q, Q1, tpar);

fprintf('Interpolazione completata!\n');
fprintf('Grado curve:  %d (cubiche)\n', ppP.deg);
fprintf('Numero tratti: %d\n', length(ppP.ab)-1);

%% ========================================================================
%  PARTE 5: CALCOLO ERRORE DI INTERPOLAZIONE
%% ========================================================================

fprintf('\n--- CALCOLO ERRORE ---\n');

% Punti per valutazione errore
npt = 200;
t_eval = linspace(a, b, npt);

% Valuta curva interpolante
Pxy = ppbezier_val(ppP, t_eval);

% Valuta curva analitica originale
[x_orig, y_orig] = fun_handle(t_eval);
Qxy = [x_orig', y_orig'];

% Calcolo errori
MaxErrX = max(abs(Pxy(:,1) - Qxy(:,1)));
MaxErrY = max(abs(Pxy(:,2) - Qxy(:,2)));
errori_euclidei = vecnorm(Pxy - Qxy, 2, 2);
MaxErr = max(errori_euclidei);
MeanErr = mean(errori_euclidei);

fprintf('\n=== RISULTATI ERRORE DI INTERPOLAZIONE ===\n');
fprintf('Numero punti interpolazione: %d\n', m);
fprintf('Numero punti valutazione: %d\n', npt);
fprintf('Errore massimo in X: %e\n', MaxErrX);
fprintf('Errore massimo in Y: %e\n', MaxErrY);
fprintf('Errore Euclideo massimo: %e\n', MaxErr);
fprintf('Errore Euclideo medio: %e\n', MeanErr);
fprintf('==========================================\n');

%% ========================================================================
%  PARTE 6: VISUALIZZAZIONE GRAFICA
%% ========================================================================

fprintf('\n--- VISUALIZZAZIONE ---\n');

% FIGURA 1: Confronto curva originale vs interpolata
open_figure(1);
axis_plot(1.5, 0.15);
grid on;
hold on;
title('Interpolazione di Hermite C^1 con Curve di Bézier', 'FontSize', 14);

% Disegna curva analitica originale (rosso)
curv2_plot(curva_nome, a, b, 150, 'r-', 2);

% Disegna punti di interpolazione (neri)
point_plot(Q, 'ko', 2, 'k');

% Disegna curva interpolante (blu spesso)
curv2_ppbezier_plot(ppP, 80, 'b-', 3);

% Disegna vettori tangenti nei punti (verdi)
scale_tangent = 0.2;
for i = 1:m
    vect2_plot(Q(i,:), scale_tangent*Q1(i,:), 'g-', 1.5);
end

legend('Curva originale', 'Punti interpolazione', ...
    'Interpolante Hermite C^1', 'Tangenti', 'Location', 'best');

% FIGURA 2: Grafico dell'errore
open_figure(2);
hold on;
grid on;
plot(t_eval, errori_euclidei, 'b-', 'LineWidth', 2);
plot([a, b], [MaxErr, MaxErr], 'r--', 'LineWidth', 1.5);
plot([a, b], [MeanErr, MeanErr], 'g--', 'LineWidth', 1.5);
xlabel('Parametro t', 'FontSize', 12);
ylabel('Errore Euclideo', 'FontSize', 12);
title(sprintf('Errore di Interpolazione (m=%d punti)', m), 'FontSize', 14);
legend('Errore puntuale', sprintf('Max = %. 2e', MaxErr), ...
    sprintf('Media = %.2e', MeanErr), 'Location', 'best');

fprintf('Grafici generati!\n');

%% ========================================================================
%  FUNZIONI PARAMETRICHE AGGIUNTIVE (oltre a cp2_circle)
%% ========================================================================

function x = chebyshev2(a, b, n)
% Genera n+1 punti di Chebyshev di seconda specie in [a,b]
for i = 0:n
    x(i+1) = 0.5*(a+b) + 0.5*(a-b)*cos(i*pi/n);
end
end
