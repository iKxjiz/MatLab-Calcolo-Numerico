%% ============================================================
%% RACCOLTA COMPLETA DI ESERCIZI SULLE FUNZIONI IN MATLAB
%% Dal livello BASE al livello AVANZATO
%% ============================================================

clear all
clc

%% ============================================================
%% LIVELLO 1 - ESERCIZI BASE
%% ============================================================

disp('========================================');
disp('LIVELLO 1 - ESERCIZI BASE');
disp('========================================');

%% Esercizio 1.1 - Funzioni matematiche elementari
disp('--- Esercizio 1.1: Funzioni matematiche elementari ---');
x = -15.7;
valore_assoluto = abs(x);
radice = sqrt(abs(x));
arrotondamento_sup = ceil(x);
arrotondamento_inf = floor(x);
fprintf('Valore: %.2f\n', x);
fprintf('Valore assoluto: %.2f\n', valore_assoluto);
fprintf('Radice quadrata di |x|: %.2f\n', radice);
fprintf('Arrotondamento superiore: %d\n', arrotondamento_sup);
fprintf('Arrotondamento inferiore: %d\n', arrotondamento_inf);

%% Esercizio 1.2 - Funzioni trigonometriche
disp('--- Esercizio 1.2: Funzioni trigonometriche ---');
angolo_gradi = 45;
angolo_radianti = angolo_gradi * pi / 180;
seno = sin(angolo_radianti);
coseno = cos(angolo_radianti);
tangente = tan(angolo_radianti);
fprintf('Angolo: %d gradi (%.4f radianti)\n', angolo_gradi, angolo_radianti);
fprintf('sin(%d°) = %.4f\n', angolo_gradi, seno);
fprintf('cos(%d°) = %.4f\n', angolo_gradi, coseno);
fprintf('tan(%d°) = %.4f\n', angolo_gradi, tangente);

%% Esercizio 1.3 - Operazioni su vettori
disp('--- Esercizio 1.3: Operazioni su vettori ---');
voti = [28, 30, 25, 27, 29, 24, 26, 30, 27, 28];
massimo = max(voti);
minimo = min(voti);
media = mean(voti);
somma = sum(voti);
fprintf('Voti: ');
disp(voti);
fprintf('Massimo: %d\n', massimo);
fprintf('Minimo: %d\n', minimo);
fprintf('Media: %.2f\n', media);
fprintf('Somma totale: %d\n', somma);

%% Esercizio 1.4 - Trovare posizioni
disp('--- Esercizio 1.4: Trovare posizioni ---');
numeri = [5, 12, 3, 19, 7, 15, 2, 20];
[valore_max, posizione_max] = max(numeri);
[valore_min, posizione_min] = min(numeri);
fprintf('Vettore: ');
disp(numeri);
fprintf('Massimo: %d alla posizione %d\n', valore_max, posizione_max);
fprintf('Minimo: %d alla posizione %d\n', valore_min, posizione_min);

%% ============================================================
%% LIVELLO 2 - ESERCIZI INTERMEDI
%% ============================================================

disp(' ');
disp('========================================');
disp('LIVELLO 2 - ESERCIZI INTERMEDI');
disp('========================================');

%% Esercizio 2.1 - Analisi matrice
disp('--- Esercizio 2.1: Analisi completa di una matrice ---');
M = [12 5 8 15; 3 18 6 9; 14 4 11 7; 10 16 2 13];
disp('Matrice M:');
disp(M);
massimi_colonne = max(M);
minimi_colonne = min(M);
medie_colonne = mean(M);
massimo_assoluto = max(max(M));
minimo_assoluto = min(min(M));
media_totale = mean(mean(M));
fprintf('Massimi per colonna: ');
disp(massimi_colonne);
fprintf('Minimi per colonna: ');
disp(minimi_colonne);
fprintf('Medie per colonna: ');
disp(medie_colonne);
fprintf('Massimo assoluto: %d\n', massimo_assoluto);
fprintf('Minimo assoluto: %d\n', minimo_assoluto);
fprintf('Media totale: %.2f\n', media_totale);

%% Esercizio 2.2 - Resto e quoziente
disp('--- Esercizio 2.2: Divisione con resto ---');
dividendo = 47;
divisore = 6;
quoziente = floor(dividendo / divisore);
resto = rem(dividendo, divisore);
fprintf('%d diviso %d:\n', dividendo, divisore);
fprintf('Quoziente: %d\n', quoziente);
fprintf('Resto: %d\n', resto);
fprintf('Verifica: %d = %d * %d + %d\n', dividendo, divisore, quoziente, resto);

