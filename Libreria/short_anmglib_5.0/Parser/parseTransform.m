function M = parseTransform(transformAttr)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Interpreta le trasformazioni SVG e genera una matrice di trasformazione
% Input:
% transformAttr: stringa che specifica una o più trasformazioni SVG
% Output:
% M: matrice di trasformazione 3x3 ottenuta applicando le trasformazioni
%        in sequenza. Inizialmente è la matrice identità.
%
% Supporta i seguenti comandi di trasformazione SVG:
%   1. scale(sx)            → scalatura uniforme
%      scale(sx, sy)        → scalatura indipendente su x e y
%   2. translate(tx)        → traslazione lungo x
%      translate(tx, ty)    → traslazione lungo x e y
%   3. rotate(a)            → rotazione attorno all'origine di a gradi
%      rotate(a, cx, cy)    → rotazione attorno a un punto (cx, cy)
%   4. matrix(a, b, c, d, e, f) → matrice di trasformazione generica 2D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dividi la stringa per identificare i comandi
C = regexp(transformAttr, '(translate|scale|rotate|matrix)\([^)]+\)', 'match');
M = eye(3); % Matrice di trasformazione iniziale (identità)

for i = 1:length(C)
    D = strsplit(C{i}, {'(', ')'});
    cmd = strtrim(D{1});
    if numel(D) > 1
        params = str2double(strsplit(D{2}, {',', ' '}));
    else
        params = [];
    end

    switch cmd
        case 'scale'
            S = eye(3);
            if numel(params) == 1
                S(1,1) = params(1);
                S(2,2) = params(1);
            elseif numel(params) == 2
                S(1,1) = params(1);
                S(2,2) = params(2);
            end
            M = S * M;

        case 'translate'
            T = eye(3);
            if numel(params) >= 1
                T(1,3) = params(1);
            end
            if numel(params) == 2
                T(2,3) = params(2);
            end
            M = T * M;

        case 'rotate'
            R = eye(3);
            if numel(params) >= 1
                angle = deg2rad(params(1));
                R(1,1) = cos(angle);
                R(1,2) = -sin(angle);
                R(2,1) = sin(angle);
                R(2,2) = cos(angle);

                if numel(params) == 3
                    cx = params(2);
                    cy = params(3);
                    M = [1, 0, cx; 0, 1, cy; 0, 0, 1] * R * [1, 0, -cx; 0, 1, -cy; 0, 0, 1] * M;
                else
                    M = R * M;
                end
            end

        case 'matrix'
            if numel(params) == 6
                matrix = [params(1), params(3), params(5);
                    params(2), params(4), params(6);
                    0, 0, 1];
                M = matrix * M;
            end

        otherwise
            warning('Comando di trasformazione non riconosciuto: %s', cmd);
    end
end
end