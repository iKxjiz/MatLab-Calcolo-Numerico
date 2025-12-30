function [xx,yy,zz,cc] = surf_nurbs_kurHK_plot(surfnurbs, ni, nj, cflag, colflag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xx,yy,zz,cc] = surf_nurbs_kurHK_plot(surfnurbs, ni, nj, cflag, colflag)
%Disegna curvatura media o Gaussiana di una superficie 3D nurbs
%surfnurbs --> struttura di una superficie nurbs:
%      surfnurbs.deguv --> grado della superficie in u e in v
%      surfnurbs.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  --> vettore dei knot in u
%      surfnurbs.kv  --> vettore dei knot in v
%      surfnurbs.w --> griglia dei pesi (ncpu)x(ncpv)
%ni,nj --> numero di punti da plottare (nixnj) per ogni tratto 
%cflag --> 1.curvatura media
%          2.curvatura Gaussiana
%colflag --> 1.valore della curvatura
%            2.segno della curvatura
%xx,yy,zz <-- coordinate dei punti plottati
%cc       <-- valore o segno di curvatura nei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%Coefficienti della prima forma fondamentale
E = xxu.*xxu + yyu.*yyu + zzu.*zzu;
F = xxu.*xxv + yyu.*yyv + zzu.*zzv;
G = xxv.*xxv + yyv.*yyv + zzv.*zzv;
%Coefficienti della seconda forma fondamentale
e = xxuu.*nnx + yyuu.*nny + zzuu.*nnz;
f = xxuv.*nnx + yyuv.*nny + zzuv.*nnz;
g = xxvv.*nnx + yyvv.*nny + zzvv.*nnz;

switch (cflag)
    case 1

    switch (colflag)
    case 1
      %curvatura Media
      figure
        clf
        title('Curvatura media')
        hold on
      cc=(e.*G-2.0.*f.*F+g.*E)./(2.0.*(E.*G-F.*F));
      auxcc=cc;
      auxcc(auxcc<=-1e+8)=0;
      auxcc(auxcc>=1e+8)=0;
      %per rimuovere i punti di singolarità numerica
      %mean=sum(auxcc,"all")/(npu*npv);
      effmax=max(auxcc,[],'all');
      effmin=min(auxcc,[],'all');
      cc(cc>=1e+8)=effmax;
      cc(isnan(cc))=effmax;
      cc(cc<=-1e+8)=effmin;
      cc=sign(cc).*sqrt(abs(cc));
      %cc(cc>=10*mean)=effmax;
      %cc(isnan(cc))=effmax;
      %cc(cc<=-10*mean)=effmin;
    case 2
      %segno della curvatura Media
      figure
        clf
        title('Segno della curvatura media')
        hold on
      cc=(e.*G-2.0.*f.*F+g.*E)./(2.0.*(E.*G-F.*F));
      auxcc=cc;
      auxcc(auxcc<=-1e+8)=0;
      auxcc(auxcc>=1e+8)=0;
      effmax=max(auxcc,[],'all');
      effmin=min(auxcc,[],'all');
      cc(cc>=1e+8)=effmax;
      cc(isnan(cc))=effmax;
      cc(cc<=-1e+8)=effmin;
      cc(cc>1e-2)=1;
      cc(-1e-2<=cc & cc<=1e-2)=0;
      cc(cc<-1e-2)=-1;
    end

    case 2

    switch (colflag)
    case 1
      %curvatura Gaussiana
      figure
        clf
        title('Curvatura Gaussiana')
        hold on
      cc=(e.*g-f.*f)./(E.*G-F.*F);
      auxcc=cc;
      auxcc(auxcc<=-1e+8)=0;
      auxcc(auxcc>=1e+8)=0;
      %per rimuovere i punti di singolarità numerica
      %mean=sum(auxcc,"all")/(npu*npv);
      effmax=max(auxcc,[],'all');
      effmin=min(auxcc,[],'all');
      cc(cc>=1e+8)=effmax;
      cc(isnan(cc))=effmax;
      cc(cc<=-1e+8)=effmin;
      cc=sign(cc).*sqrt(abs(cc));
      %cc(cc>=10*mean)=effmax;
      %cc(isnan(cc))=effmax;
      %cc(cc<=-10*mean)=effmin;
      
    case 2
      %segno della curvatura Gaussiana
      figure
        clf
        title('Segno della curvatura Gaussiana')
        hold on
      cc=(e.*g-f.*f)./(E.*G-F.*F);
      auxcc=cc;
      auxcc(auxcc<=-1e+8)=0;
      auxcc(auxcc>=1e+8)=0;
      effmax=max(auxcc,[],'all');
      effmin=min(auxcc,[],'all');
      cc(cc>=1e+8)=effmax;
      cc(isnan(cc))=effmax;
      cc(cc<=-1e+8)=effmin;
      cc(cc>1e-2)=1;
      cc(-1e-2<=cc & cc<=1e-2)=0;
      cc(cc<-1e-2)=-1;
    end

