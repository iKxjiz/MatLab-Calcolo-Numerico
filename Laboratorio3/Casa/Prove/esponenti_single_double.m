%**************************************************
%script esponenti_single_double.m
%Calcola l'unità di arrotondamento per BASIC single e BASIC double
%**************************************************
clear
clc

%cambiare i flag per selezionare quale precisione testare
flag_single = 1;
flag_double = 1;

if (flag_single == 1)
    fprintf("========== BASIC SINGLE ==========\n");
    %****************************************************
    %BASIC single F(2,24,-126,127)
    %Unità di arrotondamento: U = 2^(-24)
    %****************************************************

    % Definizione esplicita
    u_explicit = single(2^(-24));
    fprintf('Definizione esplicita: u = 2^(-24)\n');
    fprintf('Valore decimale: %13.8e\n\n', u_explicit);

    % Calcolo via caratterizzazione operativa
    % Trova il più piccolo u tale che fl(1 + u) > 1
    u = single(1);
    t = 0;
    while (1 + u > 1)
        u = u / 2;
        t = t + 1;
    end

    % L'ultimo valore che ha soddisfatto la condizione
    u = u * 2;  % torna indietro di un passo
    t = t - 1;

    fprintf('Caratterizzazione operativa:\n');
    fprintf('Più piccolo u tale che fl(1 + u) > 1\n');
    fprintf('Valore decimale: %13.8e\n', u);
    fprintf('Esponente in base 2: -%d\n', t);

    % Verifica
    fprintf('\nVerifica:\n');
    fprintf('1 + u   = %.10e (diverso da 1)\n', single(1) + u);
    fprintf('1 + u/2 = %.10e (uguale a 1)\n', single(1) + u/2);
    fprintf('==========================================\n\n');
end

if (flag_double == 1)
    fprintf("========== BASIC DOUBLE ==========\n");
    %******************************************************
    %BASIC double F(2,53,-1022,1023)
    %Unità di arrotondamento: U = 2^(-53)
    %******************************************************

    % Definizione esplicita
    u_explicit = 2^(-53);
    fprintf('Definizione esplicita: u = 2^(-53)\n');
    fprintf('Valore decimale: %20.15e\n\n', u_explicit);

    % Calcolo via caratterizzazione operativa
    u = 1;
    t = 0;
    while (1 + u > 1)
        u = u / 2;
        t = t + 1;
    end

    % L'ultimo valore che ha soddisfatto la condizione
    u = u * 2;
    t = t - 1;

    fprintf('Caratterizzazione operativa:\n');
    fprintf('Più piccolo u tale che fl(1 + u) > 1\n');
    fprintf('Valore decimale: %20.15e\n', u);
    fprintf('Esponente in base 2: -%d\n', t);

    % Verifica
    fprintf('\nVerifica:\n');
    fprintf('1 + u   = %.17e (diverso da 1)\n', 1 + u);
    fprintf('1 + u/2 = %.17e (uguale a 1)\n', 1 + u/2);
    fprintf('==========================================\n');
end

u = single(2^(-23));
% Confronto con eps di MATLAB
fprintf('\nConfronto con eps(1) di MATLAB:\n');
fprintf('u calcolato:  %13.8e\n', u);
fprintf('eps(1):       %13.8e\n', eps(single(1)));
fprintf('Relazione: eps(1) = 2*u\n');

% Verifica che l'errore relativo sia <= u
x_test = single(pi);
x_fl = single(x_test);
err_rel = abs(x_test - x_fl) / abs(x_test);
fprintf('\nTest errore relativo su pi:\n');
fprintf('Errore relativo: %13.8e\n', err_rel);
fprintf('Limite teorico u: %13.8e\n', u);
fprintf('Errore <= u? %s\n', string(err_rel <= u));

% Spacing in diversi intervalli
fprintf('\nSpacing in diversi intervalli:\n');
for exp = 0:5
    val = single(2^exp);
    spacing = eps(val);
    fprintf('[2^%d, 2^%d): spacing = %13.8e\n', exp, exp+1, spacing);
end

