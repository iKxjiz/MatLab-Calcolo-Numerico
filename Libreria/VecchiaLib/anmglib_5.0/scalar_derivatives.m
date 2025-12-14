function dy=scalar_derivatives(qx,qy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function dy=scalar_derivatives(qx,qy)
%Stima discreta delle derivate a partire da una lista di punti
%qx,qy --> coordinate punti di una funzione univariata
%dy    <-- valore stimato della derivata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(qy);
 for k=2:n
   hx(k)=qx(k)-qx(k-1);
   fy(k)=(qy(k)-qy(k-1))/hx(k);
 end
 for k=2:n-1
   dy(k)=0.5*(fy(k)+fy(k+1));
 end   
 dy(1)=2.*fy(2)-dy(2);
 dy(n)=2.*fy(n)-dy(n-1);
