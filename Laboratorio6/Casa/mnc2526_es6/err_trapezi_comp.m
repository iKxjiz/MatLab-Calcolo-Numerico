function err_trapezi_comp(funz,a,b,n)
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula dei trapezi composta e
% calcola l'errore.
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% n    --> numero di sottointervalli
% Viene prodotta una stampa

  fun=str2func(funz);
  
  I=integral(fun,a,b);
  fprintf('valore I= %22.15e\n',I);
  
  h=(b-a)/n;
  IA=trapezi_comp(fun,a,b,n,1);
  
  AbsErr=abs(IA-I);
  fprintf('n T(h)       IA                    AbsErr\n');
  fprintf('%d %9.3e %22.15e %9.3e \n',n,h,IA,AbsErr);

