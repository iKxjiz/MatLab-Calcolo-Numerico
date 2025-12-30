function tau = curv3_spline_tor_plot(spline,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function tau =curv3_spline_tor_plot(g,P,a,b,np,varargin)
%Disegna la funzione torsione di una curva 3D spline
%spline --> struttura di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x3 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%np --> numero di punti per tratto in cui valutare e disegnare i valori di torsione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%tau <-- valori della funzione torsione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[nm,mesh]=gc_mesh(spline.deg,spline.knot,abs(np));

Px=deboor_valder(spline,3,mesh);

for i=1:abs(np)
 vect=cross([Px(2,i,1),Px(2,i,2),Px(2,i,3)],[Px(3,i,1),Px(3,i,2),Px(3,i,3)]);
 bd=norm(vect,2);
 A=[Px(2,i,1),Px(2,i,2),Px(2,i,3);Px(3,i,1),Px(3,i,2),Px(3,i,3);Px(4,i,1),Px(4,i,2),Px(4,i,3)];
 tau(i)=det(A)/bd^2;
end

if (np > 0)
    %chiamata di disegno per funzione scalare
    mesh_curv2_plot(t,tau,varargin{:});
end

end
