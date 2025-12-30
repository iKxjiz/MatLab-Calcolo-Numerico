function mdppbez = curv2_bezier_join_different_degree(pp1, pp2, case_min)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unisce due curve di Bèzier o due curve di Bézier a tratti con grado
% differente
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n1 = length(pp1.ab);
n2 = length(pp2.ab);
ncp1 = size(pp1.cp, 1);
ncp2 = size(pp2.cp, 1);
switch case_min
    case 1  % Caso (up)
%         disp('Collegamento diretto (up)');

    case 2  % Caso (uu)
%         disp('Collegamento diretto (uu)');
        pp2 = curv2_ppbezier_reverse(pp2);  % Inverti pp2

    case 3  % Caso (pp)
%         disp('Collegamento diretto (pp)');
        pp1 = curv2_ppbezier_reverse(pp1); % Inverti pp1

    case 4  % Caso (pu)
%         disp('Collegamento diretto (pu)');
        pp1 = curv2_ppbezier_reverse(pp1); % Inverti pp1
        pp2 = curv2_ppbezier_reverse(pp2);  % Inverti pp2

end

% Determina il numero di tratti per pp1 e pp2
num_tratti1 = length(pp1.ab) - 1;
num_tratti2 = length(pp2.ab) - 1;
mdppbez.deg=[pp1.deg*ones(1,num_tratti1),pp2.deg*ones(1,num_tratti2)];
mdppbez.ab = [pp1.ab, pp1.ab(n1) + pp2.ab(2:n2) - pp2.ab(1)];
mdppbez.cp = [pp1.cp; pp2.cp(2:ncp2,:)];

end

