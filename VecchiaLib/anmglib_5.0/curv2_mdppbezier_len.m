function val=curv2_mdppbezier_len(mdppP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv2_mdppbezier_len(mdppP)
%Calcola la lunghezza della curva 2D di Bezier a tratti multi-degree mdppP
%mdppP  --> struttura della curva 2D di Bezier a tratti multi-degree:
%           mdppP.deg --> lista dei gradi della curva
%           mdbppP.cp  --> lista dei punti di controllo
%           mdppP.ab  --> partizione nodale di [a b]
%val <-- valore della lunghezza della curva
%utilizza la function gc_norm_c1_val()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[np,~]=size(mdppP.ab)-1;

%estrae le singole curve di Bézier
val=0;
for i=1:np
    n=mdppP.deg(i);
    bezP.deg=n;
    i1=(i-1)*n+1;
    i2=i1+n;
    bezP.cp=mdppP.cp(i1:i2,:);
    bezP.ab=[mdppP.ab(i),mdppP.ab(i+1)];
    val=val+integral(@(x)gc_norm_c1_val(bezP,x),bezP.ab(1),bezP.ab(2));
end

end