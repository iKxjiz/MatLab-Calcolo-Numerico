function err2_simpson_comp(funz,a,b)
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula dei trapezi composta su
% differenti discretizzazioni e confronta gli errori.
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% Viene prodotta una stampa


fun=str2func(funz);
I=integral(fun,a,b);
fprintf('valore I= %22.15e\n',I);

fprintf('h          S(h)                  AbsErr    Rapporto\n');
m=11;
for i=1:m
  n=2^(i-1);
  h=(b-a)/n;
  IA(i)=simpson_comp(fun,a,b,n,0);
  AbsErr(i)=abs(IA(i)-I);
  if(i>1)
    fprintf('%9.3e %22.15e %9.3e %9.3e\n',h,IA(i),AbsErr(i),AbsErr(i-1)/AbsErr(i));
  else
    fprintf('%9.3e %22.15e %9.3e\n',h,IA(i),AbsErr(i));
  end
end

% Metti fp = 1 per la visualizzazione grafica della derivata quarta
% nota, se il grafico è piatto (c'è un picco vicino a zero), devo allontanare
% l'intervallo da 0, va bene anche da 0.5 in poi es. [0.5, 12]
fp=0;
dfun=str2func(['d','4','_',funz]);
%visualizzazione grafica
if (fp>0)
  close all
  figure(1)
  fplot(dfun,[a,b],100,'LineWidth',2);
end