%***************************************************
% Script per confrontare BASIC Single vs Double
% nell'espressione y = ((1+x)-1)/x
%***************************************************
clear all
clc

fprintf('=== CONFRONTO BASIC SINGLE vs BASIC DOUBLE ===\n\n');

% Vettore di valori di x da testare
x_values = [1, 0.1, 0.01, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9, ...
    1e-10, 1e-15, 1e-20, 1e-25, 1e-30];

fprintf('%-12s | %-15s | %-15s | %-15s | %-15s\n', ...
    'x', 'y (single)', 'y (double)', 'E_Alg (single)', 'E_Alg (double)');
fprintf('%s\n', repmat('-', 1, 85));

for i = 1:length(x_values)
    x = x_values(i);

    % BASIC SINGLE
    x_s = single(x);
    y_s = ((single(1) + x_s) - single(1)) / x_s;
    e_alg_s = abs((double(y_s) - 1) / 1);

    % BASIC DOUBLE
    x_d = x;
    y_d = ((1 + x_d) - 1) / x_d;
    e_alg_d = abs((y_d - 1) / 1);

    % Stampa risultati
    fprintf('%-12.2e | %-15.8e | %-15.8e | %-15.8e | %-15.8e\n', ...
        x, y_s, y_d, e_alg_s, e_alg_d);
end

fprintf('\n=== ANALISI CRITICA ===\n');
fprintf('U_single = %.8e (≈ 2^-24)\n', eps('single'));
fprintf('U_double = %.8e (≈ 2^-53)\n', eps('double'));

fprintf('\n--- Valori Finiti Esatti in Base 2 ---\n');
% Test con valori che hanno rappresentazione esatta
x_exact = [0.5, 0.25, 0.125, 0.0625, 2^-10, 2^-15, 2^-20, 2^-25];

fprintf('\n%-12s | %-15s | %-15s | %-15s | %-15s\n', ...
    'x (potenza 2)', 'y (single)', 'y (double)', 'E_Alg (single)', 'E_Alg (double)');
fprintf('%s\n', repmat('-', 1, 85));

for i = 1:length(x_exact)
    x = x_exact(i);

    % BASIC SINGLE
    x_s = single(x);
    y_s = ((single(1) + x_s) - single(1)) / x_s;
    e_alg_s = abs((double(y_s) - 1) / 1);

    % BASIC DOUBLE
    x_d = x;
    y_d = ((1 + x_d) - 1) / x_d;
    e_alg_d = abs((y_d - 1) / 1);

    fprintf('%-12.2e | %-15.8e | %-15.8e | %-15.8e | %-15.8e\n', ...
        x, y_s, y_d, e_alg_s, e_alg_d);
end

fprintf('\n=== ZONE CRITICHE ===\n');
fprintf('1. x > 1        : Risultato CORRETTO (no problemi)\n');
fprintf('2. U < x < 1    : Risultato CORRETTO (x preservato in 1+x)\n');
fprintf('3. x ≈ U        : ZONA CRITICA (inizia cancellazione)\n');
fprintf('4. x < U        : Risultato ERRATO (y = 0, cancellazione totale)\n');

% Grafico comparativo
figure('Position', [100, 100, 1200, 500]);

% Subplot 1: Errore algoritmico in scala log
subplot(1,2,1);
x_plot = logspace(-30, 0, 100);
e_alg_single = zeros(size(x_plot));
e_alg_double = zeros(size(x_plot));

for i = 1:length(x_plot)
    x = x_plot(i);

    % Single
    x_s = single(x);
    y_s = ((single(1) + x_s) - single(1)) / x_s;
    e_alg_single(i) = abs((double(y_s) - 1) / 1);

    % Double
    y_d = ((1 + x) - 1) / x;
    e_alg_double(i) = abs((y_d - 1) / 1);
end

loglog(x_plot, e_alg_single, 'r-', 'LineWidth', 2, 'DisplayName', 'Single');
hold on;
loglog(x_plot, e_alg_double, 'b-', 'LineWidth', 2, 'DisplayName', 'Double');
xline(eps('single'), 'r--', 'U_{single}', 'LineWidth', 1.5, 'LabelOrientation', 'horizontal');
xline(eps('double'), 'b--', 'U_{double}', 'LineWidth', 1.5, 'LabelOrientation', 'horizontal');
grid on;
xlabel('x');
ylabel('E_{Alg}');
title('Errore Algoritmico: Single vs Double');
legend('Location', 'northwest');

% Subplot 2: Valore di y
subplot(1,2,2);
y_single = zeros(size(x_plot));
y_double = zeros(size(x_plot));

for i = 1:length(x_plot)
    x = x_plot(i);

    % Single
    x_s = single(x);
    y_single(i) = ((single(1) + x_s) - single(1)) / x_s;

    % Double
    y_double(i) = ((1 + x) - 1) / x;
end

semilogx(x_plot, y_single, 'r-', 'LineWidth', 2, 'DisplayName', 'Single');
hold on;
semilogx(x_plot, y_double, 'b-', 'LineWidth', 2, 'DisplayName', 'Double');
yline(1, 'k--', 'Valore Esatto', 'LineWidth', 1.5);
xline(eps('single'), 'r--', 'LineWidth', 1.5);
xline(eps('double'), 'b--', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('y = ((1+x)-1)/x');
title('Valore Calcolato: Single vs Double');
legend('Location', 'southwest');
ylim([-0.5, 1.5]);