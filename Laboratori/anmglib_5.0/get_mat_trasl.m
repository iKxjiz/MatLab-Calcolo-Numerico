function T=get_mat_trasl(d)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function T=get_mat_trasl(d)
%Definisce la matrice di 3x3 o 4x4 di traslazione in base al
%vettore d (2D o 3D) in input
%d --> vettore traslazione 2D o 3D
%T <-- matrice di traslazione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(d)==2
  T=[1  0  d(1);
     0  1  d(2);
     0  0    1];
end
if length(d)==3
  T=[1  0  0  d(1);
     0  1  0  d(2);
     0  0  1  d(3);
     0  0  0    1];
end
end