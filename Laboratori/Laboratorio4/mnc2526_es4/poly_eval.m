function p=poly_eval(c,x,alg,flag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function p=poly_eval(c,x,alg,flag)
%Algoritmo di Ruffini-Horner per valutazione polinomio
%in forma canonica
%Input:
% c : vettore dei coefficienti (da quello di potenza massima
%     a quella minima)
% x : punto o vettore in cui valutare
% alg : 1 polyval di MATLAB (Ruffini-Horner)
%       2 Ruffini-Horner ciclo esplicito
%       3 Ruffini-Horner vettoriale
% flag : 1 test su conversione e stampa
%        0 no test e no stampa
%Output
% p : valori valutati in x

%valutazione mediante alg. di Ruffini-Horner
%
%p(x)=c(n+1) + c(n)*x + ... + c(2)*x^(n-2) + c(1)*x^(n-1)
%
%    =c(n+1) + x*(c(n) + ... x*( c(3) + x*( c(2) + x*c(1) ) ) ... )
%                                                    -p1-
%                                          ------  p2 ----
%                               ----------  p3  -------------
%      ---------------  p(n+1) -----------------------------------
%p=c(1)
%ciclo in k
%  p=c(k) + x * p
%fine ciclo

switch alg
   case 1
   %case 1-mediante chiamata alla built-in function MATLAB/Octave polyval()
     p=polyval(c,x);
   case 2
   %case 2-mediante algoritmo esplicito sia in double che in single
   %con eventuali stampe nei vari passi
    np1=length(c);
    if (flag)
      sc=single(c);
    end
    for i=1:length(x)
      p(i)=c(1);
    
      if (flag)
        sx=single(x(i));
        sp=sc(1);
      end
    
      for k=2:np1
          temp=x(i)*p(i);
          p(i)=c(k)+temp;
    
          if (flag)
              stemp=sx*sp;
              sp=sc(k)+stemp;
    
              fprintf('Passo %d --- %20.15e %20.15e %20.15e \n',k,temp,c(k),p(i));
              fprintf('Rapp. di temp: %d\n',stemp==temp)
              fprintf('Rapp. di c(k): %d\n',sc(k)==c(k))
              fprintf('Rapp. di p(i): %d\n',sp==p(i))
              if (k==np1)
                fprintf('i=%3d, x= %7.5f, Rapp. di x: %d, Erel= %e \n',i,x(i),single(x(i))==x(i),abs((p(i)-sp)./p(i)));
                fprintf('\n');
              end
          end
    
      end
    end
   case 3
    %case 3-ottimizzazione vettoriale
       np1=length(c);
       p=c(1).*ones(1,length(x));
       for k=2:np1
           p=c(k)+x.*p;
       end
end
