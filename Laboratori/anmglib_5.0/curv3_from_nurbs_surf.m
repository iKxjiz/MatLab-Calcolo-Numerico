function curvnurbs=curv3_from_nurbs_surf(surfnurbs, fuv, uv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curvnurbs=curv3_from_nurbs_surf(surfnurbs, fuv, uv)
%Determina una isocurva 3D nurbs da una superficie 3D nurbs
%surfnurbs --> struttura di una superficie nurbs:
%  surfnurbs.deguv --> vettore dei gradi della superficie in u e in v
%  surfnurbs.cp    --> griglia dei punti di controllo
%  surfnurbs.w     --> griglia dei pesi
%  surfnurbs.ku    --> vettore dei knot in u
%  surfnurbs.kv    --> vettore dei knot in v
%fuv   --> direzione u o v; 1=estrae curva in u; 2=estrae curva in v
%uv    --> parametro u o v (a seconda di fuv)
%          fuv=1 allora uv deve contenere un valore v=costante
%          fuv=2 allora uv deve contenere un valore u=costante
%nurbs <-- struttura contenente l'isocurva nurbs risultante:
%          nurbs.deg   --> grado della curva
%          nurbs.cp    --> lista dei punti di controllo
%          nurbs.w     --> lista dei pesi
%          nurbs.knot  --> vettore dei knot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ncpu,ncpv,dim]=size(surfnurbs.cp);

%direzione di valutazione
if (fuv==2)
%Algoritmo2: usa de Boor
%calcola ncpu curve in v per v:=uv
  Q=zeros(ncpu,3);
  QW=zeros(ncpu,1);
  R=zeros(ncpv,4);
  RW=zeros(ncpv,1);
  for j=1:ncpv
     Q=squeeze(surfnurbs.cp(:,j,:));
     QW=squeeze(surfnurbs.w(:,j));
     for i=1:ncpu
      splineA.cp(i,1:3)=Q(i,1:3).*QW(i);
      splineA.cp(i,4)=QW(i);
     end
     splineA.knot=surfnurbs.ku;
     splineA.deg=surfnurbs.deguv(1);
     R(j,:)=deboor_val(splineA,uv);
  end
%struttura da restituire
  for j=1:ncpv
    curvnurbs.w(j)=R(j,4);
    curvnurbs.cp(j,1:3)=R(j,1:3)./curvnurbs.w(j);
  end
  curvnurbs.knot=surfnurbs.kv;
  curvnurbs.deg=surfnurbs.deguv(2);
else
%Algoritmo2: usa de Boor
%calcola ncpv curve in u per u:=uv
    Q=zeros(ncpv,3);
    QW=zeros(ncpv,1);
    R=zeros(ncpu,4);
    RW=zeros(ncpu,1);
    for i=1:ncpu
        Q=squeeze(surfnurbs.cp(i,:,:));
        QW=squeeze(surfnurbs.w(i,:));
        for j=1:ncpv
          splineA.cp(j,1:3)=Q(j,1:3).*QW(j);
          splineA.cp(j,4)=QW(j);
        end
        splineA.knot=surfnurbs.kv;
        splineA.deg=surfnurbs.deguv(2);
        R(i,:)=deboor_val(splineA,uv);
    end
%struttura da restituire
    for i=1:ncpu
      curvnurbs.w(i)=R(i,4);
      curvnurbs.cp(i,1:3)=R(i,1:3)./curvnurbs.w(i);
    end
    curvnurbs.knot=surfnurbs.ku;
    curvnurbs.deg=surfnurbs.deguv(1);
end

end

