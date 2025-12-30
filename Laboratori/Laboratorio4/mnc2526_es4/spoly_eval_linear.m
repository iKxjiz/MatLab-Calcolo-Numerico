%script spoly_eval_linear.m
% Errore inerente nella valutazione polinomiale
% viene prodotto il grafico della funzione polinomiale
% nell'intervallo di definizione
clc
clear
close all

%settare gc per selezionare i diversi casi
gc=1;
switch gc
   case 1 % coefficienti numeri finiti, la discretizzazione no
      c=[100,-1];
      c=fliplr(c);  a=100;  b=101;
      %punti equispaziati
      m=51;
      x=linspace(a,b,m);
   case 2 % a_0 non finito, a_1 e discretizzazione si
      c=[99.9,-1];
      c=fliplr(c);  a=100;  b=101;
      h=2^-7;
      x=a:h:b;
      m=length(x);
   case 3 % a_1 non finito, a_0 e discretizzazione si
      c=[100,-1.001];
      c=fliplr(c);  a=100;  b=101;
      h=2^-7;
      x=a:h:b;
      m=length(x);
   case 4 % a_0, a_1 e discretizzazione sono numeri finiti
      c=[100,-1];
      c=fliplr(c);  a=100;  b=101;
      h=2^-7;
      x=a:h:b;
      m=length(x);
end

%altri set di punti di valutazione
% h=0.000244140625;
% x=a:h:b;

% h=2^-4;
% x=a:h:b;

% h=2^-5;
% x=a:h:b;

sc=single(c);
sx=single(x);

%Matlab function polyval
y=polyval(c,x);
sy=polyval(double(sc),double(sx));

% %nostra function poly_eval
% y=poly_eval(c,x,2,0);
% sy=poly_eval(double(sc),double(sx),2,0);

figure('Position', [10 10 500 800]);
subplot(3,1,1);
hold on;
plot(x,y,'r.-','LineWidth',1.5);
plot(x,zeros(1,m),'k-','LineWidth',1.5);
title('Grafico funzione polinomiale');

subplot(3,1,2);
relx=abs((sx-x)./x);
plot(x,relx,'r.-');
title('Grafico Errore sui Dati x');

subplot(3,1,3);
relerr=abs((sy-y)./y);
plot(x,relerr,'b.-');
title('Grafico Errore Inerente');

relc=abs(c-sc)./c;
fprintf('RelErr sui coeff. c: %e %e \n',relc);