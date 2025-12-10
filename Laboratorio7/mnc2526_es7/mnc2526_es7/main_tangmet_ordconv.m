function main_tangmet_ordconv(ifun,x0,tol,ftrace)
% questa function chiama tangmet per il metodo di Newton
% o delle tangenti e visualizza graficamente la funzione
% di cui si cercano gli zeri
% ifun   --> indice della funzione test
% x0     --> iterato iniziale
% tol    --> tolleranza richiesta
% ftrace --> se >0 produce stampe informative

close all

%definizione funzione test
[xa,xb,fun,funp]=def_fun(ifun);

id=figure;
fplot(fun,[xa xb],'b-','LineWidth',1.5);
hold on
plot([xa,xb],[0,0],'r-','LineWidth',1.5);
fx0=feval(fun,x0);
plot(x0,0,'r+');
plot(x0,fx0,'ro');

ftrace=1;
[xstar,n,xs]=tangmet(fun,funp,x0,tol,ftrace);
plot(xstar,0,'g+');
hold on
axis([xa,xb,-4,4]);

if(ftrace>0)
  fprintf('k xk                    ek                    |e_k+1|/|e_k|          |e_k+1|/|e_k|^2\n');
  for i=1:n-1
    e1=abs(xs(i)-xstar);
    if i > 1
      fprintf('%d %20.15e %20.15e %20.15e %20.15e\n', i, xs(i), e1, e1/e0, e1/e0^2);
    end
    e0 = e1;
  end
end

fprintf('zero: %20.15e\n',xstar);
fprintf('numero iterazioni effettuate: %d\n',n);


end
