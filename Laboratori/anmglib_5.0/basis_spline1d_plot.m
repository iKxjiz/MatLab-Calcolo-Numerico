function basis_spline1d_plot(g,t,flag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function basis_spline1d_plot(g,t,flag)
%Valuta e disegna la base B-spline univariata
%g    --> grado
%t    --> vettore dei knot
%flag --> 1 solo B-spline
%         2 B-spline e derivate prime
%         3 B-spline e derivate prime e seconde
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (nargin == 0)
g=3;
t=[0 0 0 0 0.26 0.26 0.26 0.5 0.75 1 1 1 1];
%t=[0 0 0 0 0.3 0.7 1 1 1 1];
%t=[0 1 2 3 4 5 6 7 8 9 10];
flag=3;
end

nt=length(t);
mpk=nt-g-1;
a=t(g+1);
b=t(nt-g);
%griglia di valutazione uniforme su [a,b]
nn=16;
[n,x]=gc_mesh(g,t,nn);
%Colori
nc=7;
col=['k','r','g','b','m','c','y'];

%Codice per grafico B-spline
if flag==1
 [bs]=gc_bspl_valder(g,t,x,0);
 y =squeeze(bs(1,1:end,1:end));
%  y=gc_bspl(g,t,x);
 %figure(1);
 figure
 hold on;
 for i=1:mpk
   plot(x,y(:,i),col(icol(i,nc)));
 end
end

%Codice per grafico B-spline e derivate prima
if flag==2
 [bs]=gc_bspl_valder(g,t,x,1);
 y =squeeze(bs(1,1:end,1:end));
 y1=squeeze(bs(2,1:end,1:end));
%  [y,y1]=gc_bpspl(g,t,x);
 %figure(1);
 figure
 hold on;
 for i=1:mpk
   plot(x,y(:,i),col(icol(i,nc)));
 end
 title('B spline basis')
 
 %figure(2);
 figure
 hold on;
 for i=1:mpk
   plot(x,y1(:,i),col(icol(i,nc)));
 end
end

%Codice per grafico B-spline, derivate prima e seconda
if flag==3
 [bs]=gc_bspl_valder(g,t,x,2);
 y =squeeze(bs(1,1:end,1:end));
 y1=squeeze(bs(2,1:end,1:end));
 y2=squeeze(bs(3,1:end,1:end));
%  [y,y1,y2]=gc_bpsspl(g,t,x);
 %figure(1);
 figure
 hold on;
 for i=1:mpk
   plot(x,y(:,i),col(icol(i,nc)));
 end
 %figure(2);
 figure
 hold on;
 for i=1:mpk
   plot(x,y1(:,i),col(icol(i,nc)));
 end
 %figure(3);
 figure
 hold on;
 for i=1:mpk
   plot(x,y2(:,i),col(icol(i,nc)));
 end
end

function c=icol(i,nc)
  c=mod(i-1,nc)+1;
