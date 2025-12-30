function solid_trans_plot(solidname,nu,nv,M,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function solid_trans_plot(solidname,nu,nv,M,type,varargin)
%Disegna un solido definito per nome dopo aver applicato una
%matrice di trasformazione
%solidname --> Cube, Cylinder, Cone
%nu,nv  --> numero punti griglia di valutazione per ogni faccia
%M   --> matrice di trasformazione
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
   plane_trans_plot([1,0,0],[1,0,0],-1,1,-1,1,M,varargin{:});
   plane_trans_plot([0,1,0],[0,1,0],-1,1,-1,1,M,varargin{:});
   plane_trans_plot([0,0,1],[0,0,1],-1,1,-1,1,M,varargin{:});
   plane_trans_plot([-1,0,0],[-1,0,0],-1,1,-1,1,M,varargin{:});
   plane_trans_plot([0,-1,0],[0,-1,0],-1,1,-1,1,M,varargin{:});
   plane_trans_plot([0,0,-1],[0,0,-1],-1,1,-1,1,M,varargin{:});

  case 'Sphere'
%TODO

  case 'Cylinder'
syms v
%R=[cos(v), -sin(v), 0, 0;
%   sin(v),  cos(v), 0, 0;
%   0,       0,      1, 0;
%   0,       0,      0, 1];
%surf_from_curv_trans_plot('c3_line5',0,1,nu,R,0,2*pi,nv,M,'r',type);
surf_trans_plot('s_cylinder',0,2,nu,0,2*pi,nv,M,type,varargin{:});

S=[v, 0, 0, 0;
   0, v, 0, 0;
   0, 0, 1, 0;
   0, 0, 0, 1];
surf_from_curv_trans_plot('c3_circleXY',0,2*pi,nu,S,0,1,nv,M,type,varargin{:});

S=[v, 0, 0, 0;
   0, v, 0, 0;
   0, 0, 1, 2;
   0, 0, 0, 1];
surf_from_curv_trans_plot('c3_circleXY',0,2*pi,nu,S,0,1,nv,M,type,varargin{:});

  case 'Cone'
syms v
%R=[cos(v), -sin(v), 0, 0;
%   sin(v),  cos(v), 0, 0;
%   0,       0,      1, 0;
%   0,       0,      0, 1];
%surf_from_curv_trans_plot('c3_line4',0,1,nu,R,0,2*pi,nv,M,col,type);
surf_trans_plot('s_cone',0,2,nu,0,2*pi,nv,M,type,varargin{:});

S=[v, 0, 0, 0;
   0, v, 0, 0;
   0, 0, 1, 0;
   0, 0, 0, 1];
%surf_from_curv_trans_plot('c3_circleXY',0.5*pi,2.5*pi,nu,S,0,2,nv,M,col,type);
surf_from_curv_trans_plot('c3_circleXY',0,2*pi,nu,S,0,1,nv,M,type,varargin{:});
end

end
