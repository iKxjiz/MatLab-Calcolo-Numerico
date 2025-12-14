function vel = curv3_vel_val(cp3name,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv3_vel_val(cp3name,x)
%calcola il valore della funzione velocita' di una curva 3D in 
%forma parametrica
%cp3name --> nome del file con l'espressione parametrica della 
%            curva fino alla derivata prima
%x --> punto/i in cui valutare
%vel <-- valore/i della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(cp3name);
np=length(x);
for i=1:np
 [x(i),y(i),z(i),xp(i),yp(i),zp(i)]=curv(x(i));
 vel(i)=norm([xp(i),yp(i),zp(i)],2);
end

end

