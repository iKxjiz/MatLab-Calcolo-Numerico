function [x,y,z]=surf_kurHK_plot(surfname,a,b,nu,c,d,nv,cflag,colflag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=surf_kurHK_plot(surfname,a,b,nu,c,d,nv,cflag,colflag)
%Disegna curvatura media o Gaussiana di una superficie parametrica
%surfname --> nome del file con l'espressione parametrica 
%             della superficie
%a,b --> intervallo di definizione in u
%nu  --> numero di punti di valutazione in u
%c,d --> intervallo di definizione in v
%nv  --> numero di punti di valutazione in v
%cflag--> tipo di curvatura
%         1.curvatura media
%         2.curvatura Gaussiana
%colflag --> 1.radice della curvatura
%            2.segno della curvatura
%x,y,z <-- coordinate punti trasformati e plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
surfn=str2func(surfname);

syms upar vpar
[sx,sy,sz]=surfn(upar,vpar);

dsx_u = diff(sx,upar);
dsy_u = diff(sy,upar);
dsz_u = diff(sz,upar);

dsx_v = diff(sx,vpar);
dsy_v = diff(sy,vpar);
dsz_v = diff(sz,vpar);

dsx_uu = diff(sx,upar,2);
dsy_uu = diff(sy,upar,2);
dsz_uu = diff(sz,upar,2);

dsx_vv = diff(sx,vpar,2);
dsy_vv = diff(sy,vpar,2);
dsz_vv = diff(sz,vpar,2);

dsx_uv = diff(dsx_u,vpar);
dsy_uv = diff(dsy_u,vpar);
dsz_uv = diff(dsz_u,vpar);

sx = matlabFunction(sx,'Vars',{upar,vpar});
sy = matlabFunction(sy,'Vars',{upar,vpar});
sz = matlabFunction(sz,'Vars',{upar,vpar});

dsx_u = matlabFunction(dsx_u,'Vars',{upar,vpar});
dsy_u = matlabFunction(dsy_u,'Vars',{upar,vpar});
dsz_u = matlabFunction(dsz_u,'Vars',{upar,vpar});

dsx_v = matlabFunction(dsx_v,'Vars',{upar,vpar});
dsy_v = matlabFunction(dsy_v,'Vars',{upar,vpar});
dsz_v = matlabFunction(dsz_v,'Vars',{upar,vpar});

dsx_uu = matlabFunction(dsx_uu,'Vars',{upar,vpar});
dsy_uu = matlabFunction(dsy_uu,'Vars',{upar,vpar});
dsz_uu = matlabFunction(dsz_uu,'Vars',{upar,vpar});

dsx_vv = matlabFunction(dsx_vv,'Vars',{upar,vpar});
dsy_vv = matlabFunction(dsy_vv,'Vars',{upar,vpar});
dsz_vv = matlabFunction(dsz_vv,'Vars',{upar,vpar});

dsx_uv = matlabFunction(dsx_uv,'Vars',{upar,vpar});
dsy_uv = matlabFunction(dsy_uv,'Vars',{upar,vpar});
dsz_uv = matlabFunction(dsz_uv,'Vars',{upar,vpar});


% Stampa la superficie
uu = linspace(a,b,nu); 
vv = linspace(c,d,nv);
[u,v] = meshgrid(uu,vv);

x = sx(u,v);
y = sy(u,v); 
z = sz(u,v);
figure(1); clf; hold on;
axis equal; axis off;
H = surf(x,y,z);
title('Superficie parametrica')
light_green=[184, 224, 98]/255; % light green
light_blue=[81, 168, 255]/255; % light blue

mycolor = light_blue;
set(H, 'FaceColor', mycolor, 'EdgeColor', 'none', 'FaceAlpha', 1);
% set(H, 'FaceColor', 'none', 'EdgeColor', 'k', 'FaceAlpha', 1);
set(H, 'SpecularColorReflectance', 0.1, 'DiffuseStrength', 0.8);
set(H, 'FaceLighting', 'phong', 'AmbientStrength', 0.3);
set(H, 'SpecularExponent', 108);

daspect([1 1 1]);
axis tight;
colormap(prism(28))
view(-12, 40);

% aggiunge una luce
camlight (-50, 54);
lighting phong;
% lighting flat;

% hold off;


% Stampa i vettori normali nei punti di valutazione della griglia
for ii = 1:size(u,1)
    for jj = 1:size(u,2)
        u1 = u(ii,jj); v1 = v(ii,jj);
        du = [dsx_u(u1,v1),dsy_u(u1,v1),dsz_u(u1,v1)];
        dv = [dsx_v(u1,v1),dsy_v(u1,v1),dsz_v(u1,v1)];
        n1 = cross(du,dv);
        ver(ii,jj).normal = n1/norm(n1);
    end
end


% % Stampa la superficie con le zebra lines
% Eye = campos;   % campos ha le coordinate della posizione di visuale negli assi correnti
% Eye = Eye/norm(Eye);
% % plot3(Eye(1),Eye(2),Eye(3),'ro')
% stripes_density = 30;
% a = -1; b = 1; c = 0; d = stripes_density;
% s = (d-c)/(b-a);
% t = c-a*(d-c)/(b-a);
% for ii = 1:size(u,1)
%     for jj = 1:size(u,2)
%         n1 = ver(ii,jj).normal;
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
% figure(2)
% clf
% hold on
% for ii = 1:size(u,1)
%     for jj = 1:size(u,2)
%         bw = ver(ii,jj).color;
%         Colors(ii,jj,:) = bw;
%     end
% end
% 
% %%%%%%%%%%%
% H1 = surf(x,y,z,Colors);
% set(H1,'FaceColor','interp','EdgeColor','none');
%%%%%%%%%%%

%%%%%%%%%%% la seguente parte serve se si usa il comando 'patch'  %%%%%%%%%%%
% fvc = surf2patch(x,y,z,Colors);  % fvc.faces, fvc.vertices,fvc.facevertexcdata
% H1 = patch(fvc);
% cdata = fvc.facevertexcdata;
% set(H1,'FaceColor','interp','FaceVertexCData',cdata,'EdgeColor','none','LineWidth',5,'CDataMapping','scaled') % try 'EdgeColor','interp'
%%%%%%%%%%% end of patch-related code %%%%%%%%%%%
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


% Calcolo di curvature media e Gaussiana

for ii = 1:size(u,1)
    for jj = 1:size(u,2)
        u1 = u(ii,jj); v1 = v(ii,jj);        
        du = [dsx_u(u1,v1),dsy_u(u1,v1),dsz_u(u1,v1)];
        dv = [dsx_v(u1,v1),dsy_v(u1,v1),dsz_v(u1,v1)];
        d2u = [dsx_uu(u1,v1),dsy_uu(u1,v1),dsz_uu(u1,v1)];
        d2v = [dsx_vv(u1,v1),dsy_vv(u1,v1),dsz_vv(u1,v1)];
        duv =  [dsx_uv(u1,v1),dsy_uv(u1,v1),dsz_uv(u1,v1)];
        nn = cross(du,dv);
        nn = nn/norm(nn);

        % Coefficienti della prima forma fondamentale
        E = du(1)*du(1) + du(2)*du(2) + du(3)*du(3);
        F = du(1)*dv(1) + du(2)*dv(2) + du(3)*dv(3);
        G = dv(1)*dv(1) + dv(2)*dv(2) + dv(3)*dv(3);
        % Coefficienti della seconda forma fondamentale
        e = d2u(1)*nn(1) + d2u(2)*nn(2) + d2u(3)*nn(3);
        f = duv(1)*nn(1) + duv(2)*nn(2) + duv(3)*nn(3);
        g = d2v(1)*nn(1) + d2v(2)*nn(2) + d2v(3)*nn(3);
        
        % H curvatura media
        H = (e*G-2.0*f*F+g*E)/(2.0*(E*G-F*F));
        
        % K curvatura Gaussiana
        K = (e*g-f*f)/(E*G-F*F);

% % Curvature principali k1,k2
% R = sqrt(H*H-K);
% k1 = H+R;
% k2 = H-R;

        ver(ii,jj).CGauss = K;
        ver(ii,jj).CMean = H;
    end
end


% Stampa della curvatura

switch (cflag)

    case 1

    switch (colflag)

        case 1
        %curvatura Media
        figure
        clf
        title('Curvatura media')
        hold on
        clear Colors
        for ii = 1:size(u,1)
            for jj = 1:size(u,2)
                col = ver(ii,jj).CMean;
                Colors(ii,jj) = sign(col)*sqrt(abs(col));
                %Colors(ii,jj) = col;
            end
        end

        case 2
        %segno della curvatura
        figure
        clf
        title('Segno della curvatura media')
        hold on
        clear Colors
            for ii = 1:size(u,1)
            for jj = 1:size(u,2)
                col = ver(ii,jj).CMean;
                Colors(ii,jj) = col;

                Colors(Colors>1e-2)=1;
                Colors(-1e-2<=Colors & Colors<=1e-2)=0;
                Colors(Colors<-1e-2)=-1;

            end
            end
    end

    case 2

    switch (colflag)

        case 1
        %curvatura Gaussiana
        figure
        clf
        title('Curvatura Gaussiana')
        hold on
        clear Colors
        for ii = 1:size(u,1)
            for jj = 1:size(u,2)
                col = ver(ii,jj).CGauss;
                Colors(ii,jj) = sign(col)*sqrt(abs(col));
                %Colors(ii,jj) = col;
            end
        end

        case 2
        %segno della curvatura
        figure
        clf
        title('Segno della curvatura Gaussiana')
        hold on
        clear Colors   
        for ii = 1:size(u,1)
        for jj = 1:size(u,2)
            col = ver(ii,jj).CGauss;
            Colors(ii,jj) = col;

            Colors(Colors>1e-2)=1;
            Colors(-1e-2<=Colors & Colors<=1e-2)=0;
            Colors(Colors<-1e-2)=-1;
        end
        end
    end

end

%disegna superficie e curvatura

%%%%%%%%%%
H2 = surf(x,y,z,Colors);
colormap jet%(256)
if colflag==1
    colorbar
else
    L1 = plot(nan, nan, 'color', 'r');
    L2 = plot(nan, nan, 'color', 'b');
    L3 = plot(nan, nan, 'color', 'g');
    legend([L1, L3, L2], {'curvatura positiva', 'curvatura nulla','curvatura negativa'})
end
set(H2,'EdgeColor','none','Facecolor','flat','CDataMapping','scaled');

%%%%%%%%%%

% %%%%%%%%%%%  la seguente parte serve se si usa il comando 'patch'      %%%%%%%%%%%
% fvc = surf2patch(x,y,z,Colors);  % fvc.faces, fvc.vertices,fvc.facevertexcdata
% H2 = patch(fvc);
% colormap jet(256)
% colorbar
% set(H2,'FaceColor','interp','EdgeColor','none','LineWidth',5,'CDataMapping','scaled')
% %%%%%%%%%%% end of patch-related code                     %%%%%%%%%%%

set(H2, 'SpecularColorReflectance', 0.1, 'DiffuseStrength', 0.8);
set(H2, 'FaceLighting', 'phong', 'AmbientStrength', 0.3);
set(H2, 'SpecularExponent', 108);

daspect([1 1 1]);
axis tight;
view(-12, 40);

% aggiunge una luce
camlight (-50, 54);
lighting phong;
% lighting flat;

% hold off;
axis equal
axis off

end