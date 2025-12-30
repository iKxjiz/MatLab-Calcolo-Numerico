function solid_plot(solidname,nu,nv,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function solid_plot(solidname,nu,nv,type,varargin)
%Disegna un solido definito per nome 
%solidname --> Cube, Cylinder, Cone
%nu,nv  --> numero punti griglia di valutazione per ogni faccia
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname 
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLightning: 'flat', 'gouraud', 'none', 'phong' 
%NB: nel caso 'cube' l'argomento type non viene considerato, set type=3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch solidname
  case 'Cube'
   plane_plot([1,0,0],[1,0,0],-1,1,-1,1,varargin{:});
   plane_plot([0,1,0],[0,1,0],-1,1,-1,1,varargin{:});
   plane_plot([0,0,1],[0,0,1],-1,1,-1,1,varargin{:});
   plane_plot([-1,0,0],[-1,0,0],-1,1,-1,1,varargin{:});
   plane_plot([0,-1,0],[0,-1,0],-1,1,-1,1,varargin{:});
   plane_plot([0,0,-1],[0,0,-1],-1,1,-1,1,varargin{:});

  case 'Sphere'
%TODO

  case 'Cylinder'
syms v
%R=[cos(v), -sin(v), 0, 0;
%   sin(v),  cos(v), 0, 0;
%   0,       0,      1, 0;
%   0,       0,      0, 1];
%surf_from_curv_plot('c3_line5',0,1,nu,R,0,2*pi,nv,'r',type);
surf_plot('s_cylinder',0,2,nu,0,2*pi,type,varargin{:});

S=[v, 0, 0, 0;
   0, v, 0, 0;
   0, 0, 1, 0;
   0, 0, 0, 1];
surf_from_curv_plot('c3_circleXY',0,2*pi,nu,S,0,1,nv,type,varargin{:});

S=[v, 0, 0, 0;
   0, v, 0, 0;
   0, 0, 1, 2;
   0, 0, 0, 1];
surf_from_curv_plot('c3_circleXY',0,2*pi,nu,S,0,1,nv,type,varargin{:});

  case 'Cone'
syms v
%R=[cos(v), -sin(v), 0, 0;
%   sin(v),  cos(v), 0, 0;
%   0,       0,      1, 0;
%   0,       0,      0, 1];
%surf_from_curv_plot('c3_line4',0,1,nu,R,0,2*pi,nv,col,type);
surf_plot('s_cone',0,2,nu,0,2*pi,nv,type,varargin{:});

S=[v, 0, 0, 0;
   0, v, 0, 0;
   0, 0, 1, 0;
   0, 0, 0, 1];
%surf_from_curv_plot('c3_circleXY',0.5*pi,2.5*pi,nu,S,0,2,nv,col,type);
surf_from_curv_plot('c3_circleXY',0,2*pi,nu,S,0,1,nv,type,varargin{:});
end

end
