function mdppbezier=curv2_ppbezier2mdppbezier(ppbezier)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mdppbezier=curv2_ppbezier2mdppbezier(ppbezier)
%Converte una curva 2D di Bezier o Bézier a tratti in una curva
%di Bézier a tratti multi-degree
%ppbezier --> struttura di una curva ppbezier:
%          ppbezier.deg --> grado della curva
%          ppbezier.cp  --> lista dei punti di controllo (ncp)x2 
%          ppbezier.ab  --> vettore dei nodi
%mdppbezier  <-- struttura della curva 2D di Bezier a tratti 
%                multi-degree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mdppbezier=ppbezier;
np=length(ppbezier.ab)-1;
mdppbezier.deg=ppbezier.deg*ones(1,np);
end

