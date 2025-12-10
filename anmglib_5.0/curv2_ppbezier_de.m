function ppQ=curv2_ppbezier_de(ppP,de)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bezQ = curv2_ppbezier_de(bezP,de)
%Calcola la curva 2D di Bezier a tratti degree elevata di de 
%della curva di Bezier a tratti bezP
%bezP  --> struttura della curva 2D di Bezier a tratti:
%          bezP.deg --> grado della curva
%          bezP.cp  --> lista dei punti di controllo
%          bezP.ab  --> partizione nodale di [a b]
%bezQ <-- struttura della curva 2D di Bezier a tratti :
%          bezQ.deg --> grado della curva
%          bezQ.cp  --> lista dei punti di controllo
%          bezQ.ab  --> partizione nodale di [a b]
%utilizza la function gc_pol_de2d
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nc=length(ppP.ab)-1;
ppR.cp=[];
for j=1:nc
    k1=(j-1)*ppP.deg+1;
    k2=k1+ppP.deg;
    bezP.deg=ppP.deg;
    bezP.cp=ppP.cp(k1:k2,:);
    for i=1:de
      clear cpx cpy
      [cpx,cpy]=gc_pol_de2d(bezP.deg,bezP.cp(:,1),bezP.cp(:,2));
      bezP.cp=[cpx',cpy'];
      bezP.deg=bezP.deg+1;
    end
    ppR.cp=[ppR.cp;bezP.cp(1:bezP.deg,:)];
end
ppR.cp=[ppR.cp;bezP.cp(bezP.deg+1,:)];
ppQ.deg = ppP.deg+de;
ppQ.ab=ppP.ab;
ppQ.cp=ppR.cp;
end