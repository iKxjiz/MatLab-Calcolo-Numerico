function l=gc_findint(g,t,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function l=gc_findint(g,t,x)
%Determina l'indice dell'intervalo nodale contenente il punto
%assegnato; se x e' un vettore di punti l sara' un vettore di indici.
%g --> grado della spline
%t --> vettore dei knot
%x --> lista dei punti in cui valutare
%l <-- vettore di indici
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nt=length(t);
m=length(x);
for i=1:m
  l(i)=g+1;
  k=nt-g;
  while (k-l(i)>1)
    mid=fix((l(i)+k)./2);
    if (x(i)<t(mid))
      k=mid;
    else
      l(i)=mid;
    end
  end
end
