function array_mdppbezier= svg_load(fileName)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [array_mdppbezier] = svg_load(fileName)
%Legge un disegno SVG da file
%fileName --> nome del file di estensione .svg
%array_mdppbezier <-- array di strutture di curve di bezier a tratti multi degree:
%      array_mdppbezier(i).deg <-- grado della curva
%      array_mdppbezier(i).cp  <-- lista dei punti di controllo (bezier.deg+1) x2
%      array_mdppbezier(i).ab  <-- intervallo di definizione
%      array_mdppbezier(i).senso <-- senso di percorrenza della curva
%      array_mdppbezier(i).isContained <-- 1/0 se contenuta in altra curva o meno
%      array_mdppbezier(i).transform <-- matrice 3x3 di trasformazione
%      array_mdppbezier(i).lc  <-- colore del tratto/stroke del bordo
%      array_mdppbezier(i).lw  <-- spessore del bordo
%      array_mdppbezier(i).fc  <-- colore di riempimento/fill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 0
    error("fileName obbligatorio\n");
end

% fprintf("Init svg2plot.\n");

%% Apre la figura 1
% fprintf("Apertura figura 1.\n");
% open_figure(1);

%% Inverti le assi
% fprintf("Invertiamo gli assi per vedere l'immagine SVG.\n");
% set(gca, 'Ydir', 'reverse');

% Leggi il file SVG
% fullFile = fullfile('Files', fileName);
fullFile = fullfile('svgFiles', fileName);
% fprintf("Lettura file: %s \n", fullFile);
XMLNode = xmlread(fullFile);
% fprintf("Analisi dei nodi SVG.\n");

% Ottieni i nodi <svg>
DOMNode = XMLNode.getElementsByTagName('svg');

% Contenitore per i path e per lo stile
allPath = {};
styleRules = struct();

M = eye(3);
n_g = 0;

% Ciclo su ciascun nodo <svg> trovato
for i = 0:DOMNode.getLength() - 1
    svgNode = DOMNode.item(i);

    % Ottieni i nodi figli di <svg>
    childNodes = svgNode.getChildNodes();

    for j = 0:childNodes.getLength() - 1
        node = childNodes.item(j);
        if strcmp(node.getNodeName(), 'path')
            % Aggiungi il nodo path direttamente alla lista
%             fprintf('Trovato un nodo <path>\n');
            allPath{end + 1} = struct('node', node, 'attributes', struct(), 'transform', M);
        elseif strcmp(node.getNodeName(), 'g')
            % Esplora ricorsivamente il nodo <g>
%             fprintf('Trovato un nodo <g>\n');
            n_g=n_g+1;
            allPath = TagSVG.exploreGroup(node, struct(), M, allPath);
        elseif strcmp(node.getNodeName(), 'style')
            % Leggi le regole di stile
%             fprintf('Trovato un nodo <style>\n');
            styleContent = char(node.getTextContent());
            styleRules = TagSVG.parseStyle(styleContent);
        end
    end
end

% fprintf("Numero totale di path trovati: %d\n", numel(allPath));

%% Loop per ogni path
array_mdppbezier = [];
fc = string.empty;
previousFillColor = 'w';

for pathIndex = 1:numel(allPath)
    path = allPath{pathIndex}.node;
    M_group = allPath{pathIndex}.transform;
    fillColor = '';
    if path.hasAttribute('class')
        className = char(path.getAttribute('class'));
        if isfield(styleRules, className)
            if isfield(styleRules.(className), 'fill')
                fillColor = styleRules.(className).fill;
                path.setAttribute('fill', fillColor);
            end
        end
    end

    [a, b, c, d] = path2mdppbezier(path);

    for i = 1:numel(a)
        % Combina la trasformazione del gruppo con quella locale del path
        M_total = M_group * a(i).transform;
        a(i).transform = M_total;
    end

    if ~isempty(fillColor)
        fillColor = Color.Arr2Str(hex2rgb(fillColor));
        previousFillColor = fillColor;
    else
        previousFillColor = fc; % Memorizza il colore usato
    end
    if(numel(allPath) > 1)
        for i = 1:numel(a)
            a(i).lc=b;
            a(i).lw=c;
            index = numel(allPath) - 1;
            if (any(a(i).sense == 0) && strcmp(a(i).isContained, "true"))
                if (pathIndex > 1 && index <= numel(previousFillColor))
                    fc = [fc; previousFillColor(numel(allPath)-1)];
                    a(i).fc=previousFillColor(numel(allPath)-1);
                else
                    fc = [fc; "w"];
                    a(i).fc="w";
                end
            elseif(any(a(i).sense == -1) && strcmp(a(i).isContained, "true"))
                if (pathIndex > 1 && n_g > 1)
                    fc = [fc; previousFillColor(numel(allPath)-1)];
                    a(i).fc=previousFillColor(numel(allPath)-1);
                else
                    fc = [fc; "w"];
                    a(i).fc="w";
                end
            else
                fc = [fc; d];
                a(i).fc=d;
            end
        end
    else
        for i = 1:numel(a)
            a(i).lc=b;
            a(i).lw=c;
            if(a(i).sense == 0) && strcmp(a(i).isContained, "true") || ((a(i).sense == -1) && strcmp(a(i).isContained, "true")) || ...
                    ((a(i).sense == 1) && strcmp(a(i).isContained, "true"))
                fc = [fc; 'w'];
                a(i).fc="w";
            else
                fc = [fc; d];
                a(i).fc=d;
            end
        end
    end
    array_mdppbezier = [array_mdppbezier a];
end

% for i = 1:numel(array_mdppbezier)
%     M = array_mdppbezier(i).transform;
%     if ~isempty(M)
%         array_mdppbezier(i).cp = point_trans(array_mdppbezier(i).cp, M);
%     end
%     pp = curv2_mdppbezier_plot(array_mdppbezier(i), 100, Color.Code(lc(i)), lw(i));
%     if (length(array_mdppbezier(i).deg) > 1 | array_mdppbezier(i).deg > 1)
%         if strcmp(lc(i), 'none')
%             fill(pp(:, 1), pp(:, 2), Color.Code(fc(i)), EdgeColor="none");
%         else
%             fill(pp(:, 1), pp(:, 2), Color.Code(fc(i)));
%         end
%     end
% end

% disp(numel(array_mdppbezier));

% fprintf("Fine svg2plot \n\r");

end

