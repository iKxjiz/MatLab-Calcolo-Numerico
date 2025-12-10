function [mdppbezier, lc, lw, fc] = path2mdppbezier(path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converte il path in un array di oggetti mdppbezier
% ppBezier: .deg, .cp, .ab
% lc: line color
% lw: line width
% sense: sense segment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 0
    error("input non valido. Empty path.");
end

% Leggi gli attributi principali
dAttr = char(path.getAttribute(Attributes.d));

% Inizializza la trasformazione del path
M_local = eye(3); % Identità di default
if path.hasAttribute(Attributes.transform)
    transformAttr = char(path.getAttribute(Attributes.transform));
    if ~isempty(transformAttr)
        M_local = parseTransform(transformAttr); % Trasformazione locale del path
    end
end

% Inizializzazione degli attributi stilistici con valori predefiniti
lc = 'none'; % Colore del contorno di default
lw = 1;      % Larghezza del contorno di default
fc = '';     % Colore di riempimento di default (ereditato o vuoto)

styleAttr = char(path.getAttribute(Attributes.style));
% Controlla se esiste l'attributo style
if ~isempty(styleAttr)
    [lc, fc, lw] = ParsePathData.parseStyle(styleAttr);
else
    % Leggi i singoli attributi
    stroke = SearchAttrDom(path, Attributes.stroke, '');
    if isempty(stroke)
        lc = 'none';
    else
        lc = Color.Decode(stroke);
    end
    lw = str2double(SearchAttrDom(path, Attributes.strokeWidth, '1'));
    if lw <= 0 || isnan(lw)
        lw = 1; % Imposta larghezza predefinita se invalida
    end
    fillAttr = SearchAttrDom(path, Attributes.fill, '');
    if ~isempty(fillAttr)
        fc = Color.Decode(fillAttr); % Il fill del path ha priorità
    end
end
% % Gestione delle trasformazioni
% M = eye(3); % Matrice di trasformazione iniziale (identità)
% if ~isempty(transformAttr)
%     M = parseTransform(transformAttr);
% end
% Parsing iniziale dell'attributo "d"
[Commands, AllParams] = ParsePathData.dParse(dAttr);
dStruct.Commands = Commands;
dStruct.AllParams = AllParams;

% Interpreta i comandi del path e applica le trasformazioni
mdppbezier = d2mdppbezier(dStruct);

% Inizializza 'isContained' a 'false' per tutte le curve
for i = 1:numel(mdppbezier)
    mdppbezier(i).transform = M_local;
    if ~isfield(mdppbezier(i), 'isContained') || isempty(mdppbezier(i).isContained)
        mdppbezier(i).isContained = 'false';
    end
end

% Loop ottimizzato per verificare il contenimento tra curve
for i = 1:numel(mdppbezier)
    for j = i+1:numel(mdppbezier)  % Evita duplicazioni, considera solo la parte superiore della matrice
        % Verifica se la curva i è contenuta nella curva j
        if is_contained(mdppbezier(i).cp, mdppbezier(j).cp)
            mdppbezier(i).isContained = 'true';
        end

        % Verifica se la curva j è contenuta nella curva i
        if is_contained(mdppbezier(j).cp, mdppbezier(i).cp)
            mdppbezier(j).isContained = 'true';
        end
    end
end
end



function contained = is_contained(pointsA, pointsB)
% Calcola i bounding box di A e B
minA = min(pointsA);
maxA = max(pointsA);
minB = min(pointsB);
maxB = max(pointsB);

% Verifica se il bounding box di A è contenuto in quello di B
if all(minA >= minB) && all(maxA <= maxB)
    % A è all'interno di B dal punto di vista del bounding box
    contained = true;
    return;
end

% Se il bounding box di A non è contenuto in quello di B, verifica ulteriormente
contained = false;

% Suddividi A utilizzando De Casteljau per ottenere curve più piccole
subdividedA = subdivideBezier(pointsA);

% Precalcola i bounding box di ogni sottosegmento di A
boundingBoxesA = cell(2, 1);
for i = 1:2
    boundingBoxesA{i} = [min(subdividedA{i}); max(subdividedA{i})];
end

% Verifica che ogni segmento di A sia contenuto nel bounding box di B
for i = 1:2
    % Verifica se il bounding box del sottosegmento di A è contenuto in B
    if all(boundingBoxesA{i}(1, :) >= minB) && all(boundingBoxesA{i}(2, :) <= maxB)
        contained = true;
        break;
    end
end
end

function subdivided = subdivideBezier(bezierPoints)
% Suddivide una curva di Bézier in due curve più piccole utilizzando il metodo di De Casteljau
n = size(bezierPoints, 1); % Numero di punti di controllo

% Preallocazione per i punti intermedi e i risultati finali
left = zeros(n, size(bezierPoints, 2));  % Prealloca la curva sinistra
right = zeros(n, size(bezierPoints, 2)); % Prealloca la curva destra
intermediatePoints = bezierPoints;

% Applicazione del metodo di De Casteljau per il calcolo delle curve
for i = 1:n-1
    % Aggiorna i punti intermedi
    intermediatePoints = (1/2) * (intermediatePoints(1:end-1, :) + intermediatePoints(2:end, :));

    % Costruisci le curve sinistra e destra
    left(i, :) = intermediatePoints(1, :);
    right(i, :) = intermediatePoints(end, :);
end

% Aggiungi i punti finali
left(end, :) = bezierPoints(1, :);
right(end, :) = bezierPoints(end, :);

% Restituisci i segmenti suddivisi
subdivided = {left, right};
end

