function S=get_mat_scale(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function S=get_mat_scale(s)
%Definisce la matrice di 3x3 o 4x4 di scala in base al
%vettore d (2D o 3D) in input
%s --> vettore di scala 2D o 3D
%S <-- matrice di scala
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(s)==2
  S=[s(1) 0    0;
     0    s(2) 0;
     0    0    1];
end
if length(s)==3
  S=[s(1) 0    0    0;
     0    s(2) 0    0;
     0    0    s(3) 0;
     0    0    0    1];
end
end