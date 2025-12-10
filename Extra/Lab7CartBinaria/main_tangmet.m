function main_tangmet(k,x0,tol,ftrace)
% questa funzione chiama tangmet per il metodo di Newton
% o delle tangenti e visualizza graficamente la funzione 
% di cui si cercano gli zeri
% k      --> indice della funzione
% x0     --> iterato iniziale
% tol    --> tolleranza richiesta
% ftrace --> se >0 stampa successione iterati, 0 no

funstr=['zfunf0',num2str(k,'%d')];
fun=str2func(funstr);
%derivata prime
funpstr=['zfunp0',num2str(k,'%d')];
funp=str2func(funpstr);

%intervallo di definizione delle funzioni
ab=fun();
xa=ab(1);
xb=ab(2);

id=figure;
fplot(fun,[xa xb],'b-','LineWidth',1.5);
hold on
plot([xa,xb],[0,0],'r-','LineWidth',1.5);
fx0=feval(fun,x0);
plot(x0,0,'r+');
plot(x0,fx0,'ro');

[xstar,n,xs]=tangmet(fun,funp,x0,tol,ftrace);
plot(xstar,0,'g+');
hold on
axis([xa,xb,-4,4]);

if (ftrace>0)
 for i=1:n
  fprintf('%d: %20.15e\n',i,xs(i));
 end
end

fprintf('zero: %20.15e\n',xstar);
fprintf('numero iterazioni effettuate: %d\n',n);


end