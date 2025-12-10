function mdppbez = curv2_mdppbez_join_with_segment(pp1, pp2, case_min)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unisce due curve di Bèzier a tratti multi-degree con un 
% segmento di raccordo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ncp1 = size(pp1.cp, 1);
ncp2 = size(pp2.cp, 1);

switch case_min
    case 1  % Caso (up)
%         disp('caso1')

    case 2  % Caso (uu)
%         disp('caso2')
        pp2 = curv2_mdppbezier_reverse(pp2);  % Inverti pp2

    case 3  % Caso (pp)
%         disp('caso3')
        pp1 = curv2_mdppbezier_reverse(pp1); % Inverti pp1

    case 4  % Caso (pu)
%         disp('caso4')
        pp1 = curv2_mdppbezier_reverse(pp1); % Inverti pp1
        pp2 = curv2_mdppbezier_reverse(pp2); % Inverti pp2
end
line_cp = [pp1.cp(ncp1,:); pp2.cp(1,:)];  % Segmento tra ultimo punto di pp1 e primo di pp2
mdppbez.deg = [pp1.deg, 1, pp2.deg];
mdppbez.ab = [pp1.ab, pp1.ab(end)+1, pp1.ab(end)+1+pp2.ab(2:end)-pp2.ab(1)];
mdppbez.cp = [pp1.cp; line_cp(2, :); pp2.cp(2:end,:)];

end



