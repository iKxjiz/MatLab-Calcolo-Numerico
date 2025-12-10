%Viene generata una tabulazione della funzione sin(x)
%in corrispondenza di punti equispaziati nell'intervallo [0,pi]
%input: numero di valori da generare
%output: tabulazione (stampa)
clear
clc
%n=input('numero di valori da tabulare: ');
n = 13;
t=linspace(0,2*pi,n);
r = 5;
cx = 0;
cy = 0;

[x,y] = circle(r, cx, cy, n);
% Disegno delle funzioni :

figure;
axis equal
hold on
plot(x, y)

% Raggio delle singole circonferenze
rt = (2*pi)/n;

function [x, y] = circle(r, cx, cy, n)
t=linspace(0,2*pi,n);
x = cx + r*cos(t);
y = cy + r*sin(t);
end