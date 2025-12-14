function R=get_mat2_rot(theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function R=get_mat2_rot(theta)
%Definisce la matrice 3x3 di rotazione 2D in base all'angolo
%theta in input
%theta --> angolo in radianti (scalare) 
%R     <-- matrice di rotazione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c=cos(theta);
s=sin(theta);
R=[c -s  0; 
   s  c  0; 
   0  0  1];
end