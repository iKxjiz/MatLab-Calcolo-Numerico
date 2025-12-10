function main_bisez(k,tol)
% questa routine determina uno zero di una funzione test
% di indice k con tolleranza tol con il metodo di bisezione;
% k      --> indice della funzione 1<=k<=18
% tol    --> tolleranza richiesta
% richiede in input l'intervallo di innesco dopo aver visualizzato
% il grafico della funzione nell'intervallo di definizione
close all
funstr=['zfunf0',num2str(k,'%d')];
fun=str2func(funstr);
%intervallo di definizione della funzione
ab=fun();
xa=ab(1);
xb=ab(2);

fplot(fun,[xa xb],'b-','LineWidth',1.5);
hold on
plot([xa,xb],[0,0],'r-','LineWidth',1.5);

intab=input('dai intervallo di innesco: ');
a=intab(1);
b=intab(2);
if (a < xa)
  a=xa;
end
if (b > xb)
  b=xb;
end
plot([a,b],[0,0],'g-','LineWidth',2.0);
fprintf('[a,b]: %20.15e %20.15e\n',a,b);
ftrace = 1;
[xstar,n,ab]=bisez(fun,a,b,tol,ftrace);
n
ab
plot(xstar,0,'ro');
fprintf('zero: %20.15e\n',xstar);
end
