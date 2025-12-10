function mdppbez = curv2_bezier_join_with_segment(pp1, pp2, case_min)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unisce due curve di Bèzier o due curve di Bézier a tratti con segmento di raccordo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ncp1 = size(pp1.cp, 1);
ncp2 = size(pp2.cp, 1);

switch case_min
    case 1  % Caso (up)
%         disp('caso1-up')

    case 2  % Caso (uu)
%         disp('caso2-uu')
        pp2 = curv2_ppbezier_reverse(pp2);  % Inverti pp2

    case 3  % Caso (pp)
%         disp('caso3-pp')
        pp1 = curv2_ppbezier_reverse(pp1); % Inverti pp1

    case 4  % Caso (pu)
%         disp('caso4-pu')
        pp1 = curv2_ppbezier_reverse(pp1); % Inverti pp1
        pp2 = curv2_ppbezier_reverse(pp2); % Inverti pp2

end
% Determina il numero di tratti per pp1 e pp2
num_tratti1 = length(pp1.ab) - 1;
num_tratti2 = length(pp2.ab) - 1;
if (length(pp1.deg)==1)
    pp1.deg=pp1.deg*ones(1,num_tratti1);
end
if (length(pp2.deg)==1)
    pp2.deg=pp2.deg*ones(1,num_tratti2);
end
line_cp = [pp1.cp(ncp1,:); pp2.cp(1,:)];  % Segmento tra ultimo punto di pp1 e primo di pp2
mdppbez.deg = [pp1.deg, 1, pp2.deg];  % Aggiungi il segmento lineare (grado 1)
mdppbez.ab = [pp1.ab, pp1.ab(2)+1, pp1.ab(2)+1+pp2.ab(2)-pp2.ab(1)];   % Aggiungi i nodi della nuova curva
mdppbez.cp = [pp1.cp; line_cp(2, :); pp2.cp(2:end,:)];

end