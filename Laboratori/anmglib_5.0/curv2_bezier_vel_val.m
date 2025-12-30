function vel = curv2_bezier_vel_val(bezier,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv2_bezier_vel_val(bezier,x)
%Calcola il valore della funzione velocita' di una curva di Bezier 2D
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%          bezier.ab  --> intervallo di definizione
%x --> punto/i in cui valutare
%vel <-- valore/i della  funzione velocita' in corrispondenza di x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
np=length(x);

Px=decast_valder(bezier,1,x);

for i=1:np
   vel(i)=norm([Px(2,i,1),Px(2,i,2)],2);
end

end