function [x,y,z]=curv3_from_surf_plot(surfname,a,b,np,fuv,uv,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=curv3_from_surf_plot(surfname,a,b,np,fuv,uv,varargin)
%Disegna una isocurva di una superficie 3D
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
%x,y,z <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
surfn=str2func(surfname);
t = linspace(a,b,abs(np));
if (fuv==1)
  for i=1:abs(np)
    [x(i),y(i),z(i)]=surfn(t(i),uv);
  end
end
if (fuv==2)
  for i=1:abs(np)
    [x(i),y(i),z(i)]=surfn(uv,t(i));
  end
end

if (np > 0)
    %chiamata di disegno
    mesh_curv3_plot(x,y,z,varargin{:});
end

end

