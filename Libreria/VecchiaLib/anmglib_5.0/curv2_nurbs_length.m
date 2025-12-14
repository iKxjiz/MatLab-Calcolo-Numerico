function val = curv2_nurbs_length(nurbs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv2_nurbs_vel_val(nurbs,x)
%Calcola il valore lunghezza di una curva nurbs 2D
%nurbs --> struttura di una curva nurbs:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp)x2 
%          nurbs.w   --> lista dei pesi
%          nurbs.knot  --> vettore dei nodi (ncp+g+1)
%val <-- valore della lunghezza della curva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deg=nurbs.deg;
nt=length(nurbs.knot);
a=nurbs.knot(deg+1);
b=nurbs.knot(nt-deg);
val=integral(@(x)curv2_nurbs_vel_val(nurbs,x),a,b);

end
