function vel = curv2_vel_val(cp2name,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv2_vel_val(cp2name,a,b,x)
%Calcola il valore della funzione velocita' di una curva 2D in forma
%parametrica
%cp2name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%x --> punto/i in cui valutare
%vel <-- valore/i della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(cp2name);
np=length(x);
for i=1:np
 [x(i),y(i),xp(i),yp(i)]=curv(x(i));
 vel(i)=norm([xp(i),yp(i)],2);
end

end

