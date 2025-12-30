function err2_trapezi_comp(funz,a,b)
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula dei trapezi composta su
% differenti discretizzazioni e confronta gli errori.
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% Viene prodotta una stampa

fun=str2func(funz);
I=integral(fun,a,b);
fprintf('valore I= %14.7e\n',I);

fprintf('h          T(h)                  AbsErr    Rapporto\n');
m=11;
for i=1:m
  n=2^(i-1);
  h=(b-a)/n;
  IA=trapezi_comp(fun,a,b,n,0);
  AbsErr(i)=abs(IA-I);
  if(i>1)
    fprintf('%9.3e %22.15e %9.3e %9.3e\n',h,IA,AbsErr(i),AbsErr(i-1)/AbsErr(i));
  else
    fprintf('%9.3e %22.15e %9.3e\n',h,IA,AbsErr(i));
  end
end

fp=1;
dfun=str2func(['d','2','_',funz]);
%visualizzazione grafica
if (fp>0)
  close all
  figure(1)
  fplot(dfun,[a b],100,'LineWidth',1.5);
end
