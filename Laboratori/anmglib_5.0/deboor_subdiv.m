function [spline_sx,spline_dx]=deboor_subdiv(spline,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [spline_sx,spline_dx]=deboor_subdiv(spline,x)
%Suddivide una curva nD spline definita dai punti di controllo
%spline.cp e dai nodi spline.knot nel punto x mediante l'algoritmo di de Boor
%spline --> struttura di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%x  --> punto in cui suddividere
%spline_sx <-- struttura dela spline sinistra
%          spline_sx.deg <-- grado della curva
%          spline_sx.cp  <-- lista dei punti di controllo
%          spline_sx.knot  <-- vettore dei nodi (ncp+g+1)
%spline_dx <-- struttura dela spline destra
%          spline_dx.deg <-- grado della curva
%          spline_dx.cp  <-- lista dei punti di controllo
%          spline_dx.knot  <-- vettore dei nodi (ncp+g+1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(spline.cp(:,1));
nt=length(spline.knot);
if (spline.deg==nt-n-1)
[t_mult,t_single,nt_s]=gc_knot_mult(spline.deg,spline.knot);
l=gc_findint(spline.deg,spline.knot,x);
%determina se il punto di suddivisione 
%e' un nodo e di che molteplicita'
 lk=0;
 for kk=1:nt_s
     if (x==t_single(kk))
         lk=t_mult(kk);
     end
 end
%definiamo la variabile lmlk
 lmlk=l-lk;
%Costruisce le due partizioni nodali risultanti per
 spline_sx.knot=spline.knot(1:lmlk);
 spline_sx.knot(lmlk+1:lmlk+spline.deg+1)=x;
 spline_dx.knot(1:spline.deg+1)=x;
 spline_dx.knot(spline.deg+2:spline.deg+nt-l+1)=spline.knot(l+1:nt);
%Algoritmo di de Boor per suddividere in due curve spline    
 W=spline.cp;
 spline_sx.cp=spline.cp(1:lmlk,:);
 spline_dx.cp=spline.cp(l-spline.deg:n,:);
 for j=1:spline.deg-lk
  for i=lmlk:-1:l-spline.deg+j
   d1=x-spline.knot(i);
   d2=spline.knot(i+spline.deg-j+1)-x;
   W(i,:)=(d1.*W(i,:)+d2.*W(i-1,:))./(d1+d2);
   spline_sx.cp(i,:)=W(i,:);
  end
  spline_dx.cp(spline.deg-lk-j+1,:)=W(lmlk,:);
 end
else
    fprintf('ERRORE: dati non corretti\n');
end
%Imposto nel campo deg il grado delle nuove spline create
nsx=length(spline_sx.cp(:,1));
ntsx=length(spline_sx.knot);
spline_sx.deg=ntsx-nsx-1;

ndx=length(spline_sx.cp(:,1));
ntdx=length(spline_sx.knot);
spline_dx.deg=ntdx-ndx-1;

end

