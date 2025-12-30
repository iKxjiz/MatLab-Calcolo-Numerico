function SY=get_mat2_symm(P,Q)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function SY=get_mat2_symm(P,Q)
%Definisce la matrice 3x3 di simmetria assiale in base alla
%retta per i due punti 2D dati in input
%P,Q --> punti 2D che definiscono la retta di simmetria
%SY <-- matrice di simmetria
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 T = get_mat_trasl(-P);
 alfa = -atan2(Q(2) - P(2), Q(1) - P(1));
 R = get_mat2_rot(alfa);
 I = eye(3); 
 I(2,2)=-1;
 Rinv=R';
 Tinv=T;
 Tinv(1:2,3)=-Tinv(1:2,3);
 SY = Tinv*Rinv*I*R*T;
end