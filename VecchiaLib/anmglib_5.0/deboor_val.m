function Px=deboor_val(spline,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=deboor_val(spline,x)
%Calcola il valore di una curva nD spline nella base B-spline
%definita dai punti di controllo spline.cp nei punti x mediante 
%l'algoritmo di de Boor
%spline --> struttura formata da 3 campi:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo
%          spline.knot  --> vettore dei nodi
%x  --> lista dei punti in cui valutare
%Px <-- coordinate dei punti della curva nei punti x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% n=length(spline.cp(:,1));
% nt=length(t);
% spline.deg=nt-n-1;
% disp('deboor')
%         disp(size(spline.cp))
%         disp(spline.knot);
%         disp(spline.deg);

m=length(x);
l=gc_findint(spline.deg,spline.knot,x);
for k=1:m
 W=spline.cp;
 for j=1:spline.deg
  for i=l(k):-1:l(k)-spline.deg+j
   d1=x(k)-spline.knot(i);
   d2=spline.knot(i+spline.deg-j+1)-x(k);
   W(i,:)=(d1.*W(i,:)+d2.*W(i-1,:))./(d1+d2);
  end
 end
 Px(k,:)=W(l(k),:);
end

