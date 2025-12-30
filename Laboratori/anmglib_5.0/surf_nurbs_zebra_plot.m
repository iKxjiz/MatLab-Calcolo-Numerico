function [xx,yy,zz] = surf_nurbs_zebra_plot(surfnurbs, ni, nj, density)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%******
%function [xx,yy,zz] = surf_nurbs_zebra_plot(surfnurbs, ni, nj, density)
%Disegna le zebra lines di una superficie 3D nurbs
%surfnurbs --> struttura di una superficie spline:
%      surfnurbs.deguv --> grado della superficie in u e in v
%      surfnurbs.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  --> vettore dei knot in u
%      surfnurbs.kv  --> vettore dei knot in v
%      surfnurbs.w --> griglia dei pesi (ncpu)x(ncpv)
%ni,nj --> numero di punti da plottare (nixnj) per ogni tratto 
%density --> numero di strisce
%xx,yy,zz <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
Bu=gc_bspl_valder(surfnurbs.deguv(1),surfnurbs.ku,uu,2);
Bv=gc_bspl_valder(surfnurbs.deguv(2),surfnurbs.kv,vv,2);
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
ww=bsu*surfnurbs.w*bsv';
wx=surfnurbs.w.*x;
wy=surfnurbs.w.*y;
wz=surfnurbs.w.*z;

xx=bsu*wx*bsv';
yy=bsu*wy*bsv';
zz=bsu*wz*bsv';
xx=xx./ww;
yy=yy./ww;
zz=zz./ww;

xxu=du*wx*bsv'-xx.*(du*(surfnurbs.w)*bsv');
yyu=du*wy*bsv'-yy.*(du*(surfnurbs.w)*bsv');
zzu=du*wz*bsv'-zz.*(du*(surfnurbs.w)*bsv');
xxu=xxu./ww;
yyu=yyu./ww;
zzu=zzu./ww;

xxv=bsu*wx*dv'-xx.*(bsu*(surfnurbs.w)*dv');
yyv=bsu*wy*dv'-yy.*(bsu*(surfnurbs.w)*dv');
zzv=bsu*wz*dv'-zz.*(bsu*(surfnurbs.w)*dv');
xxv=xxv./ww;
yyv=yyv./ww;
zzv=zzv./ww;

xxuu=duu*wx*bsv'-2.*xxu.*(du*(surfnurbs.w)*bsv')-xx.*(duu*(surfnurbs.w)*bsv');
yyuu=duu*wy*bsv'-2.*yyu.*(du*(surfnurbs.w)*bsv')-yy.*(duu*(surfnurbs.w)*bsv');
zzuu=duu*wz*bsv'-2.*zzu.*(du*(surfnurbs.w)*bsv')-zz.*(duu*(surfnurbs.w)*bsv');
xxuu=xxuu./ww;
yyuu=yyuu./ww;
zzuu=zzuu./ww;

xxvv=bsu*wx*dvv'-2.*xxv.*(bsu*(surfnurbs.w)*dv')-xx.*(bsu*(surfnurbs.w)*dvv');
yyvv=bsu*wy*dvv'-2.*yyv.*(bsu*(surfnurbs.w)*dv')-yy.*(bsu*(surfnurbs.w)*dvv');
zzvv=bsu*wz*dvv'-2.*zzv.*(bsu*(surfnurbs.w)*dv')-zz.*(bsu*(surfnurbs.w)*dvv');
xxvv=xxvv./ww;
yyvv=yyvv./ww;
zzvv=zzvv./ww;

xxuv=du*wx*dv'-xxv.*(du*(surfnurbs.w)*bsv')-xxu.*(bsu*(surfnurbs.w)*dv')-xx.*(du*(surfnurbs.w)*dv');
yyuv=du*wy*dv'-yyv.*(du*(surfnurbs.w)*bsv')-yyu.*(bsu*(surfnurbs.w)*dv')-yy.*(du*(surfnurbs.w)*dv');
zzuv=du*wz*dv'-zzv.*(du*(surfnurbs.w)*bsv')-zzu.*(bsu*(surfnurbs.w)*dv')-zz.*(du*(surfnurbs.w)*dv');
xxuv=xxuv./ww;
yyuv=yyuv./ww;
zzuv=zzuv./ww;

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
title('Zebra lines della superficie NURBS')
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
