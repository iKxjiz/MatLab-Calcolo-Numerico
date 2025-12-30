function ppP=ppbezierCC1_interp_der(t,y,yp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function pp_cp=ppbezierCC1_interp_der(x,y,yp)
%Calcola la cubica a tratti C1 di Hermite
%di interpolazione di una lista di valori e derivate
%t     --> lista di punti
%y     --> valori nei punti, da interpolare
%yp    --> derivate nei punti, da interpolare
%ppP   <-- struttura della cubica a tratti nella base di Bernstein
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=length(t);
nc=m-1;

ht(1:m-1)=t(2:m)-t(1:m-1);
for i=1:nc
    trei=3*(i-1)+1;
    cpy(trei)=y(i);
    cpy(trei+1)=y(i)+yp(i).*ht(i)./3;
    cpy(trei+2)=y(i+1)-yp(i+1).*ht(i)./3;
end
cpy(trei+3)=y(m);

ppP.deg=3;
ppP.cp(:,1)=cpy;
ppP.ab=t;

end


