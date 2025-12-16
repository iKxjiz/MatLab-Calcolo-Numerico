% A4 + B1

clear all
clc

% Dati iniziali : centro e raggio
cx = 0;
cy = 0;
r = 5;

% n : numero di punti
n = 13;

% Lato del poligono : lato = 2 * r * sin(pi/n);
% quindi raggio piccolo r_p delle circonferenze tangenti :
r_piccolo = r * sin(pi/12);

% Genera punti sulla circonferenza principale (quella grande)
[x, y] = fcircle(n, cx, cy, r);

% Disegno :
open_figure(1);
title("Circonferenza");
plot(x, y, 'r-', 'LineWidth', 2);
hold on
axis equal
grid on
xlabel('X');
ylabel('Y');
title("Circonferenza con 12 circonferenze tangenti");

% Disegno delle 12 circonferenze :

for i = 1:12
    angle = (i-1)*2*pi /12;
    cx = r * cos(angle);
    cy = r * sin(angle);
    circle2_plot([cx, cy], r_piccolo, 50, 'b-', 2);

    % Per riempire le circonferenze :
    t = linspace(0, 2*pi, 50);
    j = r_piccolo * cos(t) + cx;
    k = r_piccolo * sin(t) + cy;
    % Nota che j e k (e anche t) sono tutte righe 1*n, point_fill vuole colonne
    % quindi si fa la trasposizione con il simbolo '
    point_fill([j' k'], 'blue');
end
axis_plot(5);
hold off