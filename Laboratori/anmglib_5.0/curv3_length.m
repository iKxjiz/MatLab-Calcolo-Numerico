function val = curv3_length(cp3name,a,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv3_length(cp3name,a,b)
%Calcola la lunghezza di una curva 3D in forma parametrica
%cp3name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%a,b --> intervallo di definizione
%val <-- valore della lunghezza della curva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

val=integral(@(x)curv3_vel_val(cp3name,x),a,b);

end

