function array_mdppBezier = d2mdppbezier(d)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trasforma l'oggetto d, che deve essere di tipo ParsePathData.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 0
    error("Input non valido.");
end

CMD = d.Commands;
PAR = d.AllParams;

array_mdppBezier = [];

PuntoFinale = [0 0];
mdppBezier.deg = [];
mdppBezier.cp = [];
mdppBezier.ab = [];
mdppBezier.sense = [];
mdppBezier.isContained = [];

numeroCommandi = numel(CMD);
Tratto = 0;

%% Salva i dati all'interno dell'oggetto mdppBezier
comando_prec='';
for IndiceCommando = 1:numeroCommandi
    Considerato = false;

    Parametri = str2double(PAR{IndiceCommando});
    nParametri = numel(Parametri);

    % Distinguere il comando maiuscolo da quello minuscolo
    comando = CMD{IndiceCommando};

    switch comando
        case 'M'
            % Gestisci il caso in cui ci sono più di due valori
            if nParametri > 2
                PuntoFinale = Parametri(1:2);
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;

                % Aggiungi i restanti parametri come comandi 'L'
                for k = 3:2:nParametri
                    PuntoFinale = Parametri(k:k+1);
                    mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                    mdppBezier.ab = [mdppBezier.ab Tratto];
                    mdppBezier.deg = [mdppBezier.deg 1];
                    Tratto = Tratto + 1;
                end
            else
                PuntoFinale = Parametri(1:2);
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
            end
        case 'm'
            if nParametri > 2
                % Gestisci il caso in cui ci sono più di due valori
                PuntoFinale = PuntoFinale + Parametri(1:2);
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;

                % Aggiungi i restanti parametri come comandi 'l'
                for k = 3:2:nParametri
                    PuntoFinale = PuntoFinale + Parametri(k:k+1);
                    mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                    mdppBezier.ab = [mdppBezier.ab Tratto];
                    mdppBezier.deg = [mdppBezier.deg 1];
                    Tratto = Tratto + 1;
                end
            else
                % Gestisci il caso normale con due valori
                PuntoFinale = PuntoFinale + Parametri(1:2);
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
            end
        case 'L'
            for k = 1 : 2 : nParametri
                PuntoFinale = Parametri(k:k+1);
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                mdppBezier.deg = [mdppBezier.deg 1];
                Tratto = Tratto + 1;
            end
        case 'l'
            for k = 1 : 2 : nParametri
                PuntoFinale = PuntoFinale + Parametri(k:k+1);
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                mdppBezier.deg = [mdppBezier.deg 1];
                Tratto = Tratto + 1;
            end
        case 'H'
            for k = 1 : nParametri
                PuntoFinale = [Parametri(k) PuntoFinale(2)];
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                mdppBezier.deg = [mdppBezier.deg 1];
                Tratto = Tratto + 1;
            end
        case 'h'
            for k = 1 : nParametri
                PuntoFinale = PuntoFinale + [Parametri(k) 0];
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                mdppBezier.deg = [mdppBezier.deg 1];
                Tratto = Tratto + 1;
            end
        case 'V'
            for k = 1 : nParametri
                PuntoFinale = [PuntoFinale(1) Parametri(k)];
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                mdppBezier.deg = [mdppBezier.deg 1];
                Tratto = Tratto + 1;
            end
        case 'v'
            for k = 1 : nParametri
                PuntoFinale = PuntoFinale + [0 Parametri(k)];
                mdppBezier.cp = [mdppBezier.cp; PuntoFinale];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                mdppBezier.deg = [mdppBezier.deg 1];
                Tratto = Tratto + 1;
            end
        case 'C'
            for k = 1 : 6 : nParametri
                mdppBezier.deg = [mdppBezier.deg 3];
                mdppBezier.cp = [mdppBezier.cp; ... % Tutti i punti prima +
                    Parametri(k:k+1);       ... % Primo Punto Assoluto
                    Parametri(k+2:k+3);     ... % Secondo Punto Assoluto
                    Parametri(k+4:k+5)      ... % Terzo Punto Assoluto
                    ];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
                PuntoFinale = Parametri(k+4:k+5);
            end
        case 'c'
            for k = 1 : 6 : nParametri
                mdppBezier.deg = [mdppBezier.deg 3];
                mdppBezier.cp = [mdppBezier.cp;           ... % Tutti i punti di prima
                    PuntoFinale + Parametri(k:k+1);   ... % Primo punto relativo
                    PuntoFinale + Parametri(k+2:k+3); ... % Secondo punto relativo
                    PuntoFinale + Parametri(k+4:k+5)  ... % Terzo punto relativo
                    ];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
                PuntoFinale = PuntoFinale + Parametri(k+4:k+5);
            end
        case 'S'
            for k = 1 : 4 : nParametri
                mdppBezier.deg = [mdppBezier.deg 3];
                if (length(mdppBezier.cp) == 2 || (comando_prec~='C' && comando_prec~='c' && comando_prec~='S' && comando_prec~='s') )
                    mdppBezier.cp = [mdppBezier.cp; ... % Tutti i punti di prima
                        PuntoFinale; ... % punto di controllo uguale a quello iniziale
                        Parametri(k:k+1);       ... % Primo punto assoluto
                        Parametri(k+2:k+3);     ... % Secondo punto assoluto
                        ];
                else
                    mdppBezier.cp = [mdppBezier.cp; ... % Tutti i punti di prima
                        2.*PuntoFinale-mdppBezier.cp(end-1,:); ... % punto di controllo uguale a quello iniziale
                        Parametri(k:k+1);       ... % Primo punto assoluto
                        Parametri(k+2:k+3);     ... % Secondo punto assoluto
                        ];
                end
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
                PuntoFinale = Parametri(k+2:k+3);
            end
        case 's'
            for k = 1 : 4 : nParametri
                mdppBezier.deg = [mdppBezier.deg 3];
                if (length(mdppBezier.cp) == 2 || (comando_prec~='C' && comando_prec~='c' && comando_prec~='S' && comando_prec~='s') )
                    mdppBezier.cp = [mdppBezier.cp;             ... % Tutti i punti di prima
                        PuntoFinale;   ... % punto di controllo uguale a quello iniziale
                        PuntoFinale + Parametri(k:k+1);     ... % Primo punto relativo
                        PuntoFinale + Parametri(k+2:k+3);   ... % Secondo punto relativo
                        ];
                else
                    mdppBezier.cp = [mdppBezier.cp;             ... % Tutti i punti di prima
                        2.*PuntoFinale-mdppBezier.cp(end-1,:);   ... % punto di controllo precedente
                        PuntoFinale + Parametri(k:k+1);     ... % Primo punto relativo
                        PuntoFinale + Parametri(k+2:k+3);   ... % Secondo punto relativo
                        ];
                end
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
                PuntoFinale = PuntoFinale + Parametri(k+2:k+3);
            end
        case 'Q'
            for k = 1 : 4 : nParametri
                mdppBezier.deg = [mdppBezier.deg 2];
                mdppBezier.cp = [mdppBezier.cp; ... % Tutti i punti di prima
                    Parametri(k:k+1);       ... % Primo punto assoluto
                    Parametri(k+2:k+3);     ... % Secondo punto assoluto
                    ];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
                PuntoFinale = Parametri(k+2:k+3);
            end
        case 'q'
            for k = 1 : 4 : nParametri
                mdppBezier.deg = [mdppBezier.deg 2];
                mdppBezier.cp = [mdppBezier.cp;             ... % Tutti i punti di prima
                    PuntoFinale + Parametri(k:k+1);     ... % Primo punto relativo
                    PuntoFinale + Parametri(k+2:k+3);   ... % Secondo punto relativo
                    ];
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
                PuntoFinale = PuntoFinale + Parametri(k+2:k+3);
            end
        case 'T'
            for k = 1 : 2 : nParametri
                mdppBezier.deg = [mdppBezier.deg 2];
                if (length(mdppBezier.cp) == 2 || (comando_prec~='Q' && comando_prec~='q' && comando_prec~='T' && comando_prec~='t') )
                    mdppBezier.cp = [mdppBezier.cp; ... % Tutti i punti di prima
                        PuntoFinale; ... % Punto uguale al precedente
                        Parametri(k:k+1);       ... % Primo punto assoluto
                        ];
                else
                    mdppBezier.cp = [mdppBezier.cp; ... % Tutti i punti di prima
                        2.*PuntoFinale-mdppBezier.cp(end-1,:); ... % Punto precedente
                        Parametri(k:k+1);       ... % Primo punto assoluto
                        ];
                end
                mdppBezier.ab = [mdppBezier.ab Tratto];
                Tratto = Tratto + 1;
                PuntoFinale = Parametri(k:k+1);
            end
        case 't'
            for k = 1 : 2 : nParametri
                mdppBezier.deg = [mdppBezier.deg 2];
                if (length(mdppBezier.cp) == 2 || (comando_prec~='Q' && comando_prec~='q' && comando_prec~='T' && comando_prec~='t') )
                    mdppBezier.cp = [mdppBezier.cp;         ... % Tutti i punti di prima
                        PuntoFinale; ... % Punto uguale al precedente
                        PuntoFinale + Parametri(k:k+1); ... % Primo punto relativo
                        ];
                else
                    mdppBezier.cp = [mdppBezier.cp;         ... % Tutti i punti di prima
                        2.*PuntoFinale-mdppBezier.cp(end-1,:); ... % Punto precedente
                        PuntoFinale + Parametri(k:k+1); ... % Primo punto relativo
                        ];
                end
                mdppBezier.ab = [mdppBezier.ab Tratto];
                mdppBezier.sense = [mdppBezier.sense, 't'];
                Tratto = Tratto + 1;
                PuntoFinale = PuntoFinale + Parametri(k:k+1);
            end
        case 'A'
            for k = 1:7:nParametri
                rx = Parametri(k);
                ry = Parametri(k+1);
                xAxisRotation = Parametri(k+2);
                largeArcFlag = Parametri(k+3);
                sweepFlag = Parametri(k+4);
                endPoint = Parametri(k+5:k+6);

                % Calcolo dell'arco ellittico come curve di Bézier
                curvePoints = EllipticalArcToBezier(PuntoFinale, endPoint, rx, ry, xAxisRotation, largeArcFlag, sweepFlag);

                numPoints = size(curvePoints, 1) / 4; % Ogni segmento ha 4 punti
                mdppBezier.deg = [mdppBezier.deg, repmat(3, 1, numPoints)]; % Un grado per ogni segmento
                mdppBezier.cp = [mdppBezier.cp; curvePoints];
                % Assegna un valore di ab per ogni segmento dell'arco
                mdppBezier.ab = [mdppBezier.ab, Tratto:Tratto+numPoints-1];
                Tratto = Tratto + numPoints;
                PuntoFinale = endPoint;
            end
        case 'a'
            for k = 1:7:nParametri
                rx = Parametri(k);
                ry = Parametri(k+1);
                xAxisRotation = Parametri(k+2);
                largeArcFlag = Parametri(k+3);
                sweepFlag = Parametri(k+4);
                relativeEndPoint = Parametri(k+5:k+6);
                endPoint = PuntoFinale + relativeEndPoint;

                % Calcolo dell'arco ellittico come curve di Bézier
                curvePoints = EllipticalArcToBezier(PuntoFinale, endPoint, rx, ry, xAxisRotation, largeArcFlag, sweepFlag);

                numPoints = size(curvePoints, 1) / 4; % Ogni segmento ha 4 punti
                mdppBezier.deg = [mdppBezier.deg, repmat(3, 1, numPoints)]; % Un grado per ogni segmento
                mdppBezier.cp = [mdppBezier.cp; curvePoints];
                % Assegna un valore di ab per ogni segmento dell'arco
                mdppBezier.ab = [mdppBezier.ab, Tratto:Tratto+numPoints-1];
                Tratto = Tratto + numPoints;
                PuntoFinale = endPoint;
            end
        case 'Z'
            mdppBezier.cp = [mdppBezier.cp; mdppBezier.cp(1,:)];
            mdppBezier.ab = [mdppBezier.ab Tratto];
            mdppBezier.deg = [mdppBezier.deg 1];
            Tratto = Tratto + 1;
            % Calcolare il verso del subpath corrente
            senso = calcola_senso(mdppBezier.cp);
            mdppBezier.sense = [mdppBezier.sense, senso];


            Considerato = true;

            % Salva l'oggetto appena creato
            array_mdppBezier = [array_mdppBezier mdppBezier];

            % Reset dell'oggetto
            mdppBezier.deg = [];
            mdppBezier.cp = [];
            mdppBezier.ab = [];
            mdppBezier.sense = [];
        case 'z'
            mdppBezier.cp = [mdppBezier.cp; mdppBezier.cp(1,:)];
            mdppBezier.ab = [mdppBezier.ab Tratto];
            mdppBezier.deg = [mdppBezier.deg 1];
            Tratto = Tratto + 1;
            % Calcolare il verso del subpath corrente
            senso = calcola_senso(mdppBezier.cp);
            mdppBezier.sense = [mdppBezier.sense, senso];

            Considerato = true;

            % Salva l'oggetto appena creato
            array_mdppBezier = [array_mdppBezier mdppBezier];

            % Reset dell'oggetto
            mdppBezier.deg = [];
            mdppBezier.cp = [];
            mdppBezier.ab = [];
            mdppBezier.sense = [];
            mdppBezier.isContained = [];
    end
    comando_prec=comando;
