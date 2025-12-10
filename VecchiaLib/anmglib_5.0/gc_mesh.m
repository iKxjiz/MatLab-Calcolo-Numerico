function [nm,mesh]=gc_mesh(g,t,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [nm,mesh]=gc_mesh(g,t,n)
%Viene generate una mesh opportuna dell'intervallo di definizione 
%rispettando i knot e le loro molteplicita'
%g --> grado della spline/nurbs
%t --> vettore dei knot
%n --> numero di punti della mesh per intervallo nodale
%nm    <-- numero punti mesh generati
%mesh  <-- mesh generata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (n<2)
  n=2;
end
nt=length(t);
j=1;
ii=0;
for i=g+1:nt-g-1
  if (t(i+1)>t(i))
   ii=ii+1;
   nm=j+n-1;
   mesh(j:nm)=linspace(t(i),t(i+1),n);
%il nodo viene considerato una sola volta
%   j=nm;
%il nodo viene considerato due volte
   j=nm+1;
  end
end
