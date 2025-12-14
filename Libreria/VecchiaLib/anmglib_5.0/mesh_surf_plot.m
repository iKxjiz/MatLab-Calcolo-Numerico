function mesh_surf_plot( x, y, z, type, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mesh_surf_plot( x, y, z, col, type, varargin )
%Disegna una mesh di punti 3D
%x,y,z --> coordinate della mesh 3D (x,y,z sono matrici nxm) 
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname 
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLighting: 'flat', 'gouraud', 'none', 'phong' 
%Esempio di chiamata:
%mesh_surf_plot( x, y, z, 'r', 3, 'flat', 'k', 'none' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  switch type    
    case 1
       mesh(x,y,z);
   
    case 2
       surf(x,y,z);   
    
    % case per la personalizzazione dell'aspetto della surf
    case 3
        
        %check sul numero di argomenti opzionali
        numvarargs = length(varargin);
        if numvarargs > 3
          error('Inserire al massimo 3 parametri opzionali');
        end   
        
        %se non sono specificati valori, set default
        optargs = {'flat' 'k' 'none'};
        
        optargs(1:numvarargs) = varargin;
        [fc,ec,fl] = optargs{:};
        
        surf(x,y,z,'FaceColor',fc,'EdgeColor',ec,'FaceLighting',fl);
        
        %set light
        camlight('headlight');        
  end

end

