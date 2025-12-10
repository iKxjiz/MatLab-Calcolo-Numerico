function [npx,npy,npz] = curv3_from_surf_comb_plot(surfname,a,b,np,fuv,uv,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [npx,npy,npz] = curv3_from_surf_comb_plot(surfname,a,b,np,fuv,uv,varargin)
%Disegna il comb di una isocurva 3D di una superficie 3D
%surfname --> nome del file della superficie parametrica
%a,b   --> intervallo di definizione
%np    --> numero di punti di valutazione
%          se negativo si valuta, ma non si disegna
%fuv   --> direzione u o v; 1: estrae curva in u; 2: in v
%uv    --> parametro u o v (a seconda di fuv) 
%          fuv=1 allora uv deve contenere un valore v=costante
%          fuv=2 allora uv deve contenere un valore u=costante
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%npx,npy,npz <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms u v

npp=abs(np);
surfn=str2func(surfname);
t = linspace(a,b,npp);

if (fuv==1)
  [fx,fy,fz]=surfn(u,v);
  fxx=diff(fx,u);
  fyy=diff(fy,u);
  fzz=diff(fz,u);
  fxxx=diff(fxx,u);
  fyyy=diff(fyy,u);
  fzzz=diff(fzz,u);
  v=uv;
  for i=1:npp
    u=t(i);
    x(i)=eval(fx);
    y(i)=eval(fy);
    z(i)=eval(fz);
    xp(i)=eval(fxx);
    yp(i)=eval(fyy);
    zp(i)=eval(fzz);
    xs(i)=eval(fxxx);
    ys(i)=eval(fyyy);
    zs(i)=eval(fzzz);
%    disp([x(i),y(i),z(i),xp(i),yp(i),zp(i),xs(i),ys(i),zs(i)]);
  end
end
if (fuv==2)
  [fx,fy,fz]=surfn(u,v);
  fxx=diff(fx,v);
  fyy=diff(fy,v);
  fzz=diff(fz,v);
  fxxx=diff(fxx,v);
  fyyy=diff(fyy,v);
  fzzz=diff(fzz,v);
  u=uv;
  for i=1:npp
    v=t(i);
    x(i)=eval(fx);
    y(i)=eval(fy);
    z(i)=eval(fz);
    xp(i)=eval(fxx);
    yp(i)=eval(fyy);
    zp(i)=eval(fzz);
    xs(i)=eval(fxxx);
    ys(i)=eval(fyyy);
    zs(i)=eval(fzzz);
%    disp([x(i),y(i),z(i),xp(i),yp(i),zp(i),xs(i),ys(i),zs(i)]);
  end
end

for i=1:npp
    td(i)=norm([xp(i),yp(i),zp(i)],2);
    tx(i)=xp(i)/td(i);
    ty(i)=yp(i)/td(i);
    tz(i)=zp(i)/td(i);
end

%vettore binormale alla curva in ogni punto e calcolo valore cyrvatura
for i=1:npp
    vect=cross([xp(i),yp(i),zp(i)],[xs(i),ys(i),zs(i)]);
    bd=norm(vect,2);
    k(i)=bd/sqrt(xp(i).^2+yp(i).^2+zp(i).^2).^3;
    bx(i)=vect(1)/bd;
    by(i)=vect(2)/bd;
    bz(i)=vect(3)/bd;
end

%vettore normale alla curva in ogni punto
for i=1:npp
    vect=cross([bx(i),by(i),bz(i)],[tx(i),ty(i),tz(i)]);
    nd=norm(vect,2);
    nx(i)=vect(1)/nd;
    ny(i)=vect(2)/nd;
    nz(i)=vect(3)/nd;
end

for i=1:npp
  npx(i)=x(i)-k(i)*nx(i);
  npy(i)=y(i)-k(i)*ny(i);
  npz(i)=z(i)-k(i)*nz(i);
end

if (np > 0)
    for i=1:np
       plot3([x(i),npx(i)],[y(i),npy(i)],[z(i),npz(i)],'c-');
    end
    %chiamata di disegno
    mesh_curv3_plot(npx,npy,npz,varargin{:});
end

end

