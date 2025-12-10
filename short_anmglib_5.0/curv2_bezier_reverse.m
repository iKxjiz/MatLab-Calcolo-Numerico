function bezQ=curv2_bezier_reverse(bezP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bezQ = curv2_bezier_reverse(bezP)
%Calcola la curva 2D di Bezier reverse della curva bezP
%bezP  --> struttura della curva 2D di Bezier :
%          bezP.deg --> grado della curva
%          bezP.cp  --> lista dei punti di controllo
%          bezP.ab  --> intervallo di definizione [a b]
%bezQ <-- struttura della curva 2D di Bezier :
%          bezQ.deg --> grado della curva
%          bezQ.cp  --> lista dei punti di controllo
%          bezQ.ab  --> intervallo di definizione [a b]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bezQ=bezP;
bezQ.cp=flip(bezP.cp);
end