function [npx,npy,npz] = curv3_comb_plot(cs3name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [npx,npy,npz] = curv3_comb_plot(cs3name,a,b,np,varargin)
%Disegna il comb di una curva 3D in forma parametrica
%cs3name --> nome del file con l'espressione parametrica
%            della curva fino alla derivata seconda
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%npx,npy,npz <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cs3name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),z(i),xp(i),yp(i),zp(i),xs(i),ys(i),zs(i)]=curv(t(i));
end

for i=1:abs(np)
    td(i)=norm([xp(i),yp(i),zp(i)],2);
    tx(i)=xp(i)/td(i);
    ty(i)=yp(i)/td(i);
    tz(i)=zp(i)/td(i);
end

%vettore binormale alla curva in ogni punto e calcolo valore curvatura
for i=1:abs(np)
    vect=cross([xp(i),yp(i),zp(i)],[xs(i),ys(i),zs(i)]);
    bd=norm(vect,2);
    k(i)=bd/sqrt(xp(i).^2+yp(i).^2+zp(i).^2).^3;
    bx(i)=vect(1)/bd;
    by(i)=vect(2)/bd;
    bz(i)=vect(3)/bd;
end

%vettore normale alla curva in ogni punto
for i=1:abs(np)
    vect=cross([bx(i),by(i),bz(i)],[tx(i),ty(i),tz(i)]);
    nd=norm(vect,2);
    nx(i)=vect(1)/nd;
    ny(i)=vect(2)/nd;
    nz(i)=vect(3)/nd;
end

for i=1:abs(np)
  npx(i)=x(i)-k(i)*nx(i);
  npy(i)=y(i)-k(i)*ny(i);
  npz(i)=z(i)-k(i)*nz(i);
end

if (np > 0)
    for i=1:np
        %colore e stile linea fissi a solid e ciano
        plot3([x(i),npx(i)],[y(i),npy(i)],[z(i),npz(i)],'c-');
    end
    %chiamata di disegno
    mesh_curv3_plot(npx,npy,npz,varargin{:});
end

end

