function [ppbez_sx,ppbez_dx]=ppbezier_subdiv(ppbez,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [ppbez_sx,ppbez_dx]=ppbezier_subdiv(ppbez,x)
%Suddivide una curva nD di bezier a tratti (ppbez)
%definita dai punti di controllo ppbez.cp nel punto x mediante 
%l'algoritmo di de Casteljau dell'opportuno tratto di Bézier
%ppbez --> struttura formata da 3 campi:
%           ppbez.deg --> grado della curva
%           ppbez.cp  --> lista dei punti di controllo
%           ppbez.ab  --> partizione nodale
%x  --> punto in cui suddividere
%ppbez_sx <-- struttura formata da 3 campi:
%          ppbez_sx.deg --> grado della curva
%          ppbez_sx.cp  --> lista dei punti di controllo
%          ppbez_sx.ab  --> partizione nodale
%ppbez_dx <-- struttura formata da 3 campi:
%          ppbez_dx.deg --> grado della curva
%          ppbez_dx.cp  --> lista dei punti di controllo
%          ppbez_dx.ab  --> partizione nodale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%forza ppbez.ab ad essere un vettore riga
ppbez.ab=ppbez.ab(:)';
%numero tratti della curva
nc=length(ppbez.ab)-1;
%numero punti di controllo
ncp=length(ppbez.cp(:,1));
%grado
n=ppbez.deg;

ppbez_sx.deg=n;
ppbez_dx.deg=n;

%ricerca dell'intervallo in cui suddividere
l=gc_findint(0,ppbez.ab,x);

if(abs(x-ppbez.ab(l))<1.0e-2)

        ppbez_sx.ab=ppbez.ab(1:l);
        ppbez_sx.cp=ppbez.cp(1:n*(l-1)+1,:);

        ppbez_dx.ab=ppbez.ab(l:nc+1);
        ppbez_dx.cp=ppbez.cp(n*(l-1)+1:ncp,:);

elseif (abs(x-ppbez.ab(l+1))<1.0e-2)

        ppbez_sx.ab=ppbez.ab(1:l+1);
        ppbez_sx.cp=ppbez.cp(1:n*l+1,:);       

        ppbez_dx.ab=ppbez.ab(l+1:nc+1);
        ppbez_dx.cp=ppbez.cp(n*l+1:ncp,:);

else
    bez.deg=n;
    bez.ab=ppbez.ab(l:l+1);
    bez.cp=ppbez.cp(n*(l-1)+1:n*l+1,:);
    [bez_sx,bez_dx]=decast_subdiv(bez,x);
    ppbez_sx.ab=[ppbez.ab(1:l),x];
    ppbez_sx.cp=[ppbez.cp(1:n*(l-1)+1,:);bez_sx.cp(2:n+1,:)];
    ppbez_dx.ab=[x,ppbez.ab(l+1:nc+1)];
    ppbez_dx.cp=[bez_dx.cp(1:n,:);ppbez.cp(n*l+1:ncp,:)];
end

end

