function point_fill(p,col,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function point_fill(p,col,varargin)
%Disegna punti, liste di punti o griglie di punti 2D
%p  --> punto/i 2D (nx2)
%col  --> colore di riempimento come singolo char o tripla 
%varargin --> argomenti opzionali di disegno del bordo da assegnare
%             nel seguente ordine: LineColor, LineWidth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%check sul numero di opzionali inseriti
numvarargs = length(varargin);
if numvarargs > 2
    error('Inserire al massimo 2 parametri opzionali');
end

if numvarargs > 0
%default per i parametri opzionali
  optargs = {'k' 1};

%sovrascrivo in optargs gli opzionali specificati in varargin
  optargs(1:numvarargs) = varargin;

  [lc, lw] = optargs{:};
end

[m,n,l]=size(p);
if (l==1)
  if (n==2)
    x=p(:,1);
    y=p(:,2);
    if (numvarargs > 0)
% Colore RGB per il bordo, setto 'EdgeColor' nel fill
        fill(x, y, col, 'LineStyle','-','EdgeColor', lc, 'LineWidth', lw);
    else
        fill(x,y,col,'LineStyle','none');
    end
  end
else
  error('I punti devono essere 2D');
end

end
