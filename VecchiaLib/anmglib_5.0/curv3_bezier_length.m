function val = curv3_bezier_length(bezier)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv3_bezier_length(bezier)
%Calcola il valore della lunghezza di una curva di Bezier 3D
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%          bezier.ab  --> intervallo di definizione
%val <-- valore della lunghezza della curva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

val=integral(@(x)curv3_bezier_vel_val(bezier,x),bezier.ab(1),bezier.ab(2));

end