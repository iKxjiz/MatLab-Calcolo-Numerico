function surfnurbs=surf_nurbs_ruled(nurbsA,nurbsB)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surfnurbs=surf_nurbs_ruled(nurbsA,nurbsB)
%Genera una superficie 3D nurbs rigata di due curve 3D nurbs
%nurbsA --> struttura di una curva nurbs:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp x3)
%          nurbs.knot  --> vettore dei nodi (ncp+nurbs.deg+1)
%          nurbs.w --> lista dei pesi (ncp)
%nurbsB --> struttura di una curva nurbs:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp x3)
%          nurbs.knot  --> vettore dei nodi (ncp+nurbs.deg+1)
%          nurbs.w --> lista dei pesi (ncp)
%surfnurbs <-- struttura di una superficie nurbs:
%      surfnurbs.deguv <-- grado della superficie in u e in v
%      surfnurbs.cp <-- griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  <-- vettore dei knot in u
%      surfnurbs.kv <-- vettore dei knot in v
%      surfnurbs.w <-- griglia dei pesi (ncpu)x(ncpv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n1,m1]=size(nurbsA.cp);
[n2,m2]=size(nurbsB.cp);
if((n1==n2 && m1==m2)|| nurbsA.knot~=nurbsB.knot)
  surfnurbs.deguv(1)=1;
  surfnurbs.deguv(2)=nurbsA.deg;
  surfnurbs.ku=[0,0,1,1];
  surfnurbs.kv=nurbsA.knot;

  surfnurbs.cp=zeros(2,n1,3);
  for i=1:n1
    for j=1:3
      surfnurbs.cp(1,i,j)=nurbsA.cp(i,j);
      surfnurbs.w(1,i)=nurbsA.w(i);
      surfnurbs.cp(2,i,j)=nurbsB.cp(i,j);
      surfnurbs.w(2,i)=nurbsB.w(i);
    end
  end
else
    fprintf('Le due curve non sono compatibili\n');
end

end
