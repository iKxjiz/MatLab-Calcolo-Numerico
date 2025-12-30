function bs=lagrange(g,qx,x)
% calcola le funzioni base definite a partire dai punti qx su un punto x;
% se x e' un vettore torna una matrice; in ogni riga ci sono
% i valori delle funzioni base in un punto.
% x  --> vettore punti di valutazione
% qx --> vettore punti su cui costruire la base
% bs <-- matrice delle funzioni di Lagrange nei punti

m=length(x);
n=g+1;
bs=zeros(m,n);
for k=1:m
 for i=1:n
     bs(k,i)=prod(x(k)-qx(1:i-1))*prod(x(k)-qx(i+1:n))./ ...
         (prod(qx(i)-qx(1:i-1))*prod(qx(i)-qx(i+1:n)));
  end
end

