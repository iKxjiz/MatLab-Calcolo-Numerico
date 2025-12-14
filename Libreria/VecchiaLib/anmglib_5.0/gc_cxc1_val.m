function val = gc_cxc1_val(bezier,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calcola il valore della funzione C(t)xC'(t) con C(t) curva di 
%Bezier 2D definita in [0,1]
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%          bezier.ab  --> intervallo di definizione
%x --> valore/i parametrici in cui valutare
%val <-- valore/i della funzione C(t)xC'(t) in corrispondenza di t
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pt=decast_valder(bezier,1,t);

val=0.5.*(Pt(1,:,1).*Pt(2,:,2)-Pt(1,:,2).*Pt(2,:,1));

end