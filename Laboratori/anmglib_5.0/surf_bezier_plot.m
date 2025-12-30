function [xx,yy,zz] = surf_bezier_plot(surfbezier, nu, nv, type, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xx,yy,zz] = surf_bezier_plot(surfbezier, nu, nv, type, varargin)
%Disegna una superficie 3D di Bezier
%surfbezier --> struttura di una superficie di Bezier:
%      surfbezier.deguv --> gradi della superficie in u e in v
%      surfbezier.cp --> griglia dei punti di controllo (degu+1)x(degv+1)x3
%      surfbezier.ab  --> intervallo di definizione in u
%      surfbezier.cd  --> intervallo di definizione in v
%nu,nv --> numero dei punti da plottare (nuxnv)
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
[ncpu,ncpv,dim]=size(surfbezier.cp);
%griglia di valutazione
u=linspace(surfbezier.ab(1),surfbezier.ab(2),nu);
v=linspace(surfbezier.cd(1),surfbezier.cd(2),nv);
uu=(u-surfbezier.ab(1))./(surfbezier.ab(2)-surfbezier.ab(1));
vv=(v-surfbezier.cd(1))./(surfbezier.cd(2)-surfbezier.cd(1));
%Algoritmo2: usa de Casteljau
%In alternativa calcola ncpu curve in u ed nv curve in v
R=zeros(ncpu,3);
Px=zeros(ncpu,nv,3);
for j=1:ncpu
    R=squeeze(surfbezier.cp(j,:,:));
    bez_v.cp= R;
    bez_v.ab=[surfbezier.cd(1) surfbezier.cd(2)];
%     bez_v.deg= surfbezier.deguv(1);
    Q=decast_valder(bez_v,0,vv);
    for i=1:nv
        Px(j,i,:)=Q(1,i,:);
    end
end
S=zeros(ncpu,3);
PPx=zeros(nu,nv,3);
for i=1:nv
    S=squeeze(Px(:,i,:));
    bez_u.cp=S;
    bez_u.ab=[surfbezier.ab(1) surfbezier.ab(2)];
%     bez_u.deg=surfbezier.deguv(2);
    T=decast_valder(bez_u,0,uu);  
    for j=1:nu
     PPx(j,i,:)=T(1,j,:);
    end    
end

xx=squeeze(PPx(:,:,1));
yy=squeeze(PPx(:,:,2));
zz=squeeze(PPx(:,:,3));


%Algoritmo1: usa base di Bernstein
%bsu=bernst_val(gu,uu);
%bsv=bernst_val(gv,vv);
%
%xx=bsu*x*bsv';
%yy=bsu*y*bsv';
%zz=bsu*z*bsv';

%Algoritmo2: usa de Casteljau
%calcola ncpv curve in v ed nu curve in u
% R=zeros(ncpu,3);
% Px=zeros(nu,ncpv,3);
% for j=1:ncpv
%     R=squeeze(surfbezier.cp(:,j,:));
%     bez_v.cp= R;
%     bez_v.ab=[surfbezier.ab(1) surfbezier.ab(2)];
%     bez_v.deg= surfbezier.deguv(2);
%     Q=decast_valder(bez_v,0,uu);
%     for i=1:nu
%         Px(i,j,:)=Q(1,i,:);
%     end
% end
% S=zeros(ncpu,3);
% PPx=zeros(nu,nv,3);
% for i=1:nu
%     S=squeeze(Px(i,:,:));
%     bez_u.cp=S;
%     bez_u.ab=[surfbezier.cd(1) surfbezier.cd(2)];
%     bez_u.deg=surfbezier.deguv(1);
%     T=decast_valder(bez_u,0,vv);  
%     for j=1:nv
%      PPx(i,j,:)=T(1,j,:);
%     end    
% end

%disegna superficie in modalita' wire-frame
mesh_surf_plot(xx,yy,zz,type,varargin{:});
view(45,30)

end
