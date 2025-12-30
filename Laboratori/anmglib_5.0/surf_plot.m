function [x,y,z]=surf_plot(surfname,a,b,nu,c,d,nv,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=surf_plot(surfname,a,b,nu,c,d,nv,type,varargin)
%Disegna una superficie
%surfname --> nome del file con l'espressione parametrica 
%             della superficie
%a,b --> intervallo di definizione in u
%nu  --> numero di punti di valutazione in u
%c,d --> intervallo di definizione in v
%nv  --> numero di punti di valutazione in v
%x,y,z <-- coordinate punti plottati
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLightning: 'flat', 'gouraud', 'none', 'phong' 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

surfn=str2func(surfname);
u=linspace(a,b,nu);
v=linspace(c,d,nv);
for i=1:nu
   for j=1:nv
        [x(i,j),y(i,j),z(i,j)]=surfn(u(i),v(j));
    end
end
mesh_surf_plot(x,y,z,type,varargin{:});

end

