function [xp,yp,zp] = curv3_from_surf_tan_plot(surfname,a,b,np,fuv,uv,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xp,yp,zp] = curv3_from_surf_tan_plot(surfname,a,b,np,fuv,uv,varargin)
%Disegna i vettori tangenti di una isocurva 3D di una superficie 3D
%surfname --> nome del file della superficie parametrica
%a,b   --> intervallo di definizione
%np    --> numero di punti da plottare
%          se negativo si valuta, ma non si disegna
%fuv   --> direzione u o v; 1: estrae curva in u; 2: in v
%uv    --> parametro u o v (a seconda di fuv) 
%          fuv=1 allora uv deve contenere un valore v=costante
%          fuv=2 allora uv deve contenere un valore u=costante
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%xp,yp,zp <-- coordinate dei vettori tangenti
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
  v=uv;
  for i=1:npp
    u=t(i);
    x(i)=eval(fx);
    y(i)=eval(fy);
    z(i)=eval(fz);
    xp(i)=eval(fxx);
    yp(i)=eval(fyy);
    zp(i)=eval(fzz);
%    disp([x(i),y(i),z(i),xp(i),yp(i),zp(i)]);
  end
end
if (fuv==2)
  [fx,fy,fz]=surfn(u,v);
  fxx=diff(fx,v);
  fyy=diff(fy,v);
  fzz=diff(fz,v);
  u=uv;
  for i=1:npp
    v=t(i);
    x(i)=eval(fx);
    y(i)=eval(fy);
    z(i)=eval(fz);
    xp(i)=eval(fxx);
    yp(i)=eval(fyy);
    zp(i)=eval(fzz);
%    disp([x(i),y(i),z(i),xp(i),yp(i),zp(i)]);
  end
end

if (np > 0)
    %chiamata di disegno
    for i=1:np
        vect3_plot([x(i),y(i),z(i)],[xp(i),yp(i),zp(i)],varargin{:});
    end
end

end

