function R=get_mat3_rotz(theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function R=get_mat3_rotz(theta)
%Definisce la matrice 4x4 di rotazione 3D intorno all'asse z
%in base all'angolo theta in input
%theta --> angolo in radianti (scalare) 
%R     <-- matrice di rotazione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c=cos(theta);
s=sin(theta);
R=[c -s 0 0;
   s  c 0 0; 
   0  0 1 0;
   0  0 0 1];
end