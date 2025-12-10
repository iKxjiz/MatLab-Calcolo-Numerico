function l=gc_findinppab(ppab,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function l=gc_findinppab(ppab,x)
%Determina l'indice dell'intervalo nodale contenente il punto
%assegnato; se x e' un vettore di punti l sara' un vettore di indici.
%ppab --> vettore dei knot (estremi inclusi)
%x    --> lista dei punti in cui valutare
%l    <-- vettore di indici
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nt=length(ppab);
m=length(x);
for i=1:m
  l(i)=1;
  k=nt;
  while (k-l(i)>1)
    mid=fix((l(i)+k)./2);
    if (x(i)<ppab(mid))
      k=mid;
    else
      l(i)=mid;
    end
  end
end