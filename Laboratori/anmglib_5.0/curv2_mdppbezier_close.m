function ppP=curv2_mdppbezier_close(ppP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ppP = curv2_mdppbezier_close(ppP)
%Modifica la curva 2D di Bezier, Bézier a tratti o Bézier a tratti
%multi-degre ppP, affinché sia una curva di Bézier a tratti 
%multi-degree chiusa
%ppP --> struttura della curva 2D di Bezier,  a tratti:
%          ppP.deg --> grado della curva
%          bppP.cp  --> lista dei punti di controllo
%          ppP.ab  --> partizione nodale di [a b]
%ppP <-- restituisce la curva modificata come Bézier a tratti
%        multi-degree chiusa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v=[ppP.cp(1,:)-ppP.cp(end,:)];
if (norm(v,2)<1.0e-2)
    ppP.cp(end,:)=ppP.cp(1,:);
else
    nd=length(ppP.deg);
    nab=length(ppP.ab);
    if (nd==1 && nab>2)
       ppP=curv2_ppbezier2mdppbezier(ppP);
    end
    nd=length(ppP.deg);
    ppP.deg(nd+1)=1;
    ppP.ab(nab+1)=2*ppP.ab(nab)-ppP.ab(nab-1);
    ncp=length(ppP.cp(:,1));
    ppP.cp(ncp+1,:)=ppP.cp(1,:);
    end
end