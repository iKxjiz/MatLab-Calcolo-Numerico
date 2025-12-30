function err2_simpson_rich(funz,a,b)
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula di Simpson composta
% ed estrapolazione di Richardson su
% differenti discretizzazioni e confronta gli errori.
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% Viene prodotta una stampa

fun=str2func(funz);
I=integral(fun,a,b);
fprintf('valore I= %22.15e\n',I);

fprintf('h          S(h)                  AbsErr    Rapporto   Richardson(h,h/2)     AbsErr    Rapporto\n');
for i=1:11
  n=2^(i-1);
  h=(b-a)/n;
  IA(i)=simpson_comp(fun,a,b,n,0);
  AbsErr(i)=abs(IA(i)-I);
  fprintf('%9.3e %22.15e %9.3e ',h,IA(i),AbsErr(i));
  if(i>1)
      EstRic=(16*IA(i)-IA(i-1))/15;
      AbsErr_EstRic(i)=abs(EstRic-I);
      if(i>2)
        fprintf('%9.3e %22.15e %9.3e %9.3e\n',AbsErr(i-1)/AbsErr(i),EstRic,AbsErr_EstRic(i),AbsErr_EstRic(i-1)/AbsErr_EstRic(i));
      else
        fprintf('%9.3e %22.15e %9.3e\n',AbsErr(i-1)/AbsErr(i),EstRic,AbsErr_EstRic(i));
      end
  else
      fprintf('\n');
  end
end
