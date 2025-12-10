function Px=curv2_spline_tan_plot(spline,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=curv2_spline_tan_plot(spline,np,varargin)
%Disegna il vettore tangente di una curva 2D spline
%spline --> struttura di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo 
%          spline.knot  --> vettore dei nodi
%np --> numero di punti in cui valutare e disegnare i vettori tangente
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%Px <-- vettori tangenti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[nm,mesh]=gc_mesh(spline.deg,spline.knot,abs(np));

%Algoritmo1
%bas_bspl = gc_bpspl(...);
%x=bas_bspl*qx;
%y=bas_bspl*qy;

%Algoritmo2
Px=deboor_valder(spline,1,mesh);

if (np > 0)
    for i=1:nm
     vect2_plot([Px(1,i,1),Px(1,i,2)],[Px(2,i,1),Px(2,i,2)],varargin{:});
    end
end

end

