function ppbezQ=curv2_ppbezier_reverse(ppbezP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ppbezQ = curv2_ppbezier_reverse(ppbezP)
%Calcola la curva 2D di Bezier a tratti reverse della curva ppbezP 
%a tratti
%ppbezP  --> struttura della curva 2D di Bezier a tratti :
%          ppbezP.deg --> grado della curva
%          ppbezP.cp  --> lista dei punti di controllo
%          ppbezP.ab  --> partizione nodale di [a b]
%ppbezQ <-- struttura della curva 2D di Bezier a tratti:
%          ppbezQ.deg --> grado della curva
%          ppbezQ.cp  --> lista dei punti di controllo
%          ppbezQ.ab  --> partizione nodale [a b]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppbezQ=ppbezP;
ppbezQ.cp=flip(ppbezP.cp);
n=length(ppbezQ.ab);
ppbezQ.ab=[ppbezQ.ab(1),ppbezQ.ab(1)+ppbezQ.ab(n)-flip(ppbezQ.ab(1:n-1))];
end