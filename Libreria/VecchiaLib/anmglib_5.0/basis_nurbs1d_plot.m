function basis_nurbs1d_plot(g,t,w)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function basis_nurbs1d_plot(g,t,w)
%Valuta e disegna la base rational B-spline univariata
%g    --> grado
%t    --> vettore dei knot
%w    --> lista dei pesi di ncp elementi
%         ricorda: ncp=numero nodi - g - 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (nargin == 0)
%   g=3;
%   t=[0 0 0 0 0.26 0.26 0.26 0.5 0.75 1 1 1 1];
%   w=[1 1 1 1 0.0125 1 1 1 1];
%   g=3;
%   t=[0 0 0 0 1 1 1 1];
%   w=[1 5 5 1];
  g=2;
  t=[0 0 0 0.25 0.5 0.75 1 1 1];
  w=[1 1 5 0.5 1 1];
end

nt=length(t);
mpk=nt-g-1;
a=t(g+1);
b=t(nt-g);
%griglia di valutazione uniforme su [a,b]
ni=51;
[nx,x]=gc_mesh(g,t,ni);
%x=linspace(a,b,36);
%Colori
nc=7;
col=['k','r','g','b','m','c','y'];

%Codice per grafico B-spline
 y=gcw_bspl(g,t,w,x);
 figure(1);
 hold on;
 for i=1:mpk
   plot(x,y(:,i),col(icol(i,nc)));
 end
 
 function c=icol(i,nc)
  c=mod(i-1,nc)+1;
