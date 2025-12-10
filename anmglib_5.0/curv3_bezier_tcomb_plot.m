function [npx,npy,npz] = curv3_bezier_tcomb_plot(bezier,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [npx,npy,npz] = curv3_bezier_tcomb_plot(bezier,np,varargin)
%Disegna il torsion comb di una curva 3D di Bezier
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x3
%          bezier.ab  --> intervallo di definizione
%np  --> numero di punti di valutazione
%        se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%npx,npy,npz <-- coordinate valori plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=bezier.deg+1;

mesh = linspace(bezier.ab(1),bezier.ab(2),abs(np));

%Algoritmo1
%bas_bernst = bernst_valder(bezier.deg,bezier.knot);
%x=bas_bernst*qx;
%y=bas_bernst*qy;
%z=bas_bernst*qz;

%Algoritmo2
Px=decast_valder(bezier,3,mesh);
for i=1:abs(np)
  x(i)=Px(1,i,1);
  y(i)=Px(1,i,2);
  z(i)=Px(1,i,3);
  xp(i)=Px(2,i,1);
  yp(i)=Px(2,i,2);
  zp(i)=Px(2,i,3);
  xs(i)=Px(3,i,1);
  ys(i)=Px(3,i,2);
  zs(i)=Px(3,i,3);
  xt(i)=Px(4,i,1);
  yt(i)=Px(4,i,2);
  zt(i)=Px(4,i,3);
end

%vettore binormale alla curva in ogni punto e calcolo valore curvatura
for i=1:abs(np)
    vect=cross([xp(i),yp(i),zp(i)],[xs(i),ys(i),zs(i)]);
    bd=norm(vect,2);
    A=[xp(i),yp(i),zp(i);xs(i),ys(i),zs(i);xt(i),yt(i),zt(i)];
    tau(i)=det(A)/bd^2;
    bx(i)=vect(1)/bd;
    by(i)=vect(2)/bd;
    bz(i)=vect(3)/bd;
end

for i=1:abs(np)
  npx(i)=x(i)-tau(i)*bx(i);
  npy(i)=y(i)-tau(i)*by(i);
  npz(i)=z(i)-tau(i)*bz(i);
end

if (np > 0)
    for i=1:np 
       %colore e stile linea fissi a solid e ciano
       plot3([x(i),npx(i)],[y(i),npy(i)],[z(i),npz(i)],'m-');
    end
    %chiamata di disegno
    mesh_curv3_plot(npx,npy,npz,varargin{:});
end

end

