function [xx,yy,zz] = solid_box_plot(a,b,nu,nv,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xx,yy,zz] = solid_box_plot(a,b,nu,nv,type,varargin)
%Disegna un solido elementare: box
%si tratta di un box definito da due vertici opposti;
%a,b --> punti 3D che definiscono i vertici opposti del box
%nu,nv  --> numero punti griglia di valutazione per ogni faccia
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLightning: 'flat', 'gouraud', 'none', 'phong'
%xx,yy,zz <-- coordinate dei ppunti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u=linspace(0,1,nu);
v=linspace(0,1,nv);
xmin=min([a(1),b(1)]);
ymin=min([a(2),b(2)]);
zmin=min([a(3),b(3)]);
xmax=max([a(1),b(1)]);
ymax=max([a(2),b(2)]);
zmax=max([a(3),b(3)]);
%costruiamo il vettore degli 8 vertici del box
x=[xmin,xmin,xmax,xmax,xmin,xmin,xmax,xmax];
y=[ymin,ymax,ymax,ymin,ymin,ymax,ymax,ymin];
z=[zmin,zmin,zmin,zmin,zmax,zmax,zmax,zmax];
f=zeros(6,5);
f(1,:)=[3,4,8,7,3];
f(2,:)=[2,3,7,6,2];
f(3,:)=[1,2,6,5,1];
f(4,:)=[4,1,5,8,4];
f(5,:)=[1,4,3,2,1];
f(6,:)=[7,6,5,8,7];
g=[3,4;1,8];

%disegno delle 6 facce
% for i=1:6
%   patch(x(f(i,:)),y(f(i,:)),z(f(i,:)),col);
% end

for k=1:6
  for i=1:nu
      px=u(i)*x(f(k,1))+(1-u(i))*x(f(k,2));
      qx=u(i)*x(f(k,4))+(1-u(i))*x(f(k,3));
      py=u(i)*y(f(k,1))+(1-u(i))*y(f(k,2));
      qy=u(i)*y(f(k,4))+(1-u(i))*y(f(k,3));
      pz=u(i)*z(f(k,1))+(1-u(i))*z(f(k,2));
      qz=u(i)*z(f(k,4))+(1-u(i))*z(f(k,3));
      for j=1:nv
          xx(i,j)=v(j)*px+(1-v(j))*qx;
          yy(i,j)=v(j)*py+(1-v(j))*qy;
          zz(i,j)=v(j)*pz+(1-v(j))*qz;          
      end
  end
  mesh_surf_plot(xx,yy,zz,type,varargin{:});
end

end
