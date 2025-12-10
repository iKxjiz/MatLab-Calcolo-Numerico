function mdppbezQ = curv2_mdppbezier_reverse(mdppbezP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mdppbezQ = curv2_mdppbezier_reverse(mdppbezP)
%Calcola la curva 2D di Bezier a tratti multi-degree reverse della curva
%mdppbez a tratti multi-degree di input
%mdppbezP  --> struttura della curva 2D di Bezier a tratti :
%          mdppbezP.deg --> grado della curva
%          mdppbezP.cp  --> lista dei punti di controllo
%          mdppbezP.ab  --> partizione nodale di [a b]
%mdppbezQ <-- struttura della curva 2D di Bezier a tratti:
%          mdppbezQ.deg --> grado della curva
%          mdppbezQ.cp  --> lista dei punti di controllo
%          mdppbezQ.ab  --> partizione nodale [a b]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copia la struttura iniziale
mdppbezQ = mdppbezP;

% Inverti i punti di controllo per ogni segmento
mdppbezQ.cp = flip(mdppbezP.cp);  % Inverte l'ordine dei punti di controllo

% Inverti i gradi (mantieni invariati i gradi di ciascun segmento, ma inverti l'ordine)
mdppbezQ.deg = flip(mdppbezP.deg);

% Inverti la partizione nodale mantenendo la lunghezza totale degli intervalli
n = length(mdppbezQ.ab);
mdppbezQ.ab = [mdppbezQ.ab(1), mdppbezQ.ab(1) + mdppbezQ.ab(n) - flip(mdppbezQ.ab(1:n-1))];

end