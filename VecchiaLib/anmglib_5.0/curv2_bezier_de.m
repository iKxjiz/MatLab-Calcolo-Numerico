function bezQ=curv2_bezier_de(bezP,de)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bezQ = curv2_bezier_de(bezP,de)
%Calcola la curva 2D di Bezier degree elevata di de della curva bezP
%bezP  --> struttura della curva 2D di Bezier :
%          bezP.deg --> grado della curva
%          bezP.cp  --> lista dei punti di controllo
%          bezP.ab  --> intervallo di definizione [a b]
%de    --> intero positivo che indica di quanto elevare il grado
%          della curva in input
%bezQ <-- struttura della curva 2D di Bezier :
%          bezQ.deg --> grado della curva
%          bezQ.cp  --> lista dei punti di controllo
%          bezQ.ab  --> intervallo di definizione [a b]
%utilizza la function gc_pol_de2d
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:de
  clear cpx cpy
  [cpx,cpy]=gc_pol_de2d(bezP.deg,bezP.cp(:,1),bezP.cp(:,2));
  bezP.cp=[cpx',cpy'];
  bezP.deg=bezP.deg+1;
end
bezQ.deg=bezP.deg;
bezQ.ab=bezP.ab;
bezQ.cp=[cpx',cpy'];
end