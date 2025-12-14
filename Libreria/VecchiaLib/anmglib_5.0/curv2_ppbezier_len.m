function val = curv2_ppbezier_len(ppP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv2_ppbezier_len(ppP)
%Calcola la lunghezza della curva 2D di Bezier a tratti ppP
%ppP  --> struttura della curva 2D di Bezier a tratti:
%          ppP.deg --> grado della curva
%          bppP.cp  --> lista dei punti di controllo
%          ppP.ab  --> partizione nodale di [a b]
%val <-- valore della linghezza della curva
%utilizza la function gc_norm_c1_val()
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
    bezP.ab=[0,1];
    val=val+integral(@(x)gc_norm_c1_val(bezP,x),0,1);
end

end