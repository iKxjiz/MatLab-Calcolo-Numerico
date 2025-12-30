function [x,y,varargout] = line_plot(p,v,a,b,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,varargout] = line_plot(p,v,a,b,varargin)
%Disegna una linea 2D o 3D nella forma p+tv con t in [a,b]
%p  --> punto 2D o 3D
%v  --> vettore 2D o 3D
%a,b --> intervallo parametrico
%varargin --> argomenti opzionali di disegno da assegnare nel seguente 
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%[x,y,varargout] <-- coordinate dei punti plottati. Si invochera' [x,y] 
%                    per disegno 2D oppure [x,y,z] per disegno 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nargout>3)
    error('La funzione puo'' ritornare al massimo 3 valori');
end

%check sul numero di opzionali inseriti
numvarargs = length(varargin);
if numvarargs > 5
    error('Inserire al massimo 5 parametri opzionali');
end

%default per i parametri 
optargs = {'-' 1 [0.5,0.5,0.5] 'k' 6};

%sovrascrivo in optargs gli opzionali specificati in varargin
optargs(1:numvarargs) = varargin;

[ls, lw, mec, mfc, ms] = optargs{:};

v=v./norm(v,2);
nv=length(v);
if (nv==2)
   x=[p(1)+a*v(1),p(1)+b*v(1)];
   y=[p(2)+a*v(2),p(2)+b*v(2)];
   plot(x,y,ls,...
    'LineWidth',lw,...    
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);
end
if (nv==3)
   x=[p(1)+a*v(1),p(1)+b*v(1)];
   y=[p(2)+a*v(2),p(2)+b*v(2)];
   z=[p(3)+a*v(3),p(3)+b*v(3)]; 
   varargout{1} = z;
   plot3(x,y,z,ls,...
    'LineWidth',lw,...
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);
end
end
