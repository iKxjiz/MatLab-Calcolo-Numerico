function Px=deboor_valder(spline,kk,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=deboor_valder(spline,kk,x)
%Calcola il valore e le derivate fino a ordine kk<=spline.deg di una
%curva nD spline nella base B-spline definita dai punti di 
%controllo spline.cp nei punti x mediante l'algoritmo di de Boor
%spline --> struttura di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo 
%          spline.knot  --> vettore dei nodi
%kk --> ordine di derivazione (kk<=spline.deg)
%x  --> lista dei punti in cui valutare
%Px <-- punti(i,j,k) della curva spline nei punti x(j)
%       i: indice di derivazione i=1 valore, i=2 derivata prima, ecc.
%       j: indice punto di valutazione
%       k: indice della coordinata del punto della curva nD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Array di lavoro
% P1 <-- punti di controllo della curva spline sinistra
% t1 <-- vettore nodale della curva sinistra
% P2 <-- punti di controllo della curva spline destra
% t2 <-- vettore nodale della curva destra
n=length(spline.cp(:,1));
nt=length(spline.knot);
if (spline.deg==nt-n-1)
 a=spline.knot(spline.deg+1);
 b=spline.knot(nt-spline.deg);
 [t_mult,t_single,nt_s]=gc_knot_mult(spline.deg,spline.knot);
 l=gc_findint(spline.deg,spline.knot,x);
 m=length(x);
%ciclo sui punti di valutazione
 for k=1:m
  if (a<x(k) && x(k)<b)
%determina se il punto di valutazione/suddivisione 
%e' un nodo e di che molteplicita'
   lk=0;
   for kkk=1:nt_s
     if (x(k)==t_single(kkk))
         lk=t_mult(kkk);
     end
   end
%definiamo la variabile lmlk di lavoro
   lmlk=l(k)-lk;
%Costruisce le due partizioni nodali risultanti 
   clear t1 t2
   t1=spline.knot(1:lmlk);
   t1(lmlk+1:lmlk+spline.deg+1)=x(k);
   a1=x(k)-t1(lmlk);
   t2(1:spline.deg+1)=x(k);
   t2(spline.deg+2:spline.deg+nt-l(k)+1)=spline.knot(l(k)+1:nt);
   a2=t2(spline.deg+2)-x(k);
%Algoritmo di de Boor per valutare/suddividere in due curve spline 
   clear W P1 P2
   W=spline.cp;
   P1=spline.cp(1:lmlk,:);
   P2=spline.cp(l(k)-spline.deg:n,:);
   for j=1:spline.deg-lk
     for i=lmlk:-1:l(k)-spline.deg+j
      d1=x(k)-spline.knot(i);
      d2=spline.knot(i+spline.deg-j+1)-x(k);
      W(i,:)=(d1.*W(i,:)+d2.*W(i-1,:))./(d1+d2);
      P1(i,:)=W(i,:); 
     end
     P2(spline.deg-lk-j+1,:)=W(lmlk,:);
   end
  else
      if (a==x(k))
          a1=0;
          a2=1;
          t2=spline.knot;
          P2=spline.cp;
      else
          a1=1;
          a2=0;
          t1=spline.knot;
          P1=spline.cp;
      end 
  end

%valutazione derivate con opportuna scalatura
%a1 e a2 settate in fase di definizione delle partizioni nodali
%t1 e t2, permettono di scegliere quella delle due spline piu'
%stabile, ossia quella tra le due per cui l'ultimo intervallo
%nodale di t1 ed il primo di t2 sia piu' grande.
  if (a1 < a2)
   nt2=length(t2);
   ncp2=nt2-spline.deg-1;
%fprintf('x=%f t2\n',x(k));
%fprintf('%f ',t2);
%fprintf('\n');
   for j=1:kk
    for i=kk+1:-1:j+1
     d2=t2(i+spline.deg+1-j)-t2(i);
     P2(i,:)=(spline.deg+1-j).*(P2(i,:)-P2(i-1,:))./d2;
    end
   end
   for i=1:kk+1
    Px(i,k,:)=P2(i,:);
   end
  else
   nt1=length(t1);
   ncp1=nt1-spline.deg-1;
%fprintf('x=%f t1\n',x(k));
%fprintf('%f ',t1);
%fprintf('\n');
   for j=1:kk
    for i=ncp1-kk:ncp1-j
     d1=t1(i+spline.deg+1)-t1(i+j);
     P1(i,:)=(spline.deg+1-j).*(P1(i+1,:)-P1(i,:))./d1;
    end
   end
   for i=1:kk+1
     Px(i,k,:)=P1(ncp1-i+1,:);
   end
  end

 end

else
    fprintf('ERRORE: dati non corretti\n');
end

end

