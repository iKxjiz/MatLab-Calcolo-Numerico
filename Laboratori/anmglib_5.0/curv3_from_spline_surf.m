function curvspline=curv3_from_spline_surf(surfspline, fuv, uv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curvspline=curv3_from_spline_surf(gu, gv, P, u, v, fuv, uv)
%Determina una isocurva 3D spline da una superficie 3D spline
%surfspline --> struttura di una superficie spline:
%  surfspline.deguv --> vettore dei gradi della superficie in u e in v
%  surfspline.cp    --> griglia dei punti di controllo
%  surfspline.ku    --> vettore dei knot in u
%  surfspline.kv    --> vettore dei knot in v
%fuv   --> direzione u o v; 1=estrae curva in u; 2=estrae curva in v
%uv    --> parametro u o v (a seconda di fuv)
%          fuv=1 allora uv deve contenere un valore v=costante
%          fuv=2 allora uv deve contenere un valore u=costante
%spline <-- struttura contenente l'isocurva spline risultante:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo
%          spline.knot  --> vettore dei knot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ncpu,ncpv,dim]=size(surfspline.cp);

%direzione di valutazione
if (fuv==2)
%Algoritmo2: usa de Boor
%calcola ncpu curve in v per v:=uv
  Q=zeros(ncpu,3);
  R=zeros(ncpv,3);
  for j=1:ncpv
     Q=squeeze(surfspline.cp(:,j,:));
     splineA.cp= Q;
     splineA.knot=surfspline.ku;
     splineA.deg=surfspline.deguv(1);
     R(j,:)=deboor_val(splineA,uv);
  end
%struttura da restituire
  curvspline.cp=R;
  curvspline.knot=surfspline.kv;
  curvspline.deg=surfspline.deguv(2);
else
%Algoritmo2: usa di de Boor
%calcola ncpv curve in u per u:=uv
    Q=zeros(ncpv,3);
    R=zeros(ncpu,3);
    for i=1:ncpu
        Q=squeeze(surfspline.cp(i,:,:));
        splineA.cp= Q;
        splineA.knot=surfspline.kv;
        splineA.deg=surfspline.deguv(2);
        R(i,:)=deboor_val(splineA,uv);
    end
%struttura da restituire
    curvspline.cp=R;
    curvspline.knot=surfspline.ku;
    curvspline.deg=surfspline.deguv(1);
end

end

