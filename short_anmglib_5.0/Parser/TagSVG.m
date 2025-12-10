classdef TagSVG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Interpreta i tag <g> e <style> di un file SVG
% 
% exploreGroup: Funzione per esplorare ricorsivamente i nodi <g>
% parseStyle: Funzione per esplorare il nodo <style>
%     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods(Static)

        function allPath = exploreGroup(node, currentAttributes, M, allPath)
            if node.hasAttribute('fill')
                currentAttributes.fill = char(node.getAttribute('fill'));
            end
            if node.hasAttribute('stroke')
                currentAttributes.stroke = char(node.getAttribute('stroke'));
            end
            if node.hasAttribute('stroke-width')
                currentAttributes.strokeWidth = char(node.getAttribute('stroke-width'));
            end
            if node.hasAttribute('transform')
                transformAttr = char(node.getAttribute('transform'));
                if ~isempty(transformAttr)
                    M = parseTransform(transformAttr) * M;
                end
            end

            childNodes = node.getChildNodes();
            for i = 0:childNodes.getLength() - 1
                child = childNodes.item(i);
                if strcmp(child.getNodeName(), 'path')
%                     fprintf('Trovato un <path> dentro un nodo <g>\n');
                    if(isfield(currentAttributes, 'stroke') && ~isempty(currentAttributes.stroke) && ~child.hasAttribute('stroke'))
                        child.setAttribute('stroke', currentAttributes.stroke)
                    end
                    if(isfield(currentAttributes, 'fill') && ~isempty(currentAttributes.fill) && ~child.hasAttribute('fill'))
                        child.setAttribute('fill', currentAttributes.fill)
                    end
                    if(isfield(currentAttributes, 'stroke-width') && ~isempty(currentAttributes.('stroke-width')) && ~child.hasAttribute('stroke-width') )
                        child.setAttribute('stroke-width', currentAttributes.stroke-width)
                    end
                    % if(isfield(currentAttributes, 'transform') && ~isempty(currentAttributes.transform))
                    %     child.setAttribute('trasform', currentAttributes.trasform)
                    % end
                    allPath{end + 1} = struct('node', child, 'transform', M);
                elseif strcmp(child.getNodeName(), 'g')
                    % Chiamata ricorsiva per esplorare il nodo <g> figlio
%                     fprintf('Trovato un <g> annidato\n');
                    allPath = TagSVG.exploreGroup(child, currentAttributes, M, allPath);
                end
            end
        end

        
        function styleRules = parseStyle(styleContent)
            % Inizializza una struttura per memorizzare le regole
            styleRules = struct();

            % Divide il contenuto in base ai separatori delle regole
            rules = regexp(styleContent, '\.(\w+)\{([^\}]+)\}', 'tokens');
            for i = 1:numel(rules)
                className = rules{i}{1};
                properties = rules{i}{2};

                % Divide le proprietà della regola
                props = regexp(properties, '([\w-]+):([^;]+);', 'tokens');
                styleRules.(className) = struct();
                for j = 1:numel(props)
                    property = strtrim(props{j}{1});
                    if(property=="fill")
                        value = strtrim(props{j}{2});
                        styleRules.(className).(property) = value;
                    end
                end
            end
        end
    end
end