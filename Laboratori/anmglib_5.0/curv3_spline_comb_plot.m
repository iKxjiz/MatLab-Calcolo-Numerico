function [npx,npy,npz] = curv3_spline_comb_plot(spline,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [npx,npy,npz] = curv3_spline_comb_plot(spline,np,varargin)
%Disegna il comb di una curva 3D spline
%spline --> struttura formata di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x3 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%np  --> numero di punti di valutazione per tratto
%        se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%npx,npy,npz <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% n=spline.deg+1;
npp=abs(np);
[nm,mesh]=gc_mesh(spline.deg,spline.knot,npp);
tol=1.0e-6;
for i=1:nm/npp-1
    mesh(i*npp)=mesh(i*npp)-tol;
    mesh(i*npp+1)=mesh(i*npp+1)+tol;
end

%Algoritmo1
%bas_bspl = gc_bpsspl(...);
%x=bas_bspl*qx;
%y=bas_bspl*qy;
%z=bas_bspl*qz;

%Algoritmo2
Px=deboor_valder(spline,2,mesh);

for i=1:nm
  x(i)=Px(1,i,1);
  y(i)=Px(1,i,2);
  z(i)=Px(1,i,3);
  xp(i)=Px(2,i,1);
  yp(i)=Px(2,i,2);
  zp(i)=Px(2,i,3);
  xs(i)=Px(3,i,1);
  ys(i)=Px(3,i,2);
  zs(i)=Px(3,i,3);
end

for i=1:nm
    td(i)=norm([xp(i),yp(i),zp(i)],2);
    tx(i)=xp(i)/td(i);
    ty(i)=yp(i)/td(i);
    tz(i)=zp(i)/td(i);
end


%vettore binormale alla curva in ogni punto e calcolo valore curvatura
for i=1:nm
    vect=cross([xp(i),yp(i),zp(i)],[xs(i),ys(i),zs(i)]);
    bd=norm(vect,2);
    k(i)=bd/sqrt(xp(i).^2+yp(i).^2+zp(i).^2).^3;
    bx(i)=vect(1)/bd;
    by(i)=vect(2)/bd;
    bz(i)=vect(3)/bd;
end

%vettore normale alla curva in ogni punto
for i=1:nm
    vect=cross([bx(i),by(i),bz(i)],[tx(i),ty(i),tz(i)]);
    nd=norm(vect,2);
    nx(i)=vect(1)/nd;
    ny(i)=vect(2)/nd;
    nz(i)=vect(3)/nd;
end

for i=1:nm
  npx(i)=x(i)-k(i)*nx(i);
  npy(i)=y(i)-k(i)*ny(i);
  npz(i)=z(i)-k(i)*nz(i);
end

if (np > 0)
    % for i=1:np
    %     plot3([x(i),x(i)+tx(i)],[y(i),y(i)+ty(i)],[z(i),z(i)+tz(i)],'g-')
    % end
    for i=1:nm
        
        %colore e stile linea fissi a solid e ciano
       plot3([x(i),npx(i)],[y(i),npy(i)],[z(i),npz(i)],'c-');
    end
    %chiamata di disegno
    i1=1;
    for i=1:nm/np
     i2=i1+np-1;
     mesh_curv3_plot(npx(i1:i2),npy(i1:i2),npz(i1:i2),varargin{:});
     i1=i2+1;
    end
end

end

