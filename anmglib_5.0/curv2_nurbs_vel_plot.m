function vel = curv2_nurbs_vel_plot(nurbs,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv2_nurbs_vel_plot(nurbs,np,varargin)
%Disegna la funzione velocita' di una curva nurbs 2D
%nurbs --> struttura di una curva nurbs:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp)x2 
%          nurbs.w   --> lista dei pesi
%          nurbs.knot  --> vettore dei nodi (ncp+g+1)
%np --> numero di punti per tratto in cui valutare e disegnare i valori velocita'
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%vel <-- valori della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nm,mesh]=gc_mesh(nurbs.deg,nurbs.knot,abs(np));

Px=nurbs_valder(nurbs,1,mesh);

for i=1:nm
    vel(i)=norm([Px(2,i,1),Px(2,i,2)],2);
end

if (np > 0)
    mesh_curv2_plot(mesh,vel,varargin{:});
end

end
