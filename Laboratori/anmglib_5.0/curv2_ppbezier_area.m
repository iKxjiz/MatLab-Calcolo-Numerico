function val=curv2_ppbezier_area(ppP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv2_ppbezier_area(ppP,)
%Calcola l'area della curva 2D di Bezier a tratti ppP
%ppP  --> struttura della curva 2D di Bezier a tratti:
%          ppP.deg --> grado della curva
%          bppP.cp  --> lista dei punti di controllo
%          ppP.ab  --> partizione nodale di [a b]
%val <-- valore dell'area racchiusa dalla curva; se la curva e'
%        aperta, viene considerata la parte di piano limitata dalla
%        curva e dall'origine
%utilizza la function gc_cxc1_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=ppP.deg;
[ncp,~]=size(ppP.cp);
np=(ncp-1)/n;

%estrae le singole curve di Bézier
bezP.deg=n;
val=0;
for i=1:np
    i1=(i-1)*n+1;
    i2=i1+n;
    bezP.cp=ppP.cp(i1:i2,:);
    bezP.ab=[ppP.ab(i),ppP.ab(i+1)];
    val=val+integral(@(x)gc_cxc1_val(bezP,x),bezP.ab(1),bezP.ab(2));
end

end