function [xx,yy,zz] = surf_spline_zebra_plot(surfspline, ni, nj, density)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xx,yy,zz] = surf_spline_zebra_plot(surfspline, ni, nj, density)
%Disegna le zebra lines di una superficie 3D spline
%surfspline --> struttura di una superficie spline:
%      surfspline.deguv --> grado della superficie in u e in v
%      surfspline.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfspline.ku  --> vettore dei knot in u
%      surfspline.kv  --> vettore dei knot in v
%ni,nj --> numero di punti da plottare (nixnj) per ogni tratto
%density --> numero di strisce
%xx,yy,zz <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
Bu=gc_bspl_valder(surfspline.deguv(1),surfspline.ku,uu,2);
Bv=gc_bspl_valder(surfspline.deguv(2),surfspline.kv,vv,2);

for i=1:npu
    for j=1:ncpu
        bsu(i,j)=Bu(1,i,j);
        du(i,j)=Bu(2,i,j);
        duu(i,j)=Bu(3,i,j);
    end
end


for i=1:npv
    for j=1:ncpv
        bsv(i,j)=Bv(1,i,j);
        dv(i,j)=Bv(2,i,j);
        dvv(i,j)=Bv(3,i,j);
    end
end


xx=bsu*x*bsv';
yy=bsu*y*bsv';
zz=bsu*z*bsv';

xxu=du*x*bsv';
yyu=du*y*bsv';
zzu=du*z*bsv';

xxv=bsu*x*dv';
yyv=bsu*y*dv';
zzv=bsu*z*dv';

xxuu=duu*x*bsv';
yyuu=duu*y*bsv';
zzuu=duu*z*bsv';

xxvv=bsu*x*dvv';
yyvv=bsu*y*dvv';
zzvv=bsu*z*dvv';

xxuv=du*x*dv';
yyuv=du*y*dv';
zzuv=du*z*dv';

for i=1:npu
    for j=1:npv
        A=[xxu(i,j),yyu(i,j),zzu(i,j)];
        B=[xxv(i,j),yyv(i,j),zzv(i,j)];
        N=cross(A,B);
        N=N./norm(N,2);
        nnx(i,j)=N(1);
        nny(i,j)=N(2);
        nnz(i,j)=N(3);
        ver(i,j).normal = N/norm(N);
    end
end

% Stampa la superficie con le zebra lines
Eye = campos;   % campos ha le coordinate della posizione di visuale negli assi correnti
Eye = Eye/norm(Eye);
% plot3(Eye(1),Eye(2),Eye(3),'ro')
a = -1; b = 1; c = 0;
switch nargin
    case 4
        d = density;
    case 3
        d=30;
end
s = (d-c)/(b-a);
t = c-a*(d-c)/(b-a);
for ii = 1:npu
    for jj = 1:npv
        n1=ver(ii,jj).normal;
        val = dot(Eye,n1);
        newval = s*val+t;
        if mod(int8(newval),2) == 0
            bw = [0,0,0];
        else
            bw = [1,1,1];
        end
        ver(ii,jj).color = bw;
    end
end

%figure()
%clf
%hold on
for ii = 1:npu
    for jj = 1:npv
        bw = ver(ii,jj).color;
        Colors(ii,jj,:) = bw;
    end
end

%%%%%%%%%%%
H1 = surf(xx,yy,zz,Colors);
set(H1,'FaceColor','interp','EdgeColor','none');
%%%%%%%%%%%

%%%%%%%%%%% la seguente parte serve se si usa il comando 'patch'  %%%%%%%%%%%
% fvc = surf2patch(x,y,z,Colors);  % fvc.faces, fvc.vertices,fvc.facevertexcdata
% H1 = patch(fvc);
% cdata = fvc.facevertexcdata;
% set(H1,'FaceColor','interp','FaceVertexCData',cdata,'EdgeColor','none','LineWidth',5,'CDataMapping','scaled') % try 'EdgeColor','interp'
%%%%%%%%%%% end of patch-related code %%%%%%%%%%%
set(H1, 'SpecularColorReflectance', 0.1, 'DiffuseStrength', 0.8);
set(H1, 'FaceLighting', 'phong', 'AmbientStrength', 0.3);
set(H1, 'SpecularExponent', 108);

daspect([1 1 1]);
axis tight;
colormap(prism(28))
view(-12, 40);

% aggiunge una luce
camlight (-50, 54);
lighting phong;
% lighting flat;

% hold off;
axis equal
axis off
hold off
