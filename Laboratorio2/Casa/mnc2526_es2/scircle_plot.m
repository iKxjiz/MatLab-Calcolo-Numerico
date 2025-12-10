clear all
clc

% Dati iniziali : centro e raggio
cx = 0;
cy = 0;
r = 5;

% n : numero di punti
n = 100;

% Genera punti sulla circonferenza
[x, y] = fcircle(n, cx, cy, r);

% Disegno :

figure(1);
title("Circonferenza");
plot(x, y, 'r-', 'LineWidth', 6);
hold on
axis equal
grid on
xlabel('X');
ylabel('Y');
