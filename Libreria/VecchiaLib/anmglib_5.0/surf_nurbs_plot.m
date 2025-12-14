function [xx,yy,zz] = surf_nurbs_plot(surfnurbs, ni, nj, type, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xx,yy,zz] = surf_nurbs_plot(surfnurbs, ni, nj, type, varargin)
%Disegna una superficie 3D nurbs
%surfnurbs --> struttura di una superficie spline:
%      surfnurbs.deguv --> grado della superficie in u e in v
%      surfnurbs.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  --> vettore dei knot in u
%      surfnurbs.kv  --> vettore dei knot in v
%      surfnurbs.w --> griglia dei pesi (ncpu)x(ncpv)
%ni,nj --> numero di punti da plottare (nixnj) per ogni tratto 
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
[ncpu,ncpv,dim]=size(surfnurbs.cp);
nu=length(surfnurbs.ku);
nv=length(surfnurbs.kv);
%griglia di valutazione
[npu,uu]=gc_mesh(surfnurbs.deguv(1),surfnurbs.ku,ni);
[npv,vv]=gc_mesh(surfnurbs.deguv(2),surfnurbs.kv,nj);

for i=1:ncpu
 for j=1:ncpv
  x(i,j)=surfnurbs.cp(i,j,1);
  y(i,j)=surfnurbs.cp(i,j,2);
  z(i,j)=surfnurbs.cp(i,j,3);
 end
end

%Algoritmo1: usa B-spline
bsu=gc_bspl(surfnurbs.deguv(1),surfnurbs.ku,uu);
bsv=gc_bspl(surfnurbs.deguv(2),surfnurbs.kv,vv);
ww=bsu*surfnurbs.w*bsv';

xx=bsu*(surfnurbs.w.*x)*bsv';
yy=bsu*(surfnurbs.w.*y)*bsv';
zz=bsu*(surfnurbs.w.*z)*bsv';
xx=xx./ww;
yy=yy./ww;
zz=zz./ww;

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
