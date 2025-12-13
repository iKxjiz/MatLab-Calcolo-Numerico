%sgittata di un oggetto lanciato ad un angolo theta
clear all
clc

% Dati :
ang = 0:0.05:(pi/2); % Angoli tabulati da 0 a pi/2 con incremento di 0.05
v = 100; % Velocità
g = 9.81; % Gravità

% Calcolo della gittata R := (v^2 / g)*sin(2*θ)
gitt = ((v.^2)./g).*sin(2.*ang);
% Quando si lavora con vettori e vuoi applicare operazioni a ogni
% elemento, si usano SEMPRE gli operatori con il punto (.^, ./, .*)

% Stampa tabella
fprintf('\n  Angolo (rad)  |  Gittata (m)\n');
fprintf('--------------------------------\n');
for i = 1:length(ang)
    fprintf('    %.4f      |    %.2f\n', ang(i), gitt(i));
end

% Trova massimo
[valore, indice] = max(gitt);
angolo_max = ang(indice);

% Verifica
fprintf('\n--- MASSIMO ---\n');
fprintf('Gittata massima: %.2f m\n', valore);
fprintf('Angolo per gittata massima: %.4f radianti\n', angolo_max);
fprintf('π/4 = %.4f radianti\n', pi/4);
fprintf('Differenza: %.6f radianti\n', abs(angolo_max - pi/4));

figure;
plot(ang, gitt);