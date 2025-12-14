function ppbez = curv2_bezier_join_same_degree(pp1, pp2, case_min)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unisce due curve di Bèzier o due curve di Bézier a tratti con grado
% uguale
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
ppbez.deg = pp1.deg;
ppbez.ab = [pp1.ab, pp1.ab(n1) + pp2.ab(2:n2) - pp2.ab(1)];
ppbez.cp = [pp1.cp; pp2.cp(2:ncp2,:)];

end