function [npx,npy] = curv2_nurbs_comb_plot(nurbs,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv2_nurbs_comb_plot(nurbs,np,varargin)
%Disegna il comb di una curva 2D nurbs
%nurbs --> struttura di una curva nurbs:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo 
%          nurbs.w   --> lista dei pesi
%          nurbs.knot  --> vettore dei nodi
%np  --> numero di punti di valutazione per tratto
%        se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%npx,npy <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=nurbs.deg+1;
qx=nurbs.cp(1:n,1);
qy=nurbs.cp(1:n,2);
npp=abs(np);

[nm,mesh]=gc_mesh(nurbs.deg,nurbs.knot,npp);
tol=1.0e-6;
for i=1:nm/npp-1
    mesh(i*npp)=mesh(i*npp)-tol;
    mesh(i*npp+1)=mesh(i*npp+1)+tol;
end

%Algoritmo1
%bas_bspl = gc_bpsspl(...);
%x=bas_bspl*qx;
%y=bas_bspl*qy;

%Algoritmo2
Px=nurbs_valder(nurbs,2,mesh);

for i=1:nm
  x(i)=Px(1,i,1);
  y(i)=Px(1,i,2);
  xp(i)=Px(2,i,1);
  yp(i)=Px(2,i,2);
  xs(i)=Px(3,i,1);
  ys(i)=Px(3,i,2);
end

% for i=1:npp
%     td(i)=norm([xp(i),yp(i)],2);
%     tx(i)=xp(i)/td(i);
%     ty(i)=yp(i)/td(i);
% end
% for i=1:npp
%     plot([x(i),x(i)+tx(i)],[y(i),y(i)+ty(i)],'g-')
% end

for i=1:nm
  k(i)=(xp(i)*ys(i)-yp(i)*xs(i))/sqrt(xp(i).^2+yp(i).^2).^3;
  nv=[-yp(i),xp(i)];
  normv=norm(nv,2);
  nv=nv./normv;
  npx(i)=x(i)-k(i)*nv(1);
  npy(i)=y(i)-k(i)*nv(2);
end

if (np > 0)
    for k=1:nm
      %colore e stile linea fissi a solid e ciano
      plot([x(i),npx(i)],[y(i),npy(i)],'c-');
    end
    %chiamata di disegno
    i1=1;
    for i=1:nm/np
     i2=i1+np-1;
     mesh_curv2_plot(npx(i1:i2),npy(i1:i2),varargin{:});
     i1=i2+1;
    end
end

end

