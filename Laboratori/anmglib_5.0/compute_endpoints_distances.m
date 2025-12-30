function [dist_min, case_min] = compute_endpoints_distances(pp1, pp2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcola la distanza minima tra i due estremi di pp1 e pp2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ncp1 = size(pp1.cp, 1);
ncp2 = size(pp2.cp, 1);

% Calcola le distanze tra le estremità delle curve
d1 = norm(pp1.cp(ncp1,:) - pp2.cp(1,:), 2);      % Estremità finale di pp1 a iniziale di pp2 (up)
d2 = norm(pp1.cp(ncp1,:) - pp2.cp(ncp2,:), 2);    % Estremità finale di pp1 a finale di pp2 (uu)
d3 = norm(pp1.cp(1,:) - pp2.cp(1,:), 2);          % Estremità iniziale di pp1 a iniziale di pp2 (pp)
d4 = norm(pp1.cp(1,:) - pp2.cp(ncp2,:), 2);       % Estremità iniziale di pp1 a finale di pp2 (pu)

% Trova la distanza minima e il caso corrispondente
[dist_min, case_min] = min([d1, d2, d3, d4]);
end