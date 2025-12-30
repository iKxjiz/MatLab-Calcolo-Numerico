clear all;
clc

% Dati :
a = 0:0.05:(pi/2); % Angoli tabulati da 0 a pi/2 con incremento di 0.05
v = 100; % Velocità
g = 9.81; % Gravità

% Calcolo della gittata R
r = ((v.^2)./g).*sin(2.*a);
% Quando si lavora con vettori e vuoi applicare operazioni a ogni
% elemento, si usano SEMPRE gli operatori con il punto (.^, ./, .*)

% Trova massimo
[valore, indice] = max(r);
angolo_max = a(indice);

% Verifica
fprintf('\n--- MASSIMO (v = 100) ---\n');
fprintf('Gittata massima: %.2f m\n', valore);
fprintf('Angolo per gittata massima: %.4f radianti\n', angolo_max);
fprintf('π/4 = %.4f radianti\n', pi/4);
fprintf('Differenza: %.6f radianti\n', abs(angolo_max - pi/4));

fprintf('\n---------------\n');

% Velocità metà
v = 50; % Velocità
r = ((v.^2)./g).*sin(2.*a);
% Trova massimo
[valore, indice] = max(r);
angolo_max = a(indice);
% Verifica
fprintf('\n--- MASSIMO (v = 50) ---\n');
fprintf('Gittata massima: %.2f m\n', valore);
fprintf('Angolo per gittata massima: %.4f radianti\n', angolo_max);
fprintf('π/4 = %.4f radianti\n', pi/4);
fprintf('Differenza: %.6f radianti\n', abs(angolo_max - pi/4));

fprintf('\n---------------\n');

% Velocità doppia
v = 200; % Velocità
r = ((v.^2)./g).*sin(2.*a);
% Trova massimo
[valore, indice] = max(r);
angolo_max = a(indice);
% Verifica
fprintf('\n--- MASSIMO (v = 200) ---\n');
fprintf('Gittata massima: %.2f m\n', valore);
fprintf('Angolo per gittata massima: %.4f radianti\n', angolo_max);
fprintf('π/4 = %.4f radianti\n', pi/4);
fprintf('Differenza: %.6f radianti\n', abs(angolo_max - pi/4));