end


colormap(jet);
view(-12, 40);
s=surf(xx,yy,zz,cc);
s.EdgeColor='none';
if colflag==1
    colorbar
else
    L1 = plot(nan, nan, 'color', 'r');
    L2 = plot(nan, nan, 'color', 'b');
    L3 = plot(nan, nan, 'color', 'g');
    legend([L1, L3, L2], {'curvatura positiva', 'curvatura nulla','curvatura negativa'})
end

%   // Coefficienti della prima forma fondamentale
%   E = du[0]*du[0] + du[1]*du[1] + du[2]*du[2];
%   F = du[0]*dv[0] + du[1]*dv[1] + du[2]*dv[2];
%   G = dv[0]*dv[0] + dv[1]*dv[1] + dv[2]*dv[2];
%   // Coefficienti della seconda forma fondamentale
%   e = d2u[0]*nn[0] + d2u[1]*nn[1] + d2u[2]*nn[2];
%   f = duv[0]*nn[0] + duv[1]*nn[1] + duv[2]*nn[2];
%   g = d2v[0]*nn[0] + d2v[1]*nn[1] + d2v[2]*nn[2];
%   // Curvatura media H
%   // NOTA: e' stato messo un segno "-" davanti, per coerenza con la convenzione delle normali esterne e della scala di colori
%   // usualmente associata alla curvatura (positiva-rossi, negativa-blu)
%   HK[0] = -(e*G-2.0*f*F+g*E)/(2.0*(E*G-F*F));
%   // Curvatura gaussiana K
%   HK[1] = (e*g-f*f)/(E*G-F*F);


% % Stampa la superficie con le zebra lines
% Eye = campos;   % campos ha le coordinate della posizione di visuale negli assi correnti
% Eye = Eye/norm(Eye);
% % plot3(Eye(1),Eye(2),Eye(3),'ro')
% stripes_density = 30;
% a = -1; b = 1; c = 0; d = stripes_density;
% s = (d-c)/(b-a);
% t = c-a*(d-c)/(b-a);
% for ii = 1:npu
%     for jj = 1:npv
%         n1=ver(ii,jj).normal;
%         val = dot(Eye,n1);
%         newval = s*val+t;
%         if mod(int8(newval),2) == 0
%             bw = [0,0,0];
%         else
%             bw = [1,1,1];
%         end
%         ver(ii,jj).color = bw;
%     end
% end
% 
% figure()
% clf
% hold on
% for ii = 1:npu
%     for jj = 1:npv
%         bw = ver(ii,jj).color;
%         Colors(ii,jj,:) = bw;
%     end
% end
% 
% %%%%%%%%%%%
% H1 = surf(xx,yy,zz,Colors);
% set(H1,'FaceColor','interp','EdgeColor','none');
% title('Zebra lines della superficie NURBS')
% %%%%%%%%%%%
% 
% %%%%%%%%%%% la seguente parte serve se si usa il comando 'patch'  %%%%%%%%%%%
% % fvc = surf2patch(x,y,z,Colors);  % fvc.faces, fvc.vertices,fvc.facevertexcdata
% % H1 = patch(fvc);
% % cdata = fvc.facevertexcdata;
% % set(H1,'FaceColor','interp','FaceVertexCData',cdata,'EdgeColor','none','LineWidth',5,'CDataMapping','scaled') % try 'EdgeColor','interp'
% %%%%%%%%%%% end of patch-related code %%%%%%%%%%%
% set(H1, 'SpecularColorReflectance', 0.1, 'DiffuseStrength', 0.8);
% set(H1, 'FaceLighting', 'phong', 'AmbientStrength', 0.3);
% set(H1, 'SpecularExponent', 108);
% 
% daspect([1 1 1]);
% axis tight;
% colormap(prism(28))
% view(-12, 40);
% 
% % aggiunge una luce
% camlight (-50, 54);
% lighting phong;
% % lighting flat;
% 
% % hold off;
% axis equal
% axis off
% hold off
