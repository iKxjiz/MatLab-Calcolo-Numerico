function [x,y,z]=surf_transf_plot(surfname,a,b,nu,c,d,nv,M,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=surf_trans_plot(surfname,a,b,nu,c,d,nv,M,type,varargin)
%Disegna una superficie dopo aver applicato la trasformazione M
%surfname --> nome del file con l'espressione parametrica 
%             della superficie
%a,b --> intervallo di definizione in u
%nu  --> numero di punti di valutazione in u
%c,d --> intervallo di definizione in v
%nv  --> numero di punti di valutazione in v
%M --> matrice di trasformazione 4x4
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname 
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLightning: 'flat', 'gouraud', 'none', 'phong' 
%x,y,z <-- coordinate punti trasformati e plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
surfn=str2func(surfname);
u=linspace(a,b,nu);
v=linspace(c,d,nv);
for i=1:nu
   for j=1:nv
        [xx,yy,zz]=surfn(u(i),v(j));
        ww=(M*[xx,yy,zz,1]')';
        x(i,j)=ww(1);
        y(i,j)=ww(2);
        z(i,j)=ww(3);
    end
end
mesh_surf_plot(x,y,z,type,varargin{:});

end

