function [xx,yy,zz] = surf_spline_plot(surfspline, ni, nj, type, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xx,yy,zz] = surf_spline_plot(surfspline, ni, nj, type, varargin)
%Disegna una superficie 3D spline
%surfspline --> struttura di una superficie spline:
%      surfspline.deguv --> grado della superficie in u e in v
%      surfspline.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfspline.ku  --> vettore dei knot in u
%      surfspline.kv  --> vettore dei knot in v
%ni,nv --> numero di punti da plottare (nixnj) per ogni tratto 
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname 
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLightning: 'flat', 'gouraud', 'none', 'phong' 
%xx,yy,zz <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ncpu,ncpv,dim]=size(surfspline.cp);
nu=length(surfspline.ku);
nv=length(surfspline.kv);
%griglia di valutazione
[npu,uu]=gc_mesh(surfspline.deguv(1),surfspline.ku,ni);
[npv,vv]=gc_mesh(surfspline.deguv(2),surfspline.kv,nj);

for i=1:ncpu
 for j=1:ncpv
  x(i,j)=surfspline.cp(i,j,1);
  y(i,j)=surfspline.cp(i,j,2);
  z(i,j)=surfspline.cp(i,j,3);
 end
end

%Algoritmo1: usa B-spline
bsu=gc_bspl(surfspline.deguv(1),surfspline.ku,uu);
bsv=gc_bspl(surfspline.deguv(2),surfspline.kv,vv);

xx=bsu*x*bsv';
yy=bsu*y*bsv';
zz=bsu*z*bsv';

%Algoritmo2: usa de Boor
%TODO

%disegna superficie in modalita' wire-frame
mesh_surf_plot(xx,yy,zz,type,varargin{:});
view(45,30)
%mesh(xx,yy,zz);

% %disegna superficie in modalita' shading
% surface=surf(xx,yy,zz)
% shading interp;
% view(45,30)
% lightangle(45,30);
% lightangle(225,30);
% set(gcf,'Renderer','zbuffer');
% lighting phong;
% set(surface,'SpecularColorReflectance',0,'SpecularExponent',50);

% %se richiesto disegna i punti di controllo
% flag=0;
% if (flag)
%   plot3(x,y,z,col);
%   plot3(x',y',z',col);
end
