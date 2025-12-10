function Px=wozny_val2(bezier,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=wozny_val2(bezier,t)
%Calcola il valore di una curva nD nella base di Bernstein in [0,1]
%definita dai punti di controllo bezier.cp nei punti t mediante un
%nuovo algoritmo dovuto a Wozny e Chudy (2020).
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo
%          bezier.ab  --> intervallo di definizione
%t  --> lista dei punti in cui valutare
%Px <-- punti della curva nei punti t
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=length(t);
%cambio di variabile [a,b]-->[0,1]
bma=(bezier.ab(2)-bezier.ab(1));
t=(t-bezier.ab(1))./bma;

for ii=1:m
 h=1;
 Px(ii)=bezier.cp(1);
 d1=t(ii);
 d2=1.0-t(ii);
 deg1=bezier.deg+1;
 if (t(ii) <= 0.5)
     d2=t(ii)/d2;
     for j=1:bezier.deg
        h=h*d2*(deg1-j);
        h=h/(j+h);
        h1=1-h;
        Px(ii)=h1.*Px(ii)+h.*bezier.cp(j+1);
     end
 else
    d2=d2/t(ii);
    for j=1:bezier.deg
      h=h*(deg1-j);
      h=h/(j*d2+h);
      h1=1-h;
      Px(ii)=h1.*Px(ii)+h.*bezier.cp(j+1);
    end
 end
end
