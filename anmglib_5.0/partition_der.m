function t = partition_der(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function t = partition_der(x)
%Calcola la partizione nodale, per il metodo di interpolazione
%con spline cubiche e condizione di derivate agli estremi, 
%da una lista di punti  
%x      --> vettore da cui ricavare la partizione nodale
%t      <-- partizione nodale corrisponente
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = length(x);
t(1:4)=x(1).*ones(size(1:4));
t(5:n+2)=x(2:n-1);
t(n+3:n+6)=x(n).*ones(size(1:4));