end

%% Salva l'ultimo oggetto
if Considerato == false
    array_mdppBezier = [array_mdppBezier mdppBezier];
end
end

function curvePoints = EllipticalArcToBezier(startPoint, endPoint, rx, ry, xAxisRotation, largeArcFlag, sweepFlag)
% Conversione degli input in un formato numerico
startPoint = startPoint(:)';
endPoint = endPoint(:)';

% Passo 1: Gestione degli input e normalizzazione
if rx == 0 || ry == 0 || all(startPoint == endPoint)
    % Se i raggi sono nulli o il punto iniziale coincide col punto finale
    curvePoints = [];
    finalPoint = endPoint;
    return;
end

% Assicurarsi che rx e ry siano positivi
rx = abs(rx);
ry = abs(ry);

% Rotazione dell'ellisse
xAxisRotationRad = deg2rad(xAxisRotation);
cosTheta = cos(xAxisRotationRad);
sinTheta = sin(xAxisRotationRad);

% Trasformazione del sistema di coordinate
deltaX = (startPoint(1) - endPoint(1)) / 2;
deltaY = (startPoint(2) - endPoint(2)) / 2;
x1Prime = cosTheta * deltaX + sinTheta * deltaY;
y1Prime = -sinTheta * deltaX + cosTheta * deltaY;

