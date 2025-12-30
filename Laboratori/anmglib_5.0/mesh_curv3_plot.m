function mesh_curv3_plot(x,y,z,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mesh_curv3_plot(x,y,z,varargin)
%Disegna una mesh di punti 3D
%x,y,z --> coordinate della mesh 3D
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

if isnumeric(ls) && length(ls) == 3
    % Colore RGB per la linea, setto 'Color' nel plot
    plot3(x, y, z, 'Color', ls, ...
        'LineWidth', lw, ...
        'MarkerEdgeColor', mec, ...
        'MarkerFaceColor', mfc, ...
        'MarkerSize', ms);
else
    % Caso standard con LineStyle
    plot3(x, y, z, ls, ...
        'LineWidth', lw, ...
        'MarkerEdgeColor', mec, ...
        'MarkerFaceColor', mfc, ...
        'MarkerSize', ms);
end

% plot3(x,y,z,ls,...
%     'LineWidth',lw,...
%     'MarkerEdgeColor',mec,...
%     'MarkerFaceColor',mfc,...
%     'MarkerSize',ms);
end

