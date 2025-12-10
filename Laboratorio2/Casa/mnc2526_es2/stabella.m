%Viene generata una tabulazione della funzione sin(x)
%in corrispondenza di punti equispaziati nell'intervallo [0,pi]
%input: numero di valori da generare
%output: tabulazione (stampa)
clear
clc

n=50;
x=linspace(0,2*pi,n);
y=sin(x);
z=cos(x);
w=y.^2+z.^2;

fprintf('  n.    x          sin(x)     cos(x)     sin(x)^2+cos(x)^2\n');
fprintf('%3d> %10.5f %10.5f %10.5f %10.5f\n',[1:n;x;y;z;w]);

[miny,iminy]=min(y);
[maxy,imaxy]=max(y);

[minz,iminz]=min(z);
[maxz,imaxz]=max(z);

[minw,iminw]=min(w);
[maxw,imaxw]=max(w);

fprintf('\n');
fprintf('imin %d  min(sin(x)) = %14.7f\n',iminy,miny);
fprintf('imax %d  max(sin(x)) = %14.7f\n',imaxy,maxy);
fprintf('imin %d  min(cos(x)) = %14.7f\n',iminz,minz);
fprintf('imax %d  max(cos(x)) = %14.7f\n',imaxz,maxz);
fprintf('imin %d  min(sin(x)^2+cos(x)^2) = %14.7f\n',iminw,minw);
fprintf('imax %d  max(sin(x)^2+cos(x)^2) = %14.7f\n',imaxw,maxw);

figure(1);
title("Funzione Seno e Coseno");
plot(x, y, 'r-' ,"LineWidth", 2);
hold on
plot(x, z, 'b-', "LineWidth", 2);
xlabel("Asse X");
ylabel("Asse Y");
legend("Seno", "Coseno");
