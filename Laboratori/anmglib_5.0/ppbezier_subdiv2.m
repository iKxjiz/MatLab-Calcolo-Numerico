function [ppbezier_sx,ppbezier_dx]=ppbezier_subdiv(ppP,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [ppbezier_sx,ppbezier_dx]=ppbezier_subdiv(ppP,x)
%Suddivide una curva nD di bezier a tratti (ppP)
%definita dai punti di controllo ppP.cp nei punti x mediante 
%l'algoritmo di de Boor
%ppP --> struttura formata da 3 campi:
%          ppbezier.deg --> grado della curva
%          ppbezier.cp  --> lista dei punti di controllo
%          ppbezier.ab  --> partizione nodale
%x  --> punto in cui suddividere
%ppbezier_sx <-- struttura formata da 3 campi:
%          ppbezier_sx.deg --> grado della curva
%          ppbezier_sx.cp  --> lista dei punti di controllo
%          ppbezier_sx.ab  --> partizione nodale
%ppbezier_dx <-- struttura formata da 3 campi:
%          ppbezier_dx.deg --> grado della curva
%          ppbezier_dx.cp  --> lista dei punti di controllo
%          ppbezier_dx.ab  --> partizione nodale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%converte la curva ppP in una struttura spline a nodi multipli
%e utilizza la deboor_subdiv per la suddivisione
%conversione della ppP bezier a tratti in una struttura spline
spl.deg=ppP.deg;
spl.cp=ppP.cp;
m=length(ppP.ab);
spl.knot(1)=ppP.ab(1);
k1=1;
for i=1:m
    k2=k1+ppP.deg;
    spl.knot(k1+1:k2)=ppP.ab(i);
    k1=k2;
end
k1=k2+1;
spl.knot(k1)=ppP.ab(m);

[spline_sx,spline_dx]=deboor_subdiv(spl,x);
ppbezier_sx=curv2_spline2ppbezier(spline_sx);
ppbezier_dx=curv2_spline2ppbezier(spline_dx);
end

