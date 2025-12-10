function [npx,npy,npz] = curv3_tcomb_plot(ct3name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [npx,npy,npz] = curv3_tcomb_plot(ct3name,a,b,np,varargin)
%Disegna comb della torsione di una curva 3D in forma parametrica
%ct3name --> nome del file con l'espressione parametrica
%            della curva fino alla derivata terza
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%npx,npy,npz <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(ct3name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),z(i),xp(i),yp(i),zp(i),xs(i),ys(i),zs(i),xt(i),yt(i),zt(i)]=curv(t(i));
end

%for i=1:abs(np)
%    td(i)=norm([xp(i),yp(i),zp(i)],2);
%    tx(i)=xp(i)/td(i);
%    ty(i)=yp(i)/td(i);
%    tz(i)=zp(i)/td(i);
%end

%vettore binormale alla curva in ogni punto e calcolo valore torsione
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

