classdef ParsePathData
    methods(Static)

        function [Commands, AllParams] = dParse(dAttr)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Interpreta l'attributo "d" del path SVG e separa comandi e parametri
            % Input:
            %   dAttr: stringa con i comandi del path SVG
            % Output:
            %   Commands: cell array dei comandi ('M', 'L', 'C', ecc.)
            %   AllParams: cell array dei parametri associati
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            % Trova i comandi (lettere) e separa i segmenti
            pattern = '([MLHVCSQTAZmlhvcsqtaz])';
            tokens = regexp(dAttr, pattern, 'split');
            commands = regexp(dAttr, pattern, 'match');

            Commands = commands;
            AllParams = cell(size(commands));
            for i = 1:length(commands)
                if i < length(tokens)
                    % Estrai i parametri come numeri
                    params = regexp(tokens{i + 1}, '[-+]?\d*\.?\d+([eE][-+]?\d+)?', 'match');
                    AllParams{i} = params;
                else
                    AllParams{i} = [];
                end
            end
        end

        function [lc, fc, lw] = parseStyle(styleAttr)
            % Analizza lo stile SVG utilizzando le classi Attributes e Color
            % Input:
            %   styleAttr: stringa con stile SVG (e.g., "stroke:red; fill:blue;")
            % Output:
            %   lc: colore del contorno
            %   fc: colore di riempimento
            %   lw: larghezza del contorno

            lc = Color.GetDefaultColor(); % Colore contorno predefinito
            fc = Color.GetDefaultColor(); % Colore riempimento predefinito
            lw = 1; % Larghezza contorno predefinita

            styles = strsplit(styleAttr, ';');
            for i = 1:length(styles)
                pair = strsplit(styles{i}, ':');
                if numel(pair) < 2, continue; end
                key = strtrim(pair{1});
                value = strtrim(pair{2});
                % Gestisce le varie proprietà
                switch lower(key)
                    case 'stroke'
                        lc = Color.Decode(value);  % Colore del contorno
                    case 'fill'
                        fc = Color.Decode(value);  % Colore del riempimento
                    case 'stroke-width'
                        lw = str2double(value);    % Larghezza del contorno
                        if lw <= 0 || isnan(lw)
                            lw = 1; % Imposta larghezza predefinita se invalida
                        end
                end
                if isempty(lc)
                    lc = 'none';
                end
                if isempty(fc)
                    fc = 'none';
                end
            end
        end

    end
end