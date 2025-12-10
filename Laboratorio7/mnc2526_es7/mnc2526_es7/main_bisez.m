function main_bisez(ifun,tol)
% questa function determina uno zero di una funzione test
% passata per nome, con tolleranza tol, con il metodo di bisezione;
% ifun   --> indice della funzione test
% tol    --> tolleranza richiesta
% dopo aver visualizzato il grafico della funzione nell'intervallo
% di definizione, richiede in input l'intervallo di innesco

close all

%definizione funzione test
[xa,xb,fun,funp]=def_fun(ifun);

fplot(fun,[xa xb],'LineWidth',1.5);
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
plot([a,b],[0,0],'g-','LineWidth',1.5);
fprintf('[a,b]: %20.15e %20.15e\n',a,b);

[xstar, ak, bk]=bisez(fun,a,b,tol);


fprintf('%20.15e %20.15e\n', ak(), bk());
fprintf('Numero di iterazioni %d\n', numel(ak));

plot(xstar,0,'ro','MarkerFaceColor','r','MarkerSize',9);
fprintf('\nzero: %20.15e\n',xstar);
end
