clear all;
clc

x = 0:0.01:2*pi;
y = sin(x);
k = cos(x);
plot(x, y, 'r-', 'LineWidth', 2);
hold on
plot(x, k, 'b-', 'LineWidth', 2);
legend('sin(x)', 'cos(x)')
xlabel('x')
ylabel('y')
title('Funzioni trigonometriche')


