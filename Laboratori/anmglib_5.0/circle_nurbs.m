function nurbs=circle_nurbs(O,r,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function nurbs=circle_nurbs(O,r,n)
%Determina sul piano definito dal punto 3D O e dal vettore 
%normale n una circonferenza nurbs di centro O e raggio r
%O  --> punto 3D
%r  --> raggio
%n  --> vettore normale 3D
%nurbs <-- struttura formata da 4 campi:
%          nurbs.deg <-- grado della curva
%          nurbs.cp  <-- lista dei punti di controllo
%          nurbs.knot  <-- vettore dei nodi
%          nurbs.w <-- lista dei pesi (weight)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=n./norm(n,2);
if (n(1)~=0 || n(2)~=0)
    v1=[-n(2),n(1),0];
elseif (n(3)~=0)
    v1=[-n(3),0,n(1)];
else
    disp('vettore nullo');
    return
end
v2=cross(n,v1);
vv1=v1./norm(v1,2);
vv2=v2./norm(v2,2);

nurbs.cp(1,1)=O(1)+r*vv1(1);
nurbs.cp(1,2)=O(2)+r*vv1(2);
nurbs.cp(1,3)=O(3)+r*vv1(3);
nurbs.cp(2,1)=O(1)+r*vv1(1)+r*vv2(1);
nurbs.cp(2,2)=O(2)+r*vv1(2)+r*vv2(2);
nurbs.cp(2,3)=O(3)+r*vv1(3)+r*vv2(3);
nurbs.cp(3,1)=O(1)+r*vv2(1);
nurbs.cp(3,2)=O(2)+r*vv2(2);
nurbs.cp(3,3)=O(3)+r*vv2(3);
nurbs.cp(4,1)=O(1)-r*vv1(1)+r*vv2(1);
nurbs.cp(4,2)=O(2)-r*vv1(2)+r*vv2(2);
nurbs.cp(4,3)=O(3)-r*vv1(3)+r*vv2(3);
nurbs.cp(5,1)=O(1)-r*vv1(1);
nurbs.cp(5,2)=O(2)-r*vv1(2);
nurbs.cp(5,3)=O(3)-r*vv1(3);
nurbs.cp(6,1)=O(1)-r*vv1(1)-r*vv2(1);
nurbs.cp(6,2)=O(2)-r*vv1(2)-r*vv2(2);
nurbs.cp(6,3)=O(3)-r*vv1(3)-r*vv2(3);
nurbs.cp(7,1)=O(1)-r*vv2(1);
nurbs.cp(7,2)=O(2)-r*vv2(2);
nurbs.cp(7,3)=O(3)-r*vv2(3);
nurbs.cp(8,1)=O(1)+r*vv1(1)-r*vv2(1);
nurbs.cp(8,2)=O(2)+r*vv1(2)-r*vv2(2);
nurbs.cp(8,3)=O(3)+r*vv1(3)-r*vv2(3);
nurbs.cp(9,1)=nurbs.cp(1,1);
nurbs.cp(9,2)=nurbs.cp(1,2);
nurbs.cp(9,3)=nurbs.cp(1,3);
nurbs.deg=2;
nurbs.knot=[0.0 0.0 0.0 0.25 0.25 0.5 0.5 0.75 0.75 1.0 1.0 1.0];
sq=0.5*sqrt(2);
nurbs.w=[1.0 sq 1.0 sq 1.0 sq 1.0 sq 1.0]';

return
