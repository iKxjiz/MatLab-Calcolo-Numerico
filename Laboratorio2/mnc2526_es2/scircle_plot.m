%Viene generata una tabulazione della funzione sin(x)
%in corrispondenza di punti equispaziati nell'intervallo [0,pi]
%input: numero di valori da generare
%output: tabulazione (stampa)
clear
clc
n = input('numero di valori da tabulare: ');
t = linspace(0,2*pi,n);
r = 5;
cx = 0;
cy = 0;

[x,y] = circle(r, cx, cy, t);

% Disegno delle funzioni :

figure;
axis equal
hold on
plot(x, y)

function [x, y] = circle(r, cx, cy, t)
x = cx + r*cos(t);
y = cy + r*sin(t);
end