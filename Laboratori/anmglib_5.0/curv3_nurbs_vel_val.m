function vel = curv3_nurbs_vel_val(nurbs,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function x = curv3_nurbs_vel_val(nurbs,x)
%Calcola il valore della funzione velocita' di una curva nurbs 3D
%nurbs --> struttura di una curva nurbs:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp)x2 
%          nurbs.w   --> lista dei pesi
%          nurbs.knot  --> vettore dei nodi (ncp+g+1)
%x --> punto/i in cui valutare 
%td <-- valore/i della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nm=length(x);

Px=nurbs_valder(nurbs,1,x);

for i=1:nm
    vel(i)=norm([Px(2,i,1),Px(2,i,2)],2);
end

end
