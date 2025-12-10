function [x,y,z] = plane_plot(n,O,a,b,c,d,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z] = plane_plot(n,O,a,b,c,d,varargin)
%Disegna un piano 3D come O+uv1+vv2 con u in [a,b], v in [c,d]
%e v1 v2 vettori giacitura determinati conoscendo la normale n
%n   --> vettore normale 3D
%O   --> punto 3D
%a,b --> intervallo parametrico in u
%c,d --> intervallo parametrico in v
%varargin --> specificare le proprieta' del disegno, in ordine:
%             FaceColor('none','flat','interp',colorname), EdgeColor('none','flat','interp',colorname), 
%             FaceLightning ('flat', 'gouraud', 'none','phong') 
%[x,y,z] <-- coordinate dei punti plottati.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%check sul numero di argomenti opzionali
numvarargs = length(varargin);
if numvarargs > 3
  error('Inserire al massimo 3 parametri opzionali');
end   

%se non sono specificati valori, set default
optargs = {'flat' 'k' 'none'};
optargs(1:numvarargs) = varargin;
[fc,ec,fl] = optargs{:};
        
n=n./norm(n,2);
if (n(1)~=0 || n(2)~=0)
    v1=[-n(2),n(1),0];
elseif (n(3)~=0)
    v1=[-n(3),0,n(1)];
else
    disp('vettore nullo');
    return
end
v2=cross(n,v1);
vv1=v1./norm(v1,2);
vv2=v2./norm(v2,2);

x=O(1)+[b*vv1(1)+d*vv2(1), d*vv2(1)+a*vv1(1), c*vv2(1)+a*vv1(1), c*vv2(1)+b*vv1(1), b*vv1(1)+d*vv2(1)];
y=O(2)+[b*vv1(2)+d*vv2(2), d*vv2(2)+a*vv1(2), c*vv2(2)+a*vv1(2), c*vv2(2)+b*vv1(2), b*vv1(2)+d*vv2(2)];
z=O(3)+[b*vv1(3)+d*vv2(3), d*vv2(3)+a*vv1(3), c*vv2(3)+a*vv1(3), c*vv2(3)+b*vv1(3), b*vv1(3)+d*vv2(3)];

%plot3(x,y,z,'k');
patch('XData',x,'YData',y,'ZData',z,'FaceColor',fc,'EdgeColor',ec,'Facelighting',fl);
%patch(x,y,z,'FaceColor',fc,'EdgeColor',ec,'Facelighting',fl);
%plot3(O(1),O(2),O(3),'bo','MarkerSize',6,'MarkerFaceColor','b');
%vect3_plot(O,n,'b');
%%vect3_plot(O,vv1,'g');
%%vect3_plot(O,vv2,'g');
end