% Correzione dei raggi per garantire che il punto sia raggiungibile
rSquareCheck = (x1Prime^2) / (rx^2) + (y1Prime^2) / (ry^2);
if rSquareCheck > 1
    scaleFactor = sqrt(rSquareCheck);
    rx = rx * scaleFactor;
    ry = ry * scaleFactor;
end

% Calcolo del centro dell'ellisse
signLargeArcSweep = (largeArcFlag == sweepFlag) * 2 - 1; % Determina il segno
cxPrime = signLargeArcSweep * sqrt(max(0, (rx^2 * ry^2 - rx^2 * y1Prime^2 - ry^2 * x1Prime^2) / ...
    (rx^2 * y1Prime^2 + ry^2 * x1Prime^2))) * rx * y1Prime / ry;
cyPrime = signLargeArcSweep * sqrt(max(0, (rx^2 * ry^2 - rx^2 * y1Prime^2 - ry^2 * x1Prime^2) / ...
    (rx^2 * y1Prime^2 + ry^2 * x1Prime^2))) * -ry * x1Prime / rx;

% Centro in coordinate globali
cx = cosTheta * cxPrime - sinTheta * cyPrime + (startPoint(1) + endPoint(1)) / 2;
cy = sinTheta * cxPrime + cosTheta * cyPrime + (startPoint(2) + endPoint(2)) / 2;

