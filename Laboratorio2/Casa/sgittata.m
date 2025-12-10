% sgittata_plot.m
clear
clc
g = 9.81;
ang = 0:0.05:pi/2;
% Tre velocità diverse
v0_1 = 100;
v0_2 = 150;
v0_3 = 200;
gitt1 = v0_1^2./g * sin(2*ang);
gitt2 = v0_2^2./g * sin(2*ang);
gitt3 = v0_3^2./g * sin(2*ang);
% Grafico
figure(1)
h1 = plot(ang, gitt1, 'b-', 'LineWidth', 2); % Handle
hold on
h2 = plot(ang, gitt2, 'g-', 'LineWidth', 2);
h3 = plot(ang, gitt3, 'r-', 'LineWidth', 2);
grid on
xlabel('Angolo (rad)')
ylabel('Gittata (m)')
title('Gittata in funzione dell''angolo')
legend([h1, h2, h3], 'v_0 = 100 m/s', 'v_0 = 150 m/s', 'v_0 = 200 m/s')
% Linea verticale a π/4 per verificare il massimo
line([pi/4 pi/4], [0 max(gitt3)], 'Color', 'k', 'LineStyle', '--')
text(pi/4, max(gitt3)/2, '\theta = \pi/4')
hold off
% Verifica che il massimo sia a π/4
[max_gitt, idx_max] = max(gitt3);
ang_max = ang(idx_max);
fprintf('Angolo di massima gittata: %.4f rad (%.2f gradi)\n', ang_max, ang_max*180/pi);
fprintf('π/4 = %.4f rad (45 gradi)\n', pi/4);