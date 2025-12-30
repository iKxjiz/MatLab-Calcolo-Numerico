function [x,y]= circle2_plot(O,r,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y]=circle2_plot(O,r,np,varargin)
%Disegna sul piano cartesiano una circonferenza di centro O e raggio r
%O  --> centro 2D della circonferenza
%r  --> raggio
%np --> numero di punti del disegno
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare, in ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%x,y <-- coordinate punti disegnati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta=2*pi/(abs(np)-1);
c=cos(theta);
s=sin(theta);
x(1)=1;
y(1)=0;
for i=2:abs(np)
  x(i)=x(i-1)*c-y(i-1)*s;
  y(i)=x(i-1)*s+y(i-1)*c;
end
x=r*x+O(1);
y=r*y+O(2);

if (np > 0)
    mesh_curv2_plot(x,y,varargin{:});
end

return
