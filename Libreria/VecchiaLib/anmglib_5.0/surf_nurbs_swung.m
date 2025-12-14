function surfnurbs = surf_nurbs_swung(nurbsA,nurbsB,scal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surfnurbs = surf_nurbs_swung(nurbsA,nurbsB,scal)
%Genera una superficie 3D nurbs di swinging di due curve 3D nurbs
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
%scal --> scalare
%surfnurbs <-- struttura di una superficie nurbs:
%      surfnurbs.deguv <-- grado della superficie in u e in v
%      surfnurbs.cp <-- griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  <-- vettore dei knot in u
%      surfnurbs.kv <-- vettore dei knot in v
%      surfnurbs.w <-- griglia dei pesi (ncpu)x(ncpv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n1,m1]=size(nurbsA.cp);
[n2,m2]=size(nurbsB.cp);

surfnurbs.cp=zeros(n2,n1,3);
for k=1:n2
    for i=1:n1
     surfnurbs.cp(k,i,1)=scal*nurbsB.cp(k,1)*nurbsA.cp(i,1);
     surfnurbs.cp(k,i,2)=scal*nurbsB.cp(k,2)*nurbsA.cp(i,1);
     surfnurbs.cp(k,i,3)=nurbsA.cp(i,3);
     surfnurbs.w(k,i)=nurbsB.w(k)*nurbsA.w(i);
    end
end

surfnurbs.deguv = [nurbsB.deg nurbsA.deg];
surfnurbs.ku = nurbsB.knot;
surfnurbs.kv = nurbsA.knot;

end
