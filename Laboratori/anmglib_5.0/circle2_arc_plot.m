function [x,y] = circle2_arc_plot(O,r,ang1,ang2,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y] = circle2_arc_plot(O,r,ang1,ang2,np,varargin)
%Disegna sul piano cartesiano una arco di circonferenza di centro O e raggio r
%che va da ang1 and ang2 in radianti
%O  --> centro 2D della circonferenza
%r  --> raggio
%ang1,ang2 --> angolo iniziale e finale
%np --> numero di punti del disegno
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare, in ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%x,y <-- coordinate punti disegnati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta=abs((ang2-ang1))/(abs(np)-1);
c=cos(theta);
s=sin(theta);
x(1)=1;
y(1)=0;
for i=2:abs(np)
  x(i)=x(i-1)*c-y(i-1)*s;
  y(i)=x(i-1)*s+y(i-1)*c;
end
% x=r*x+O(1);
% y=r*y+O(2);
p=ones(3,abs(np));
p(1,:)=x;
p(2,:)=y;

R=get_mat2_rot(ang1);
q=R*p;

x=r*q(1,:)+O(1);
y=r*q(2,:)+O(2);

if (np > 0)
    mesh_curv2_plot(x,y,varargin{:});
end

return
