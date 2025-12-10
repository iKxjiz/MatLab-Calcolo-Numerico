function [mdppbez_sx,mdppbez_dx]=mdppbezier_subdiv(mdppbez,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [mdppbez_sx,mdppbez_dx]=mdppbezier_subdiv(mdppbez,x)
%Suddivide una curva nD di bezier a tratti multi-grado (mdppbez)
%definita dai punti di controllo mdppbez.cp nel punto x mediante 
%l'algoritmo di de Casteljau dell'opportuno tratto di Bézier
%mdppbez --> struttura formata da 3 campi:
%             mdppbez.deg --> gradi della curva
%             mdppbez.cp  --> lista dei punti di controllo
%             mdppbez.ab  --> partizione nodale
%x  --> punto in cui suddividere
%mdppbez_sx <-- struttura formata da 3 campi:
%                mdppbez_sx.deg --> gradi della curva
%                mdppbez_sx.cp  --> lista dei punti di controllo
%                mdppbez_sx.ab  --> partizione nodale
%mdppbez_dx <-- struttura formata da 3 campi:
%                mdppbez_dx.deg --> gradi della curva
%                mdppbez_dx.cp  --> lista dei punti di controllo
%                mdppbez_dx.ab  --> partizione nodale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%numero tratti della curva
nc=length(mdppbez.ab)-1;
%numero punti di controllo
ncp=length(mdppbez.cp(:,1));
%gradi
ng=length(mdppbez.deg);

if (ng==1 && nc>1)
%La curva non e' una mdppbezier, ma una ppbezier);
    mdppbez=curv2_ppbezier2mdppbezier(mdppbez);
end
%ricerca dell'intervallo in cui suddividere
l=gc_findint(0,mdppbez.ab,x);
if(abs(x-mdppbez.ab(l))<1.0e-2)

    mdppbez_sx.deg=mdppbez.deg(1:l-1);
    n=sum(mdppbez.deg(1:l-1))+1;
    mdppbez_sx.ab=mdppbez.ab(1:l);
    mdppbez_sx.cp=mdppbez.cp(1:n,:);

    mdppbez_dx.deg=mdppbez.deg(l:nc);
    mdppbez_dx.ab=mdppbez.ab(l:nc+1);
    mdppbez_dx.cp=mdppbez.cp(n:ncp,:);

elseif (abs(x-mdppbez.ab(l+1))<1.0e-2)

    mdppbez_sx.deg=mdppbez.deg(1:l);
    n=sum(mdppbez.deg(1:l))+1;
    mdppbez_sx.ab=mdppbez.ab(1:l+1);
    mdppbez_sx.cp=mdppbez.cp(1:n,:);

    mdppbez_dx.deg=mdppbez.deg(l+1:nc);
    mdppbez_dx.ab=mdppbez.ab(l+1:nc+1);
    mdppbez_dx.cp=mdppbez.cp(n:ncp,:);

else
bez.deg=mdppbez.deg(l);
bez.ab=mdppbez.ab(l:l+1);
n=sum(mdppbez.deg(1:l-1))+1;
bez.cp=mdppbez.cp(n:n+bez.deg,:);
[bez_sx,bez_dx]=decast_subdiv(bez,x);
mdppbez_sx.deg=mdppbez.deg(1:l);
mdppbez_sx.ab=[mdppbez.ab(1:l),x];
mdppbez_sx.cp=[mdppbez.cp(1:n,:);bez_sx.cp(2:bez_sx.deg+1,:)];
mdppbez_dx.deg=mdppbez.deg(l:nc);
mdppbez_dx.ab=[x,mdppbez.ab(l+1:nc+1)];
mdppbez_dx.cp=[bez_dx.cp(1:bez_dx.deg,:);mdppbez.cp(n+bez.deg:ncp,:)];
end
end

