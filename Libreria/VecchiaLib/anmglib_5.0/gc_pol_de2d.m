function [cpxd,cpyd]=gc_pol_de2d(g,cpx,cpy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [cpxd,cpyd]=gc_pol_de2d(g,cpx,cpy)
%Degree elevation di una curva 2D di Bezier restituendo i nuovi 
%punti di controllo; il grado del nuovo polinomio sara' g+1
%g         --> grado del polinomio
%cpx,cpy   --> coordinate dei punti di controllo
%cpxd,cpyd <-- coordinate dei nuovi punti di controllo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gp1=g+1;
cpxd(1)=cpx(1);
cpyd(1)=cpy(1);
cpxd(gp1+1)=cpx(gp1);
cpyd(gp1+1)=cpy(gp1);
for j=1:g
  alfa=gp1-j;
  cpxd(j+1)=(alfa*cpx(j+1)+j*cpx(j))/gp1; 
  cpyd(j+1)=(alfa*cpy(j+1)+j*cpy(j))/gp1;
end
