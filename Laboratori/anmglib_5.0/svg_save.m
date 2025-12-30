function svg_save(array_mdppbezier, filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function svg_save(array_mdppbezier, filename)
%Salva un disegno SVG su file
%array_mdppbezier --> array di strutture di curve di bezier a tratti multi degree:
%      array_mdppbezier(i).deg --> grado della curva
%      array_mdppbezier(i).cp  --> lista dei punti di controllo (bezier.deg+1) x2
%      array_mdppbezier(i).ab  --> intervallo di definizione
%      array_mdppbezier(i).senso --> senso di percorrenza della curva
%      array_mdppbezier(i).isContained --> 1/0 se contenuta in altra curva o meno
%      array_mdppbezier(i).transform --> matrice 3x3 di trasformazione
%      array_mdppbezier(i).lc  --> colore del tratto/stroke del bordo
%      array_mdppbezier(i).lw  --> spessore del bordo
%      array_mdppbezier(i).fc  --> colore di riempimento/fill
%fileName <-- nome del file di estensione .svg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
docNode = com.mathworks.xml.XMLUtils.createDocument('svg');
svg = docNode.getDocumentElement;
svg.setAttribute('xmlns:svg', 'http://www.w3.org/2000/svg');
svg.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
svg.setAttribute('version', '1.0');

oldMinX = 0;
oldMaxX = 0;
oldMinY = 0;
oldMaxY = 0;

full_d = "";

for i = 1 : numel(array_mdppbezier)
    lc = array_mdppbezier(i).lc;
    lw = array_mdppbezier(i).lw;
    fc = array_mdppbezier(i).fc;
    path = docNode.createElement('path');
    [d, minX, minY, maxX, maxY] = mdppbezier2path(array_mdppbezier(i));
    
    svg.appendChild(path);
    % concatena al vecchio d, il nuovo d
    full_d = strcat(full_d, " ", d);
    
    oldMinX = min(minX, oldMinX);
    oldMinY = min(minY, oldMinY);
    oldMaxX = max(maxX, oldMaxX);
    oldMaxY = max(maxY, oldMaxY);
    

    path.setAttribute('d', d);
    % Controllo e impostazione dell'attributo 'stroke'
    if ( ~isempty(lc) && ~strcmp(lc, '') )
        if(strcmp(lc, 'none'))
            path.setAttribute('stroke', Color.rgb2hex_norm(Color.Code(Color.Code(lc))));
        else 
            path.setAttribute('stroke', Color.rgb2hex_norm(Color.Code(lc)));
        end
    end
     % Controllo e impostazione dell'attributo 'stroke-width'
    if ( ~isempty(lw) && lw > 0 )
        path.setAttribute('stroke-width', num2str(lw));
    end
    % Controllo e impostazione dell'attributo 'fill'
    if ( ~isempty(fc) && ~strcmp(fc, '') )
        path.setAttribute('fill', Color.rgb2hex_norm(Color.Code(fc)));
    end
    % Controllo e impostazione dell'attributo 'transform'
    if (i <= numel(array_mdppbezier) && isfield(array_mdppbezier, 'transform') && ...
            ~isempty(array_mdppbezier(i).transform) && ...
            (ischar(array_mdppbezier(i).transform) || isstring(array_mdppbezier(i).transform)))
        path.setAttribute('transform', array_mdppbezier(i).transform);
    end

    svg.setAttribute("viewBox",         ...
      strcat(num2str(oldMinX), " ",   ...
        num2str(oldMinY), " ",      ...
        num2str(abs(oldMinX) + oldMaxX), " ",      ...
        num2str(abs(oldMinY) + oldMaxY)            ...
      )                               ...
    );

end

% xmlwrite(fullfile('ConvertedSVGs', 'Files', filename), svg);
xmlwrite(fullfile('./', 'svgFiles', filename), svg);

% fprintf("Fine. Controllare la cartella ConvertedSVGs/Files.\n");

end