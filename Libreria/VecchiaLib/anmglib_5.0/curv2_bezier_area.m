function val=curv2_bezier_area(P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv2_bezier_area(P)
%Calcola l'area della curva 2D di Bezier P
%P  --> struttura della curva 2D di Bezier a tratti:
%        P.deg --> grado della curva
%        P.cp  --> lista dei punti di controllo
%        P.ab  --> partizione nodale di [a b]
%val <-- valore dell'area racchiusa dalla curva; se la curva e'
%        aperta, viene considerata la parte di piano limitata dalla
%        curva e dall'origine
%utilizza la function gc_cxc1_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    val=integral(@(x)gc_cxc1_val(P,x),P.ab(1),P.ab(2));

end