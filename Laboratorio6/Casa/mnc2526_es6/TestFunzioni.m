%Si considerino le seguenti funzioni test di cui si vuole calcolare
%l’integrale definito sul loro dominio di definizione:

%f1 = e√x sin(x) + 2x − 4 x ∈ [0, 12] R 12 0 f1(x)dx = 68.3532891202483
%f2 = 32 1+1024x2 x ∈ [0, 4] R 4 0 f2(x)dx = 1.56298398573480
%f3 = e−x x x ∈ [1, 2] R 2 1 f3(x)dx = 0.170483423687459
%f4 = 4 1+x2 x ∈ [0, 1] R 1 0 f4(x)dx = 3.14159265358979
%f5 = p(1 − x2)ex x ∈ [0, 1] R 1 0 f5(x)dx = 1.24395050141647

clear all;
clc;

%% Integrazione della prima funzione con il metodo dei trapezi composta
val1_tr = trapezi_comp('effe1',0,12,200,0);
val1_sm = simpson_comp('effe1',0,12,25,0);
fprintf('Valore approssimato dell integrale di effe1 in [0,12] : \n(Trapezi) ==> %.6f\n(Simpson) ==> %.6f\n', val1_tr, val1_sm);
val_preciso1 = integral(@effe1, 0, 12);
fprintf('Valore preciso : %.10f\n\n', val_preciso1);


% nota : aumentando il numero di sottointervalli n, l'accuratezza
% dell'approssimazione migliora. Questo e' dovuto al fatto che
% l'errore di approssimazione dipende da h^(2) per il metodo dei Trapezi
% e da h^(4) per il metodo di Simpson, dove h e' la dimensione del
% sottointervallo. Quindi, riducendo h (aumentando n), l'errore diminuisce
% in modo significativo.

%PLOT ---- NOTA ==> trapezi_comp apre figure(1) e simpson_comp apre figure(2)
%trapezi_comp('effe1',0,12,50,1);
%trapezi_comp('d2_effe1', 0, 12, 50, 1);
%trapezi_comp('d4_effe1', 0, 12, 100, 1);

%simpson_comp('effe1',0,12,25,1);
%simpson_comp('d2_effe1',0,12,25,1); % Stampa NaN ==> Può essere cancellazione numerica ?
%simpson_comp('d4_effe1',0,12,25,1); % Stampa NaN

% Errori :
%err_trapezi_comp('effe1', 0, 12, 50);
%fprintf('\n');
%err2_trapezi_comp('effe1', 0, 12);
%fprintf('\n');
%err_simpson_comp('effe1', 0, 12, 50);
%fprintf('\n');

%% Integrazione della seconda funzione con il metodo dei trapezi composta
val2_tr = trapezi_comp('effe2',0,4,25,0);
val2_sm = simpson_comp('effe2',0,4,12,0);
fprintf('Valore approssimato dell integrale di effe2 in [0,4] : \n(Trapezi) ==> %.6f\n(Simpson) ==> %.6f\n', val2_tr, val2_sm);
val_preciso2 = integral(@effe2, 0, 4);
fprintf('Valore preciso : %.10f\n\n', val_preciso2);


%PLOT :
%trapezi_comp('effe2',0,4,25,1);
%simpson_comp('effe2',0,4,12,1);

% Errori :
%err_trapezi_comp('effe2', 0, 4, 50);
%fprintf('\n');
%err_simpson_comp('effe2', 0, 4, 50);
%fprintf('\n');

%% Integrazione della terza funzione con il metodo dei trapezi composta
val3_tr = trapezi_comp('effe3',1,2,40,0);
val3_sm = simpson_comp('effe3',1,2,20,0);
fprintf('Valore approssimato dell integrale di effe3 in [1,2] : \n(Trapezi) ==> %.6f\n(Simpson) ==> %.6f\n', val3_tr, val3_sm);
val_preciso3 = integral(@effe3, 1, 2);
fprintf('Valore preciso : %.10f\n\n', val_preciso3);

%PLOT :
%trapezi_comp('effe3',1,2,40,1);
%simpson_comp('effe3',1,2,20,1);

% Errori :
%err_trapezi_comp('effe3', 1, 2, 40);
%fprintf('\n');
%err_simpson_comp('effe3', 1, 2, 40);
%fprintf('\n');


%% Integrazione della quarta funzione con il metodo dei trapezi composta
val4_tr = trapezi_comp('effe4',0,1,30,0);
val4_sm = simpson_comp('effe4',0,1,15,0);
fprintf('Valore approssimato dell''integrale di effe4 in [0,1] : (Trapezi) ==> %.6f\n(Simpson) ==> %.6f\n', val4_tr, val4_sm);
val_preciso4 = integral(@effe4, 0, 1);
fprintf('Valore preciso : %.10f\n\n', val_preciso4);

%PLOT :
%trapezi_comp('effe4',0,1,30,1);
%simpson_comp('effe4',0,1,15,1);

% Errori :
%err_trapezi_comp('effe4', 0, 1, 30);
%fprintf('\n');
%err_simpson_comp('effe4', 0, 1, 30);
%fprintf('\n');


%% Integrazione della quinta funzione con il metodo dei trapezi composta
val5_tr = trapezi_comp('effe5',0,1,50,0);
val5_sm = simpson_comp('effe5',0,1,25,0);
fprintf('Valore approssimato dell integrale di effe5 in [0,1] : \n(Trapezi) ==> %.6f\n(Simpson) ==> %.6f\n', val5_tr, val5_sm);
val_preciso5 = integral(@effe5, 0, 1);
fprintf('Valore preciso : %.10f\n\n', val_preciso5);

%PLOT :
%trapezi_comp('effe5',0,1,50,1);
%simpson_comp('effe5',0,1,25,1);

% Errori :
%err_trapezi_comp('effe5', 0, 1, 50);
%fprintf('\n');
%err_simpson_comp('effe5', 0, 1, 50);
%fprintf('\n');
