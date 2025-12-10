function Px=wozny_val(bezier,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=wozny_val(bezier,t)
%Calcola il valore di una curva nD nella base di Bernstein in [0,1]
%definita dai punti di controllo bezier.cp nei punti t mediante un
%nuovo algoritmo dovuto a Wozny e Chudy (2020) di complessità O(n)
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
 hk=1;
 hkm1=1;
 Px(ii)=bezier.cp(1);
 d1=t(ii);
 d2=1.0-t(ii);
 degp1=bezier.deg+1;
 for k=1:bezier.deg
    hk=hk*d1*(degp1-k);
    hk=hk/(k*d2+hk);

    if (hk == 0)
        h1=1;
    else
 %      h1=1-hk;
        h1=(hk*k*d2)/(hkm1*(degp1-k)*d1);
    end
    Px(ii)=h1.*Px(ii)+hk.*bezier.cp(k+1);
    hkm1=hk;
 end
end
