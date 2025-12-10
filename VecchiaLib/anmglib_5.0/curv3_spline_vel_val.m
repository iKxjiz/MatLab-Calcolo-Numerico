function vel = curv3_spline_vel_val(spline,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel =curv3_spline_vel_val(spline,x)
%Calcola il valore della funzione velocita' di una curva 3D di Bezier
%spline --> struttura formata di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x3 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%x --> punto/i in cui valutare
%vel <-- valore/i della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nm=length(x);

Px=deboor_valder(spline,1,x);

for i=1:nm
    vel(i)=norm([Px(2,i,1),Px(2,i,2),Px(2,i,3)],2);
end

end

