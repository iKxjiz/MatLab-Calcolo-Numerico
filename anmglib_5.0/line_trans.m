function [q,u]=line_trans(p,v,M)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [q,u]=line_trans(p,v,M)
%Trasforma una linea 2D o 3D nella forma p+tv con t in [a,b]
%applicando la matrice M
%p  --> punto 2D o 3D
%v  --> vettore 2D o 3D
%M   --> matrice di trasformazione
%ATTENZIONE: se i punti sono 2D la matrice deve essere 3x3,
%            se i punti 3D la matrice deve essere 4x4.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v=v./norm(v,2);
nv=length(v);
if (nv==2)
   pv=p+v;
   pv(3)=1;
   q=M*pv';
   r=q';
   p(3)=1;
   q=M*p';
   q=q';
   u=r-p;
end
if (nv==3)
   pv=p+v;
   pv(4)=1;
   q=M*pv';
   r=q';
   p(4)=1;
   q=M*p';
   q=q';
   u=r-p;
end
end
