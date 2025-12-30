function mdppbez = curv2_mdppbezier_join(pp1, pp2, tol)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mdppbez = curv2_mdppbezier_join(pp1, pp2, tol)
%Calcola la curva 2D di Bezier a tratti multi-degree, join delle due
%curve di Bézier o di Bézier a tratti o di Bézier a tratti multi-degree
%pp1 e pp2
%Se due estremi delle due curve distano meno di tol, le due curve 
%verranno unite come se gli estremi fossero uguali, in alternativa 
%verrà generata un'unica curva collegando gli estremi con un segmento 
%retto (tratto di Bezier di grado 1)
%pp1,pp2 --> strutture delle curve 2D in input:
%            pp1.deg --> grado/array di gradi della curva
%            pp1.cp  --> lista dei punti di controllo
%            pp1.ab  --> partizione nodale di [a b]
%tol   --> tolleranza entro cui gli estremi delle due curve 
%          vengono considerati uguali
%mdppbez <-- struttura della curva 2D di output:
%          mdppbez.deg --> grado/array di gradi della curva
%          mdppbez.cp  --> lista dei punti di controllo
%          mdppbez.ab  --> partizione nodale di [a b]
%Nota: se le due curve in input sono semplici curve di Bézier o
%      Bézier a tratti dello stesso grado, la curva in output
%      sarà una Bézier a tratti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mdppbez.deg = [];
mdppbez.ab = [];
mdppbez.cp = [];

% Calcola le distanze tra le estremità delle curve
[dist_min, case_min] = compute_endpoints_distances(pp1, pp2);

if(length(pp1.deg) > 1 || length(pp2.deg) > 1)
%   fprintf('Unione di curve di cui una almeno sia multi-degree\n');
    % Gestisce i casi in base alla distanza minima trovata
    if dist_min <= tol
%       fprintf('Le curve sono consecutive\n');
        % Le curve sono abbastanza vicine: connettile direttamente in base al caso
        mdppbez = curv2_mdppbez_join_directly(pp1, pp2, case_min);
    else
        % Le curve sono disgiunte: aggiungi un segmento di raccordo
%       fprintf('Le curve sono disgiunte, creo segmento di raccordo\n');
        mdppbez = curv2_mdppbez_join_with_segment(pp1, pp2, case_min);

    end
elseif(length(pp1.deg) == 1 && length(pp2.deg) == 1)
%     fprintf('Unione di curve di Bézier o Bézier a tratti (ppbezier)\n');
    if dist_min <= tol && pp1.deg == pp2.deg
%       fprintf('Unione di curve ppbezier stesso grado\n');
        mdppbez = curv2_bezier_join_same_degree(pp1, pp2, case_min);
    elseif dist_min <= tol && pp1.deg ~= pp2.deg
%       fprintf('Unione di curve ppbezier grado diverso\n');
        mdppbez = curv2_bezier_join_different_degree(pp1, pp2, case_min);
    else
%       fprintf('Le curve sono disgiunte, creo segmento di raccordo\n');
        mdppbez = curv2_bezier_join_with_segment(pp1, pp2, case_min);

end
end






