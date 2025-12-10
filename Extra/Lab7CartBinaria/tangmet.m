function [xstar,n,xs]=tangmet(fun,funp,x0,tol,ftrace)
%******************************************************
% [xstar,n,xs]=tangmet(fun,funp,x0,tol,ftrace)
% questa routine determina uno zero di una funzione con 
% il metodo di Newton o delle tangenti
% fun    --> handle della funzione
% funp   --> nome della funzione derivata
% x0     --> iterato iniziale
% tol    --> tolleranza richiesta
% ftrace --> se >0 ritorna valori successione
% xstar  <-- approssimazione dello zero
% n      <-- iterazioni effettuate
% xs     <-- successione degli iterati
%*****************************************************
  n=0;
  maxiter=40;
  smallreal=100.*realmin;
  xstar=x0;
  xs=xstar;
  x0=x0+1;
  while ((abs(xstar-x0)>(tol+eps.*min([abs(x0),abs(xstar)]))) & (n<maxiter))
    x0=xstar;
    fx0=fun(x0);
    if (abs(fx0)>=smallreal)
      xstar=x0-fx0./funp(x0);
      n=n+1;
      if(ftrace)
       xs(n)=xstar;
      end
    else
      fprintf('valori della funzione troppo piccoli\n');
      return
    end
  end