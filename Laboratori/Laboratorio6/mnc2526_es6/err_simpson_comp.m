function err_simpson_comp(funz,a,b,n)
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula di simpson composta e
% calcola l'errore.
% funz --> stringa o handle della funzione integranda
% a,b --> estremi di integrazione
% n    --> numero di sottointervalli
% Viene prodotta una stampa

  if ischar(funz)
    fun=str2func(funz);
  else
    fun=funz;
  end
  I=integral(fun,a,b);
  fprintf('valore I= %22.15e\n',I);
  h=(b-a)/n;
  IA=simpson_comp(fun,a,b,n,1);
  AbsErr=abs(IA-I);
  fprintf('n S(h)       IA                    AbsErr\n');
  fprintf('%d %9.3e %22.15e %9.3e \n',n,h,IA,AbsErr);