function mesh_curv2_plot(x,y,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mesh_curv2_plot(x,y,varargin)
%Disegna una mesh di punti 2D
%x,y --> coordinate della mesh 2D
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test sul numero di opt inseriti
numvarargs = length(varargin);
if numvarargs > 5
    error('Inserire al massimo 5 parametri opzionali');
end

%Default per i parametri opzionali
optargs = {'-' 1 'k' [0.5,0.5,0.5] 6};

%Sovrascrivo in optargs gli opzionali specificati in varargin
optargs(1:numvarargs) = varargin;

[ls, lw, mec, mfc, ms] = optargs{:};

if isnumeric(ls) && length(ls) == 3
    % Colore RGB per la linea, setto 'Color' nel plot
    plot(x, y, 'Color', ls, ...
        'LineWidth', lw, ...
        'MarkerEdgeColor', mec, ...
        'MarkerFaceColor', mfc, ...
        'MarkerSize', ms);
else
    % Caso standard con LineStyle
    plot(x, y, ls, ...
        'LineWidth', lw, ...
        'MarkerEdgeColor', mec, ...
        'MarkerFaceColor', mfc, ...
        'MarkerSize', ms);
end

end



