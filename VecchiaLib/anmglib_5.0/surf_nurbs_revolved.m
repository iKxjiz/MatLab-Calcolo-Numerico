function surfnurbs=surf_nurbs_revolved(nurbs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surfnurbs=surf_nurbs_revolved(nurbs)
%Genera una superficie 3D nurbs per rotazione di una curva 3D nurbs
%nel piano xz intorno all'asse z
%nurbs --> struttura formata da 4 campi:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp x3)
%          nurbs.knot  --> vettore dei nodi (ncp+nurbs.deg+1)
%          nurbs.w --> lista dei pesi (ncp)
%surfnurbs <-- struttura di una superficie spline:
%      surfnurbs.deguv <-- grado della superficie in u e in v
%      surfnurbs.cp <-- griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  <-- vettore dei knot in u
%      surfnurbs.kv <-- vettore dei knot in v
%      surfnurbs.w <-- griglia dei pesi (ncpu)x(ncpv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
surfnurbs.deguv(1)=2;
surfnurbs.deguv(2)=nurbs.deg;
surfnurbs.ku=[0,0,0,0.25,0.25,0.5,0.5,0.75,0.75,1,1,1];
surfnurbs.kv=nurbs.knot;
sqr22=sqrt(2)/2;
w=[1,sqr22,1,sqr22,1,sqr22,1,sqr22,1];

[n,m]=size(nurbs.cp);
surfnurbs.cp=zeros(9,n,3);
for i=1:n
    for j=1:3
      surfnurbs.cp(1,i,j)=nurbs.cp(i,j);
      surfnurbs.w(1,i)=w(1)*nurbs.w(i);
      surfnurbs.cp(9,i,j)=nurbs.cp(i,j);
      surfnurbs.w(9,i)=w(9)*nurbs.w(i);
    end
end
for i=1:n
  surfnurbs.cp(2,i,1)=nurbs.cp(i,1);
  surfnurbs.cp(2,i,2)=nurbs.cp(i,1);
  surfnurbs.cp(2,i,3)=nurbs.cp(i,3);
  surfnurbs.w(2,i)=w(2)*nurbs.w(i);
  surfnurbs.cp(3,i,1)=0;
  surfnurbs.cp(3,i,2)=nurbs.cp(i,1);
  surfnurbs.cp(3,i,3)=nurbs.cp(i,3);
  surfnurbs.w(3,i)=w(3)*nurbs.w(i);
  surfnurbs.cp(4,i,1)=-nurbs.cp(i,1);
  surfnurbs.cp(4,i,2)=nurbs.cp(i,1);
  surfnurbs.cp(4,i,3)=nurbs.cp(i,3);
  surfnurbs.w(4,i)=w(4)*nurbs.w(i);
  surfnurbs.cp(5,i,1)=-nurbs.cp(i,1);
  surfnurbs.cp(5,i,2)=0;
  surfnurbs.cp(5,i,3)=nurbs.cp(i,3);
  surfnurbs.w(5,i)=w(5)*nurbs.w(i);
  surfnurbs.cp(6,i,1)=-nurbs.cp(i,1);
  surfnurbs.cp(6,i,2)=-nurbs.cp(i,1);
  surfnurbs.cp(6,i,3)=nurbs.cp(i,3);
  surfnurbs.w(6,i)=w(6)*nurbs.w(i);
  surfnurbs.cp(7,i,1)=0;
  surfnurbs.cp(7,i,2)=-nurbs.cp(i,1);
  surfnurbs.cp(7,i,3)=nurbs.cp(i,3);
  surfnurbs.w(7,i)=w(7)*nurbs.w(i);
  surfnurbs.cp(8,i,1)=nurbs.cp(i,1);
  surfnurbs.cp(8,i,2)=-nurbs.cp(i,1);
  surfnurbs.cp(8,i,3)=nurbs.cp(i,3);
  surfnurbs.w(8,i)=w(8)*nurbs.w(i);
end

end
