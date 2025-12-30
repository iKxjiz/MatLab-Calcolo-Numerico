function val=curv2_mdppbezier_area(mdppP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv2_mdppbezier_area(mdppP,)
%Calcola l'area della curva 2D di Bezier a tratti multi-degree mdppP
%mdppP  --> struttura della curva 2D di Bezier a tratti multi-degree:
%           mdppP.deg --> lista dei gradi della curva
%           mdbppP.cp  --> lista dei punti di controllo
%           mdppP.ab  --> partizione nodale di [a b]
%val <-- valore dell'area racchiusa dalla curva; se la curva e'
%        aperta, viene considerata la parte di piano limitata dalla
%        curva e dall'origine
%utilizza la function gc_cxc1_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [np,~]=size(mdppP.ab)-1;
np=length(mdppP.ab)-1;
%gradi
ng=length(mdppP.deg);

if (ng==1 && np>1)
%La curva non e' una mdppbezier, ma una ppbezier);
    mdppP=curv2_ppbezier2mdppbezier(mdppP);
end
%estrae le singole curve di Bézier
val=0;
i2=1;
for i=1:np
    n=mdppP.deg(i);
    bezP.deg=n;
    i1=i2;
    i2=i1+n;
    bezP.cp=mdppP.cp(i1:i2,:);
    bezP.ab=[mdppP.ab(i),mdppP.ab(i+1)];
    val=val+integral(@(x)gc_cxc1_val(bezP,x),bezP.ab(1),bezP.ab(2));
end

end