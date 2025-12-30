classdef Color
    methods(Static)
        function outputArg = Decode(inputArg)
            % trasforma il testo in lettere minuscole
            inputArg = strtrim(lower(char(inputArg)));
            switch inputArg
                case 'blue'
                    outputArg = 'b';
                case 'green'
                    outputArg = 'g';
                case 'red'
                    outputArg = 'r';
                case 'cyan'
                    outputArg = 'c';
                case 'magenta'
                    outputArg = 'm';
                case 'yellow'
                    outputArg = 'y';
                case 'black'
                    outputArg = 'k';
                case 'orange'
                    outputArg = 'o';
                case 'light green'
                    outputArg = 'lg';
                case 'dark green'
                    outputArg = 'dg';
                case 'light blue'
                    outputArg = 'lb';
                case 'dark blue'
                    outputArg = 'db';
                case 'purple'
                    outputArg = 'p';
                case 'pink'
                    outputArg = 'pk';
                case 'brown'
                    outputArg = 'bw';
                case 'gold'
                    outputArg = 'gold';
                case 'silver'
                    outputArg = 'silver';
                case 'gray'
                    outputArg = 'gr';
                otherwise
                    if numel(inputArg) > 0 && inputArg(1) == '#'
                        if numel(inputArg) == 4
                            newValue = '#000000';
                            for k = 1 : 3
                                newValue(k * 2) = inputArg(k+1);
                                newValue(k * 2 + 1) = inputArg(k+1);
                            end
                            inputArg = newValue;
                        end
                        try
                            outputArg = Color.Arr2Str(hex2rgb(inputArg));
                        catch
                            outputArg = Color.GetDefaultColor;
                        end

                    else
                        outputArg = Color.GetDefaultColor;
                    end
            end
        end

        function defaultColor = GetDefaultColor()
            defaultColor = 'w';
        end

        function outputArg = Arr2Str(arr)
            % Colori di base MATLAB (RGB)
            predefinedColors = [
                1, 1, 1; % white ('w')
                1, 1, 0; % Yellow ('y')
                1, 0, 1; % Magenta ('m')
                0, 1, 1; % Cyan ('c')
                1, 0, 0; % Red ('r')
                0, 1, 0; % Green ('g')
                0, 0, 1; % Blue ('b')
                1, 1, 1; % White ('w')
                0, 0, 0; % Black ('k')
                1, 0.46, 0; % Orange ('o')
                0.57, 0.93, 0.57; % Light Green ('lg') 109, 153, 8
                0, 0.5, 0; % Dark Green ('dg')
                0.68, 0.85, 0.9; % Light Blue ('lb')
                0, 0, 0.545; % Dark Blue ('db')
                0.5, 0, 0.5; % Purple ('p')
                1, 0.75, 0.8; % Pink ('pk')
                0.65, 0.165, 0.165; % Brown ('bw')
                1, 0.84, 0; % Gold ('gold')
                0.753, 0.753, 0.753; % Silver ('silver')
                0.5, 0.5, 0.5; % Gray ('gr')
                0.129, 0.098, 0.086; % Dark Brown ('dbw')
                0.322, 0.643, 0.682; % water green ('wg')
                0.816, 0.769, 0.369; % olive yellow ('oy')
                0.631, 0.835, 0.827; % light water green ('lwg')
                0.769, 0.412, 0.157; % hot orange ('ho')
                0.953, 0.906, 0.498; % light yellow ('ly')
                0.867, 0.929, 0.914; % pallid blue ('pb')
                0.667, 0.263, 0.141; % matton red ('mr')
                0.141, 0.094, 0.090; % hard brown ('hb')
                0.988, 0.820, 0.239; % yellow-orange ('yo')
                0.427, 0.600, 0.031; % olive green ('og')
                1, 0.4471, 0.498; %light pink ('lpk')
                0.898, 0.898, 0.698; %avorio ('av')
                ];

            % Etichette corrispondenti
            labels = {'w','y', 'm', 'c', 'r', 'g', 'b', 'w', 'k', 'o', 'lg',...
                'dg', 'lb', 'db', 'p', 'pk', 'bw', 'gold', 'silver', 'gr', 'dbw',...
                'wg', 'oy', 'lwg', 'ho', 'ly', 'pb', 'mr', 'hb', 'yo', 'og', 'lpk', 'av'};

            % Calcolo delle distanze euclidee
            distances = vecnorm(predefinedColors - arr, 2, 2);

            % Trova l'indice del colore più vicino
            [~, idx] = min(distances);

            % Restituisci l'etichetta corrispondente
            outputArg = labels{idx};

        end

        function outputArg = Code(inputArg)
            % trasforma il testo in lettere minuscole
            inputArg = strtrim(lower(char(inputArg)));
            switch inputArg
                case 'b'
                    outputArg = [0, 0, 1];
                case 'g'
                    outputArg = [0, 1, 0];
                case 'r'
                    outputArg = [1, 0, 0];
                case 'c'
                    outputArg = [0, 1, 1];
                case 'm'
                    outputArg = [1, 0, 1];
                case 'y'
                    outputArg = [1, 1, 0];
                case 'k'
                    outputArg = [0, 0, 0];
                case 'o'
                    outputArg = [1, 0.46, 0];
                case 'lg'
                    outputArg = [0.57, 0.93, 0.57];
                case 'dg'
                    outputArg = [0, 0.5, 0];
                case 'lb'
                    outputArg = [0.68, 0.85, 0.9];
                case 'db'
                    outputArg = [0, 0, 0.545];
                case 'p'
                    outputArg = [0.5, 0, 0.5];
                case 'pk'
                    outputArg = [1, 0.75, 0.8];
                case 'bw'
                    outputArg = [0.65, 0.165, 0.165];
                case 'gold'
                    outputArg = [1, 0.84, 0];
                case 'silver'
                    outputArg = [0.753, 0.753, 0.753];
                case 'gr'
                    outputArg = [0.5, 0.5, 0.5];
                case 'dbw'
                    outputArg = [0.129, 0.098, 0.086];
                case 'wg'
                    outputArg = [0.322, 0.643, 0.682];
                case 'oy'
                    outputArg = [0.816, 0.769, 0.369];
                case 'lwg'
                    outputArg = [0.631, 0.835, 0.827];
                case 'ho'
                    outputArg = [0.769, 0.412, 0.157];
                case 'ly'
                    outputArg = [0.953, 0.906, 0.498];
                case 'pb'
                    outputArg = [0.867, 0.929, 0.914];
                case 'mr'
                    outputArg = [0.667, 0.263, 0.141];
                case 'hb'
                    outputArg = [0.141, 0.094, 0.090];
                case 'yo'
                    outputArg = [0.988, 0.820, 0.239];
                case 'og'
                    outputArg = [0.427, 0.600, 0.031];
                case 'lpk'
                    outputArg = [1, 0.4471, 0.498];
                case 'av'
                    outputArg = [0.898, 0.898, 0.698];
                case 'w'
                    outputArg = [1, 1, 1];
                otherwise
                    % Default value in case no match is found
                    outputArg = Color.GetDefaultColor();
            end
        end
        function hex = rgb2hex_norm(rgb)
            % Controlla che i valori siano tra 0 e 1
            if any(rgb < 0) || any(rgb > 1) || length(rgb) ~= 3
                error('Il vettore RGB deve avere 3 valori tra 0 e 1.');
            end
            % Scala a 0-255 e converti in HEX
            rgb = round(rgb * 255);
            hex = sprintf('#%02X%02X%02X', rgb(1), rgb(2), rgb(3));
        end
    end


end