% Angoli di partenza e fine
theta1 = atan2((y1Prime - cyPrime) / ry, (x1Prime - cxPrime) / rx);
deltaTheta = atan2((-y1Prime - cyPrime) / ry, (-x1Prime - cxPrime) / rx) - theta1;
if sweepFlag == 0 && deltaTheta > 0
    deltaTheta = deltaTheta - 2 * pi;
elseif sweepFlag == 1 && deltaTheta < 0
    deltaTheta = deltaTheta + 2 * pi;
end
deltaTheta = mod(deltaTheta, 2 * pi); % Assicurarsi che sia positivo

% Suddivisione in segmenti di massimo 90° dinamicamente
numSegments = ceil(abs(deltaTheta) / (pi / 4));
t = linspace(0, deltaTheta, numSegments + 1);

% Preallocazione della memoria
curvePoints = zeros(numSegments * 4, 2); % Prealloca lo spazio per i punti

% Punto iniziale del primo segmento
currentPoint = startPoint;

for i = 1:numSegments
    % Calcolo di un segmento di arco
    t1 = t(i);
    t2 = t(i + 1);

    % Punti di Bézier in coordinate locali
    localBezier = ArcSegmentToBezier(rx, ry, theta1 + t1, theta1 + t2);

    % Trasformazione in coordinate globali
    globalBezier = transformBezier(localBezier, cx, cy, xAxisRotationRad);

    % Imposta il punto iniziale del segmento
    globalBezier(1, :) = currentPoint;

    % Aggiungi tutti e 4 i punti al risultato
    curvePoints((i-1)*4 + 1:i*4, :) = globalBezier;

    % Aggiorna il punto corrente per il segmento successivo
    currentPoint = globalBezier(4, :);
