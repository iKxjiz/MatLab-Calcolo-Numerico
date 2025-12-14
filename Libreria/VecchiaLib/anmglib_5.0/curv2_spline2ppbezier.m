function ppbezier=curv2_spline2ppbezier(spline)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ppbezier=curv2_spline2ppbezier(spline)
%Converte una curva 2D spline in una curva di Bezier a tratti
%spline --> struttura di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x2 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%ppbezier  <-- struttura della curva 2D di Bezier a tratti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[t_mult,t_single,nt_s]=gc_knot_mult(spline.deg,spline.knot);

ppbezier.deg=spline.deg;
ppbezier.cp=zeros((nt_s+1)*spline.deg+1,2);
ppbezier.ab=zeros(1,nt_s+2);
i1=1;
ppbezier.ab(1)=spline.knot(spline.deg+1);
for i=1:nt_s 
  i2=i1+spline.deg;
  [spline_sx,spline_dx]=deboor_subdiv(spline,t_single(i));
  ppbezier.cp(i1:i2,:)=spline_sx.cp;
  ppbezier.ab(i+1)=t_single(i);
  clear P t
  spline.cp=spline_dx.cp;
  spline.knot=spline_dx.knot;
  i1=i2;
end
ppbezier.cp(i1:i1+spline.deg,:)=spline.cp;
ppbezier.ab(nt_s+2)=spline.knot(end-spline.deg);;

end

