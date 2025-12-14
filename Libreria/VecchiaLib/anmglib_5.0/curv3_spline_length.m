function val = curv3_spline_length(spline)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function val = curv3_spline_length(spline)
%Calcola il valore della lunghezza di una curva Spline 3D
%spline --> struttura di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x3 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%val <-- valore della lunghezza della curva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deg=spline.deg;
nt=length(spline.knot);
a=spline.knot(deg+1);
b=spline.knot(nt-deg);
val=integral(@(x)curv3_spline_vel_val(spline,x),a,b);

end