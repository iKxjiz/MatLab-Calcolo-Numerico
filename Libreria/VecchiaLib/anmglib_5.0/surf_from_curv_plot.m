function [x,y,z]=surf_from_curv_plot(curvname,a,b,nu,R,c,d,nv,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=surf_from_curv_plot(curvname,a,b,nu,R,c,d,nv,type,varargin)
%Disegna una superficie generata da una curva
%curvname --> nome del file con l'espressione parametrica della curva
%a,b --> intervallo di definizione in u
%nu  --> numero di punti di valutazione in u
%R --> matrice di trasformazione simbolica 4x4
%c,d --> intervallo di definizione in v
%nv  --> numero di punti di valutazione in v
%col --> colore di disegno
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname 
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLightning: 'flat', 'gouraud', 'none', 'phong' 
%x,y,z <-- coordinate punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curvn=str2func(curvname);
uu=linspace(a,b,nu);
vv=linspace(c,d,nv);
w=zeros(4,1);
for i=1:nu
   for j=1:nv
        %v=vv(j);
        %T=eval(R);
        T = eval(subs(R,symvar(R),vv(j)));
        [cx,cy,cz]=curvn(uu(i));
        w(1,1)=cx;
        w(2,1)=cy;
        w(3,1)=cz;
        w(4,1)=1;
        w=T*w;
        x(i,j)=w(1,1);
        y(i,j)=w(2,1);
        z(i,j)=w(3,1);
    end
end

mesh_surf_plot(x,y,z,type,varargin{:});
% switch type
% case 1
%    mesh(x,y,z);
% case 2
%    surf(x,y,z);
% case 3
%    surf(x,y,z,'FaceColor',gccol,'EdgeColor','none');
%    view(90,90);
%    camlight left;
%    lighting phong
% end
% %view(45,30);

end

