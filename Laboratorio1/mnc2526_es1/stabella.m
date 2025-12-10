%Viene generata una tabulazione delle funzioni sin(x), cos(x) e della
%somma dei loro quadrati in corrispondenza di punti equispaziati nell'
%intervallo [0,2*pi]
%input: numero di valori da generare
%output: stampa della tabulazione e stampe ulteriori
clear all
clc


%stampa intestazione e valori
n = input("dai un valore intero per n :");
x = linspace(0, 2*pi, n);
y = sin(x);
z = cos(x);
w = y.^2+z.^2; % Devo usare un operatore scalare .^ perchè y è un vettore
fprintf('  n.    x          sin(x)     cos(x)     sin(x)^2+cos(x)^2\n');
fprintf('%3d> %10.5f %10.5f %10.5f %10.5f\n',[1:n;x;y;z;w]);

[ymin, yimin] = min(y);
[ymax, yimax] = max(y);

[zmin, zimin] = min(z);
[zmax, zimax] = max(z);

[wmin, wimin] = min(w);
[wmax, wimax] = max(w);

%stampa di: indice del valore minimo, valore minimo,
%indice del valore massimo e valore massimo
%dei valori tabulati per sin(x), cos(x) e la somma dei loro quadrati
fprintf('yimin, ymin : %f %f \n', yimin, ymin);
fprintf('yimax, ymax : %f %f \n', yimax, ymax);

fprintf('zimin, zmin : %f %f \n', zimin, zmin);
fprintf('zimax, zmax : %f %f \n', zimax, zmax);

fprintf('wimin, wmin : %f %f \n', wimin, wmin);
fprintf('wimax, wmax : %f %f \n', wimax, wmax);
fprintf('\n');


