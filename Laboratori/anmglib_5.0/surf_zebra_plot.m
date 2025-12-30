function [x,y,z]=surf_zebra_plot(surfname,a,b,nu,c,d,nv,density)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=surf_curvatures_plot(surfname,a,b,nu,c,d,nv,density)
%Disegna le zebra lines di una superficie parametrica
%surfname --> nome del file con l'espressione parametrica 
%             della superficie
%a,b --> intervallo di definizione in u
%nu  --> numero di punti di valutazione in u
%c,d --> intervallo di definizione in v
%nv  --> numero di punti di valutazione in v
%density --> numero di strisce
%x,y,z <-- coordinate punti trasformati e plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
% figure(1); clf; hold on;
% axis equal; axis off;
% H = surf(x,y,z);
% light_green=[184, 224, 98]/255; % light green
% light_blue=[81, 168, 255]/255; % light blue
% 
% mycolor = light_blue;
% set(H, 'FaceColor', mycolor, 'EdgeColor', 'none', 'FaceAlpha', 1);
% % set(H, 'FaceColor', 'none', 'EdgeColor', 'k', 'FaceAlpha', 1);
% set(H, 'SpecularColorReflectance', 0.1, 'DiffuseStrength', 0.8);
% set(H, 'FaceLighting', 'phong', 'AmbientStrength', 0.3);
% set(H, 'SpecularExponent', 108);
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


% Stampa la superficie con le zebra lines
Eye = campos;   % campos ha le coordinate della posizione di visuale negli assi correnti
Eye = Eye/norm(Eye);
% plot3(Eye(1),Eye(2),Eye(3),'ro')
a = -1; b = 1; c = 0; 

switch nargin
    case 8
        d = density;
    case 7
        d=30;
end

s = (d-c)/(b-a);
t = c-a*(d-c)/(b-a);
for ii = 1:size(u,1)
    for jj = 1:size(u,2)
        n1 = ver(ii,jj).normal;
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

%figure(1)
%clf
for ii = 1:size(u,1)
    for jj = 1:size(u,2)
        bw = ver(ii,jj).color;
        Colors(ii,jj,:) = bw;
    end
end

%%%%%%%%%%%
H1 = surf(x,y,z,Colors);
set(H1,'FaceColor','interp','EdgeColor','none');
set(H1, 'SpecularColorReflectance', 0.1, 'DiffuseStrength', 0.8);
set(H1, 'FaceLighting', 'phong', 'AmbientStrength', 0.3);
set(H1, 'SpecularExponent', 108);

daspect([1 1 1]);
axis tight;
colormap(prism(28))
view(-12, 40);
title('Zebra lines della superficie parametrica')
% aggiunge una luce
% camlight (-50, 54);
% lighting phong;
% % lighting flat;
% 
% % hold off;
% axis equal
% axis off
% hold off
