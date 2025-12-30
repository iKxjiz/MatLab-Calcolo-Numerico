%*************************************************
%script sfiniti.m
%Esempio per sperimentare i numeri finiti
%'gradual underflow' dello standard ANSI/IEEE
%gestisce sia il caso BASIC single che BASIC double
%flag: 0 per BASIC single
%      1 per BASIC double
%*************************************************
clear
clc

%cambiare il flag
flag=0;

%caso single
if (flag==0)
  fprintf('=========  Numeri Fino al MINIMO esponente ========== \n\n');
  n=0;
  x=single(1.0);
  fprintf('(2 raised to the power %d) =  %22.15e \n',n,x);
  while (x>0)
    x=x/2;
    n=n+1;
    if (n == 126)
      fprintf('(2 raised to the power -%d) =  %22.15e \n',n,x);
      fprintf("Numeri Denormalizzati \n")
    else
      fprintf('(2 raised to the power -%d) =  %22.15e \n',n,x);
    end
  end
end
if (flag==0)
  fprintf('\n=========  Numeri Fino al MASSIMO esponente ========== \n\n');
  n=0;
  x=single(1.0);
  fprintf('(2 raised to the power %d) =  %22.15e \n',n,x);
  while (x+1>1 && n < 128)
    x=x*2;
    n=n+1;
    fprintf('(2 raised to the power %d) =  %22.15e \n',n,x);
  end
end

%caso double
if (flag==1)
  n=0;
  x=1.0;
  while (x>0)
    x=x/2;
    n=n+1;
    fprintf('(2 raised to the power -%d) =  %22.15e \n',n,x);
  end
end
if (flag==1)
  fprintf('======================================================= \n');
  n=0;
  x=1.0;
  while (x+1>1)
    x=x/2;
    n=n+1;
    fprintf('(2 raised to the power -%d) =  %22.15e \n',n,x);
  end
end