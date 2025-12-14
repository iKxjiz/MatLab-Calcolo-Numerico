function R=get_mat3_roty(theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function R=get_mat3_roty(theta)
%Definisce la matrice 4x4 di rotazione 3D intorno all'asse y
%in base all'angolo theta in input
%theta --> angolo in radianti (scalare) 
%R     <-- matrice di rotazione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c=cos(theta);
s=sin(theta);
R=[c 0 s 0;
   0 1 0 0;
  -s 0 c 0; 
   0 0 0 1];
end