function [path, XMinimo, YMinimo, XMassimo, YMassimo] = mdppbezier2path(mdppBezier)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% converte un oggetto mdppbezier in un attributo "d" del tag path (svg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
deg = mdppBezier.deg;
cp = mdppBezier.cp;

nDeg = numel(deg);
nCp = numel(cp);
nAb = numel(mdppBezier.ab);

%% Controlli necessari affinche il ciclo non vada in errore
if nDeg == 0 && nCp == 0 && sum(deg) > nCp/2
   error("Oggetto mdppbezier non valido."); 
end

if nDeg + 1 == nAb
    % Salta il primo elemento perché è la M
    a = 2;
else
    % Il primo punto sarà lo stesso della coordinata successiva.
    a = 1;
end
%% Salva il punto iniziale (M)
d = strcat("M ", num2str(cp(1,1)), " ", num2str(cp(1,2)), " ");

UltimoPunto = [0 0];
XMinimo = 0;
YMinimo = 0;
XMassimo = 0;
YMassimo = 0;

for i = 1 : nDeg   
    points = " ";
    PuntoRelativo = false;    
    for k = 1 : min(3, deg(i))
        X = cp(a, 1);
        Y = cp(a,2);
        
        if i ~= i && k == 1 && UltimoPunto == [X Y]
            PuntoRelativo = true;
        else
            if PuntoRelativo == true
                X = X - UltimoPunto(1,1);
                Y = Y - UltimoPunto(1,2);
            end
            points = strcat(points,       ... % Punti precedenti
                num2str(X), " ",   ... % X 
                num2str(Y), " "    ... % Y
            );
        end
        XMinimo = min(XMinimo, X);
        YMinimo = min(YMinimo, Y);
        XMassimo = max(XMassimo, X);
        YMassimo = max(YMassimo, Y);
        
        a = a + 1;
    end
    
    UltimoPunto = cp(a - 1, :);
    
    lettera = "L";
    switch(k)
        case 1 % Linea
            if PuntoRelativo == false
                lettera = "L";
            else
                lettera = "l";
            end
        case 2 % Quadrata
            if PuntoRelativo == false
                lettera = "Q";
            else
                lettera = "q";
            end
        case 3 % Cubica
            if PuntoRelativo == false
                lettera = "C";
            else
                lettera = "c";
            end
    end
    d = strcat(d, lettera, points);
end
%% Aggiungi il terminatore stringa
path = strcat(strtrim(d), " z");
end