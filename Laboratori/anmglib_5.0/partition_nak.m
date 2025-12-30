function t = partition_nak(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function t = partition_nak(x)
%Calcola la partizione nodale, per il metodo di interpolazione
%con spline cubiche e condizione not-a-knot, da una lista di punti
%x      --> vettore da cui ricavare la partizione nodale
%t      <-- partizione nodale corrisponente
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(x);
t(1:4)=x(1)*ones(size(1:4));
t(5:n)=x(3:n-2);
t(n+1:n+4)=x(n)*ones(size(1:4));