end

% Punto finale
finalPoint = endPoint;

end

function localBezier = ArcSegmentToBezier(rx, ry, theta1, theta2)
% Calcola i punti di Bézier per un arco ellittico
deltaTheta = theta2 - theta1;
alpha = sin(deltaTheta) * (sqrt(4 + 3 * tan(deltaTheta / 2)^2) - 1) / 3;

% Punti iniziali e finali
p1 = [rx * cos(theta1), ry * sin(theta1)];
p2 = [rx * cos(theta2), ry * sin(theta2)];

% Punti di controllo
cp1 = p1 + alpha * [-ry * sin(theta1), rx * cos(theta1)];
cp2 = p2 - alpha * [-ry * sin(theta2), rx * cos(theta2)];

localBezier = [p1; cp1; cp2; p2];
end

function globalBezier = transformBezier(localBezier, cx, cy, rotation)
% Trasforma i punti di Bézier in coordinate globali
cosTheta = cos(rotation);
sinTheta = sin(rotation);
globalBezier = (localBezier * [cosTheta, -sinTheta; sinTheta, cosTheta]) + [cx, cy];
end

function senso = calcola_senso(curva)
% curva: matrice Nx2 con i punti di controllo della curva Bézier
% Raggio da un punto fisso (es. il centro della bounding box della curva)

% Trova un punto all'interno della forma
minX = min(curva(:,1));
maxX = max(curva(:,1));
minY = min(curva(:,2));
maxY = max(curva(:,2));

puntoInterno = [(minX + maxX) / 2, (minY + maxY) / 2]; % Centro della forma

% Traccia un raggio orizzontale verso destra
raggio = [puntoInterno(1), puntoInterno(2); maxX + 10, puntoInterno(2)];

% Conta intersezioni
intersezioni = 0;
windingNumber = 0;

for i = 1:size(curva, 1) - 1
    p1 = curva(i, :);
    p2 = curva(i + 1, :);

    % Controlla se il segmento interseca il raggio
    if (p1(2) <= puntoInterno(2) && p2(2) > puntoInterno(2)) || ...
            (p1(2) > puntoInterno(2) && p2(2) <= puntoInterno(2))

        % Calcola la x dell'intersezione
        intersezioneX = p1(1) + (puntoInterno(2) - p1(2)) * (p2(1) - p1(1)) / (p2(2) - p1(2));

        if intersezioneX > puntoInterno(1)
            intersezioni = intersezioni + 1;

            % Determina il verso del segmento
            if p2(2) > p1(2)  % Segmento verso l'alto
                windingNumber = windingNumber + 1;
            else  % Segmento verso il basso
                windingNumber = windingNumber - 1;
            end
        end
    end
end

senso = windingNumber;
end
