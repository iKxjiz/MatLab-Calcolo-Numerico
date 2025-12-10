%sgittata.m
clear
clc
g=9.81;
v0=200;
% ang=linspace(0,pi/2,32);
ang=0:0.05:pi/2;
n=length(ang);

gitt=v0^2./g*sin(2*ang);

fprintf('    n      angolo    gittata\n');
fprintf('%5d %10.3f %15.5e\n',[1:n; ang; gitt]);

figure; 
plot(ang, gitt); 