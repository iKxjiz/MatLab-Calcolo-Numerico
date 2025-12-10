function t = partition_per(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function t = partition_per(x)
%Calcola la partizione nodale, per il metodo di interpolazione
%con spline cubiche e condizione periodica, da una lista di punti
%x      --> vettore da cui ricavare la partizione nodale
%t      <-- partizione nodale corrisponente
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(x);
t(4:n+3)=x;
t(3)=t(4)-(t(n+3)-t(n+2));
t(2)=t(4)-(t(n+3)-t(n+1));
t(1)=t(4)-(t(n+3)-t(n));
t(n+4)=t(n+3)+(t(5)-t(4));
t(n+5)=t(n+3)+(t(6)-t(4));
t(n+6)=t(n+3)+(t(7)-t(4));