%% Esercizio 2.3 - Fattorizzazione LU
disp('--- Esercizio 2.3: Fattorizzazione LU ---');
A = [4 3 2; 2 5 1; 3 1 4];
disp('Matrice A:');
disp(A);
[L, U, P] = lu(A);
disp('Matrice L (triangolare inferiore):');
disp(L);
disp('Matrice U (triangolare superiore):');
disp(U);
disp('Matrice P (permutazione):');
disp(P);
disp('Verifica P*A = L*U:');
verifica = P*A - L*U;
disp(verifica);

%% Esercizio 2.4 - Funzioni esponenziali e logaritmiche
disp('--- Esercizio 2.4: Esponenziali e logaritmi ---');
valori = [1, 2, 5, 10, 100];
for i = 1:length(valori)
    val = valori(i);
    esp = exp(val);
    log_nat = log(val);
    log_10 = log10(val);
    fprintf('x=%d: e^x=%.2e, ln(x)=%.4f, log10(x)=%.4f\n', ...
        val, esp, log_nat, log_10);
end

%% Esercizio 2.5 - Determinante e traccia
disp('--- Esercizio 2.5: Determinante e traccia ---');
B = [5 2 1; 1 3 2; 2 1 4];
disp('Matrice B:');
disp(B);
determinante = det(B);
traccia = trace(B);
autovalori = eig(B);
fprintf('Determinante: %.4f\n', determinante);
fprintf('Traccia: %.4f\n', traccia);
fprintf('Autovalori: ');
disp(autovalori');

%% ============================================================
%% LIVELLO 3 - ESERCIZI AVANZATI
%% ============================================================

disp(' ');
disp('========================================');
disp('LIVELLO 3 - ESERCIZI AVANZATI');
disp('========================================');

%% Esercizio 3.1 - Statistiche complete
disp('--- Esercizio 3.1: Analisi statistica completa ---');
dati = [23, 45, 67, 34, 56, 78, 43, 65, 32, 54, 76, 38, 49, 61, 27];
media_dati = mean(dati);
mediana = median(dati);
deviazione_std = std(dati);
varianza = var(dati);
[dati_ordinati, indici] = sort(dati);
fprintf('Dati originali (%d elementi):\n', length(dati));
disp(dati);
fprintf('Media: %.2f\n', media_dati);
fprintf('Mediana: %.2f\n', mediana);
fprintf('Deviazione standard: %.2f\n', deviazione_std);
fprintf('Varianza: %.2f\n', varianza);
fprintf('Dati ordinati:\n');
disp(dati_ordinati);

%% Esercizio 3.2 - Prodotto matriciale complesso
disp('--- Esercizio 3.2: Operazioni matriciali avanzate ---');
C = [2 1 3; 1 2 1; 3 1 2];
D = [1 0 2; 2 1 0; 0 2 1];
disp('Matrice C:');
disp(C);
disp('Matrice D:');
disp(D);
prodotto_CD = C * D;
prodotto_DC = D * C;
disp('C * D:');
disp(prodotto_CD);
disp('D * C:');
disp(prodotto_DC);
disp('C .* D (elemento per elemento):');
disp(C .* D);
C_trasposta = C';
prodotto_CTC = C_trasposta * C;
prodotto_CCT = C * C_trasposta;
disp('C^T * C:');
disp(prodotto_CTC);
disp('C * C^T:');
disp(prodotto_CCT);

%% Esercizio 3.3 - Sistema lineare e verifica
disp('--- Esercizio 3.3: Risoluzione sistema lineare ---');
A_sistema = [3 2 -1; 2 -2 4; -1 0.5 -1];
b_sistema = [1; -2; 0];
disp('Sistema Ax = b');
disp('Matrice A:');
disp(A_sistema);
disp('Vettore b:');
disp(b_sistema);
x_soluzione = A_sistema \ b_sistema;
disp('Soluzione x:');
disp(x_soluzione);
verifica_sistema = A_sistema * x_soluzione;
disp('Verifica Ax:');
disp(verifica_sistema);
errore = norm(verifica_sistema - b_sistema);
fprintf('Errore (norma): %.10e\n', errore);

%% Esercizio 3.4 - Matrici random e analisi
disp('--- Esercizio 3.4: Matrici casuali e statistiche ---');
rand('seed', 42); % Per riproducibilità
matrice_random = rand(5, 4) * 100; % Valori tra 0 e 100
disp('Matrice casuale 5x4:');
disp(matrice_random);
max_per_riga = max(matrice_random, [], 2); % Max per riga
min_per_colonna = min(matrice_random);
media_per_colonna = mean(matrice_random);
somma_per_riga = sum(matrice_random, 2);
disp('Massimo per riga:');
disp(max_per_riga);
disp('Minimo per colonna:');
disp(min_per_colonna);
disp('Media per colonna:');
disp(media_per_colonna);
disp('Somma per riga:');
disp(somma_per_riga);

%% Esercizio 3.5 - Norme matriciali
disp('--- Esercizio 3.5: Norme di vettori e matrici ---');
v_norma = [3; 4; 0];
M_norma = [1 2; 3 4];
norma_2_vettore = norm(v_norma, 2); % Norma euclidea
norma_inf_vettore = norm(v_norma, inf); % Norma infinito
norma_1_vettore = norm(v_norma, 1); % Norma 1
fprintf('Vettore v:\n');
disp(v_norma');
fprintf('Norma 2 (euclidea): %.4f\n', norma_2_vettore);
fprintf('Norma infinito: %.4f\n', norma_inf_vettore);
fprintf('Norma 1: %.4f\n', norma_1_vettore);
fprintf('\nMatrice M:\n');
disp(M_norma);
norma_frob = norm(M_norma, 'fro'); % Norma di Frobenius
fprintf('Norma di Frobenius: %.4f\n', norma_frob);

%% ============================================================
%% LIVELLO 4 - ESERCIZI MOLTO DIFFICILI
%% ============================================================

disp(' ');
disp('========================================');
disp('LIVELLO 4 - ESERCIZI MOLTO DIFFICILI');
disp('========================================');

%% Esercizio 4.1 - Decomposizione QR e applicazioni
disp('--- Esercizio 4.1: Decomposizione QR ---');
A_qr = [12 -51 4; 6 167 -68; -4 24 -41];
disp('Matrice A:');
disp(A_qr);
[Q, R] = qr(A_qr);
disp('Matrice Q (ortogonale):');
disp(Q);
disp('Matrice R (triangolare superiore):');
disp(R);
verifica_qr = Q * R;
disp('Verifica Q*R:');
disp(verifica_qr);
errore_qr = norm(verifica_qr - A_qr);
fprintf('Errore decomposizione: %.10e\n', errore_qr);
% Verifica ortogonalità di Q
QTQ = Q' * Q;
disp('Q^T * Q (dovrebbe essere I):');
disp(QTQ);

%% Esercizio 4.2 - Sistema sovradeterminato (minimi quadrati)
disp('--- Esercizio 4.2: Sistema sovradeterminato (least squares) ---');
% Più equazioni che incognite: trovare la soluzione ai minimi quadrati
A_sovra = [1 1; 2 1; 3 1; 4 1; 5 1]; % 5 equazioni, 2 incognite
b_sovra = [2; 3; 4; 5; 6]; % Dati con rumore
disp('Sistema sovradeterminato Ax = b (5 eq, 2 incognite):');
disp('Matrice A:');
disp(A_sovra);
disp('Vettore b:');
disp(b_sovra);
x_ls = A_sovra \ b_sovra; % Soluzione ai minimi quadrati
disp('Soluzione ai minimi quadrati x:');
disp(x_ls);
residuo = A_sovra * x_ls - b_sovra;
disp('Residuo (Ax - b):');
disp(residuo);
errore_quadratico = norm(residuo)^2;
fprintf('Errore quadratico totale: %.4f\n', errore_quadratico);

%% Esercizio 4.3 - Autovalori e autovettori con analisi
disp('--- Esercizio 4.3: Autovalori, autovettori e diagonalizzazione ---');
A_eig = [4 1 0; 1 3 1; 0 1 2];
disp('Matrice A:');
disp(A_eig);
[V, D] = eig(A_eig);
disp('Autovettori (colonne di V):');
disp(V);
disp('Autovalori (diagonale di D):');
disp(D);
% Verifica: A*V = V*D
verifica_eig = A_eig * V - V * D;
disp('Verifica A*V - V*D (dovrebbe essere ~0):');
disp(verifica_eig);
% Diagonalizzazione: A = V*D*V^(-1)
A_ricostruita = V * D * inv(V);
disp('Matrice A ricostruita da V*D*V^(-1):');
disp(A_ricostruita);
errore_diago = norm(A_ricostruita - A_eig);
fprintf('Errore ricostruzione: %.10e\n', errore_diago);

%% Esercizio 4.4 - Numero di condizionamento
disp('--- Esercizio 4.4: Numero di condizionamento e stabilità ---');
% Matrice ben condizionata
A_buona = [10 7 8; 7 5 6; 8 6 10];
cond_buona = cond(A_buona);
disp('Matrice ben condizionata:');
disp(A_buona);
fprintf('Numero di condizionamento: %.2f\n', cond_buona);

% Matrice mal condizionata (quasi singolare)
epsilon = 1e-10;
A_cattiva = [1 1; 1 1+epsilon];
cond_cattiva = cond(A_cattiva);
disp('Matrice mal condizionata:');
disp(A_cattiva);
fprintf('Numero di condizionamento: %.2e\n', cond_cattiva);
fprintf('Interpretazione: cond < 100 = ben condizionata\n');
fprintf('                cond > 10^10 = mal condizionata\n');

%% Esercizio 4.5 - Interpolazione polinomiale con sistema lineare
disp('--- Esercizio 4.5: Interpolazione polinomiale ---');
% Trovare parabola y = ax^2 + bx + c che passa per 3 punti
x_punti = [1; 2; 3];
y_punti = [2; 3; 6];
% Sistema: [x1^2 x1 1; x2^2 x2 1; x3^2 x3 1] * [a; b; c] = [y1; y2; y3]
A_interp = [x_punti.^2, x_punti, ones(3,1)];
coefficienti = A_interp \ y_punti;
a = coefficienti(1);
b = coefficienti(2);
c = coefficienti(3);
fprintf('Punti: (%d,%d), (%d,%d), (%d,%d)\n', ...
    x_punti(1), y_punti(1), x_punti(2), y_punti(2), ...
    x_punti(3), y_punti(3));
fprintf('Parabola interpolante: y = %.4fx^2 + %.4fx + %.4f\n', a, b, c);
% Verifica
for i = 1:3
    y_calc = a*x_punti(i)^2 + b*x_punti(i) + c;
    fprintf('  x=%d: y_atteso=%.1f, y_calcolato=%.4f\n', ...
        x_punti(i), y_punti(i), y_calc);
end

%% Esercizio 4.6 - Potenze di matrici e convergenza
disp('--- Esercizio 4.6: Potenze di matrici ---');
P = [0.8 0.2; 0.1 0.9]; % Matrice di transizione (stocastica)
disp('Matrice P:');
disp(P);
disp('Potenze successive di P:');
for k = [1, 2, 5, 10, 20, 50]
    P_k = P^k;
    fprintf('\nP^%d:\n', k);
    disp(P_k);
end
fprintf('Nota: la matrice converge ad uno stato stazionario\n');

%% Esercizio 4.7 - Soluzione sistema con metodo iterativo (Jacobi semplificato)
disp('--- Esercizio 4.7: Metodo iterativo per sistemi lineari ---');
A_iter = [4 1 0; 1 4 1; 0 1 4];
b_iter = [1; 2; 3];
x_esatta = A_iter \ b_iter;
disp('Soluzione esatta:');
disp(x_esatta);
% Iterazione di Jacobi semplificata (poche iterazioni)
x_iter = zeros(3,1); % Punto di partenza
D = diag(diag(A_iter)); % Parte diagonale
R = A_iter - D; % Resto
fprintf('\nIterazioni metodo Jacobi:\n');
for iter = 1:10
    x_iter = D \ (b_iter - R * x_iter);
    errore_iter = norm(x_iter - x_esatta);
    fprintf('Iter %2d: x = [%.4f, %.4f, %.4f], errore = %.6e\n', ...
        iter, x_iter(1), x_iter(2), x_iter(3), errore_iter);
end

%% Esercizio 4.8 - Analisi di sensitività
disp('--- Esercizio 4.8: Analisi di sensitività ---');
A_sens = [2 1; 1 2];
b_sens = [3; 3];
x_orig = A_sens \ b_sens;
fprintf('Sistema originale:\n');
fprintf('Soluzione: x1=%.4f, x2=%.4f\n', x_orig(1), x_orig(2));

% Perturbazione piccola su b
delta_b = [0.01; 0];
b_pert = b_sens + delta_b;
x_pert = A_sens \ b_pert;
fprintf('\nCon perturbazione su b di %.2f:\n', delta_b(1));
fprintf('Nuova soluzione: x1=%.4f, x2=%.4f\n', x_pert(1), x_pert(2));
delta_x = x_pert - x_orig;
fprintf('Variazione soluzione: Δx1=%.4f, Δx2=%.4f\n', delta_x(1), delta_x(2));
amplificazione = norm(delta_x) / norm(delta_b);
fprintf('Amplificazione errore: %.4f\n', amplificazione);

%% Esercizio 4.9 - Prodotto di Kronecker e operazioni avanzate
disp('--- Esercizio 4.9: Prodotto di Kronecker ---');
A_kron = [1 2; 3 4];
B_kron = [0 5; 6 7];
disp('Matrice A:');
disp(A_kron);
disp('Matrice B:');
disp(B_kron);
C_kron = kron(A_kron, B_kron);
disp('Prodotto di Kronecker A ⊗ B:');
disp(C_kron);
fprintf('Dimensione: %dx%d\n', size(C_kron, 1), size(C_kron, 2));

%% Esercizio 4.10 - SVD (Singular Value Decomposition)
disp('--- Esercizio 4.10: Decomposizione ai valori singolari (SVD) ---');
A_svd = [1 2 3; 4 5 6; 7 8 9; 10 11 12];
disp('Matrice A (4x3):');
disp(A_svd);
[U, S, V] = svd(A_svd);
disp('Matrice U:');
disp(U);
disp('Matrice S (valori singolari):');
disp(S);
disp('Matrice V:');
disp(V);
% Verifica: A = U*S*V'
A_ricostruita_svd = U * S * V';
disp('Matrice A ricostruita da U*S*V'':');
disp(A_ricostruita_svd);
errore_svd = norm(A_ricostruita_svd - A_svd);
fprintf('Errore ricostruzione: %.10e\n', errore_svd);
% Rango della matrice
rango = rank(A_svd);
fprintf('Rango della matrice: %d\n', rango);

%% ============================================================
%% SFIDA FINALE - Problema applicativo complesso
%% ============================================================

disp(' ');
disp('========================================');
disp('SFIDA FINALE - Problema Applicativo');
disp('========================================');

disp('--- Sistema di equazioni differenziali discretizzato ---');
% Simulazione semplificata di un sistema dinamico
% dx/dt = Ax, con discretizzazione di Eulero
A_dinamico = [-0.5 0.2; 0.1 -0.3];
x0 = [10; 5]; % Condizioni iniziali
dt = 0.1; % Passo temporale
n_passi = 50;

disp('Matrice del sistema:');
disp(A_dinamico);
fprintf('Condizioni iniziali: x(0) = [%.1f, %.1f]''\n', x0(1), x0(2));
fprintf('Passo temporale: %.2f\n', dt);

% Calcolo autovalori per stabilità
lambda = eig(A_dinamico);
fprintf('Autovalori: %.4f, %.4f\n', lambda(1), lambda(2));
if all(real(lambda) < 0)
    fprintf('Sistema STABILE (tutti autovalori con parte reale negativa)\n');
else
    fprintf('Sistema INSTABILE\n');
end

% Integrazione numerica
x = x0;
fprintf('\nEvoluzione temporale (primi 10 passi):\n');
for k = 1:n_passi
    x = x + dt * (A_dinamico * x); % Metodo di Eulero
    if k <= 10
        fprintf('t=%.2f: x=[%.4f, %.4f], norma=%.4f\n', ...
            k*dt, x(1), x(2), norm(x));
    end
end
fprintf('...\n');
fprintf('t=%.2f: x=[%.4f, %.4f], norma=%.4f\n', ...
    n_passi*dt, x(1), x(2), norm(x));

%% ============================================================
%% CONCLUSIONE
%% ============================================================

disp(' ');
disp('========================================');
disp('TUTTI GLI ESERCIZI COMPLETATI!');
disp('========================================');
fprintf('Hai completato %d livelli di esercizi\n', 5);
fprintf('dalle funzioni base alle applicazioni avanzate!\n');
disp(' ');
disp('Suggerimenti per proseguire:');
disp('1. Rileggi gli output e verifica di aver capito ogni passaggio');
disp('2. Modifica i valori delle matrici e vettori per sperimentare');
disp('3. Prova a commentare/decommentare sezioni per focus specifici');
disp('4. Cerca nella documentazione MATLAB (help nomefunzione)');
disp('========================================');