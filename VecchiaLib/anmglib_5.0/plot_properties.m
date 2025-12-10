function plot_properties(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function plot_properties(varargin)
%Setta i parametri opzionali del disegno
%varagin puo' contenere da 0 a tutti e 5 tra questi parametri nel
%seguente ordine:
%ls  --> line specification
%lw  --> line width
%mfc --> marker face color
%mec --> marker edge color
%ms  --> marker size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numvarargs = length(varargin);
if numvarargs > 5
    error('inserire al massimo 5 parametri opzionali');
end

% valori di default
optargs = {'-' 1 [0.5,0.5,0.5] 'k' 6};

% put these defaults into the valuesToUse cell array, 
% and overwrite the ones specified in varargin.
% se specificati, inserisco i valori definiti in varargin al posto di quelli di default
optargs(1:numvarargs) = varargin;

% Place optional args in memorable variable names
[ls, lw, mfc, mec, ms] = optargs{:};

plot(x,y,...
    'LineSpecification',ls,...
    'LineWidth',lw,...
    'MarkerFaceColor',mfc,...
    'MarkerEdgeColor',mec,...
    'MarkerSize',ms);
end