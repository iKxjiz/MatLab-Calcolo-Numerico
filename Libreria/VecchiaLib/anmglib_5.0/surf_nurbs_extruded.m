function surfnurbs=surf_nurbs_extruded(nurbs,vect,dist)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surfnurbs=surf_nurbs_extruded(nurbs,vect,dist)
%Genera una superficie 3D nurbs per estrusione di una curva 3D nurbs
%nurbs --> struttura formata da 4 campi:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp x3)
%          nurbs.knot  --> vettore dei nodi (ncp+nurbs.deg+1)
%          nurbs.w --> lista dei pesi (ncp)
%vect  --> vettore 3D
%dist  --> scalare
%surfnurbs <-- struttura di una superficie spline:
%      surfnurbs.deguv <-- grado della superficie in u e in v
%      surfnurbs.cp <-- griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  <-- vettore dei knot in u
%      surfnurbs.kv <-- vettore dei knot in v
%      surfnurbs.w <-- griglia dei pesi (ncpu)x(ncpv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
surfnurbs.deguv(1)=1;
surfnurbs.deguv(2)=nurbs.deg;
surfnurbs.ku=[0,0,1,1];
surfnurbs.kv=nurbs.knot;

[n,m]=size(nurbs.cp);
surfnurbs.cp=zeros(2,n,3);
for i=1:n
    for j=1:3
      surfnurbs.cp(1,i,j)=nurbs.cp(i,j);
      surfnurbs.w(1,i)=nurbs.w(i);
      surfnurbs.cp(2,i,j)=nurbs.cp(i,j)+dist*vect(j);
      surfnurbs.w(2,i)=nurbs.w(i);
    end
end

end
