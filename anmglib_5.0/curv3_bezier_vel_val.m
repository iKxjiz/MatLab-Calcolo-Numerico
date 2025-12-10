function vel = curv3_bezier_vel_val(bezier,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv3_bezier_vel_val(bezier,x)
%Calcola il valore della funzione velocita' di una curva di Bezier 3D
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x3
%          bezier.ab  --> intervallo di definizione
%x --> punto/i in cui valutare
%vel <-- valore/i della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
np=length(x);

%Algoritmo2

Px=decast_valder(bezier,1,x);

for i=1:np
    vel(i)=norm([Px(2,i,1),Px(2,i,2),Px(2,i,3)],2);
end

end