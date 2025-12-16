function main_tangmet(ifun,x0,tol,ftrace)
% questa function chiama la function tangmet per il metodo di Newton
% o delle tangenti e visualizza graficamente la funzione
% di cui si cercano gli zeri
% fun    --> indice della funzione test
% x0     --> iterato iniziale
% tol    --> tolleranza richiesta
% ftrace --> se >0 stampa successione iterati, 0 no

close all

%definizione funzione test
[xa,xb,fun,funp]=def_fun(ifun);

id=figure;
fplot(fun,[xa xb],'b-','LineWidth',1.5);
hold on
plot([xa,xb],[0,0],'r-','LineWidth',1.5);
fx0=feval(fun,x0);
plot(x0,0,'k+', 'MarkerSize', 12, 'LineWidth', 2);
plot(x0,fx0,'ro', 'MarkerSize', 12, 'LineWidth', 2);

[xstar,n,xs]=tangmet(fun,funp,x0,tol,ftrace);
plot(xstar,0,'g+', 'MarkerSize', 12, 'LineWidth', 2);
hold on
axis([xa,xb,-4,4]);

if (ftrace>0)
    fprintf('k xk                    ek \n');
    for i=1:n-1
        e1=abs(xs(i)-xstar);
        fprintf('%d %20.15e %20.15e\n',i,xs(i),e1);
    end
end

fprintf('zero: %20.15e\n',xstar);
fprintf('numero iterazioni effettuate: %d\n',n);

end
