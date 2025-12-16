function [xstar,n,xs]=secmet(fun,x0,x1,tol,ftrace)
%**************************************************
% [xstar,n,xs]=secmet(fun,x0,x1,tol,ftrace)
% questa routine determina uno zero di una funzione 
% con il metodo delle secanti
% fun    --> handle della funzione
% x0,x1  --> iterati iniziali
% tol    --> tolleranza richiesta
% ftrace --> se >0 ritorna valori successione
% xstar  <-- approssimazione dello zero
% n      <-- numero iterazioni effettuate
% xs     <-- successione degli iterati
%**************************************************
  n=0;
  maxiter=50;
  smallreal=100.*realmin;
  xstar=x1;
  x1=x0;
  fx1=fun(x1);
  while ((abs(xstar-x1)>(tol+eps.*min([abs(x1),abs(xstar)]))) & (n<maxiter));
    x0=x1;
    fx0=fx1;
    x1=xstar;
    fx1=fun(x1);
    if (abs(fx1)>=smallreal)
      xstar=x1-fx1*(x1-x0)./(fx1-fx0);
      n=n+1;
      if(ftrace)
       xs(n)=xstar;
      end
    else
      fprintf('valori della funzione troppo piccoli\n');
    end
  end
  if (~ftrace)
    xs='';
  end
end
