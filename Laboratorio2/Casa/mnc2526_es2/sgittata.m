%sgittata.m
clear
clc
g=9.81;
v0=200;
v1=150;
v2=100;
% ang=linspace(0,pi/2,32);
ang=0:0.05:pi/2;
n=length(ang);

gitt0=v0^2./g*sin(2*ang);
gitt1=v1^2./g*sin(2*ang);
gitt2=v2^2./g*sin(2*ang);

fprintf('    n      angolo    gittata\n');
fprintf('%5d %10.3f %15.5e\n',[1:n; ang; gitt0]);

disp("==============================================");

fprintf('    n      angolo    gittata\n');
fprintf('%5d %10.3f %15.5e\n',[1:n; ang; gitt1]);

disp("==============================================");

fprintf('    n      angolo    gittata\n');
fprintf('%5d %10.3f %15.5e\n',[1:n; ang; gitt2]);

% Disegno del grafico :
figure(1);
plot(ang, gitt0, "b-", "LineWidth", 3);
hold on;
grid on;
plot(ang, gitt1, "r-", "LineWidth", 3);
plot(ang, gitt2, "g-", "LineWidth", 3);
xlabel('Angolo Radianti');
ylabel('Gittata');
title('Gittata in funzione del angolo');
legend('v_0 = 200', 'v_1 = 150', 'v_2 = 200');
hold off;

% Verifico il punto massimo sia pi/4
[max_git0, id0] = max(gitt0);
[max_git1, id1] = max(gitt1);
[max_git2, id2] = max(gitt2);

ang_max0 = ang(id0);
fprintf('Angolo di massima gittata v_0 = 200: %.4f rad (%.2f gradi)\n', ang_max0, ang_max0*180/pi);
fprintf('π/4 = %.4f rad (45 gradi)\n', pi/4);

ang_max1 = ang(id1);
fprintf('Angolo di massima gittata v_1 = 150: %.4f rad (%.2f gradi)\n', ang_max1, ang_max1*180/pi);
fprintf('π/4 = %.4f rad (45 gradi)\n', pi/4);

ang_max2 = ang(id2);
fprintf('Angolo di massima gittata v_2 = 100: %.4f rad (%.2f gradi)\n', ang_max2, ang_max2*180/pi);
fprintf('π/4 = %.4f rad (45 gradi)\n', pi/4);


