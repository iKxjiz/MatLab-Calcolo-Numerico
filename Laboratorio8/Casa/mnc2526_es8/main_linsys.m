%Script main_linsys.m
%Questo script risolveun sistema lineare in più modi

%chiama una funzione che definisce una matrice test
A=def_mat(14,5); % vedi def_mat per compredere la struttura della funzione

%sia n la sua dimensione
[n,m]=size(A);

%stampa della matrice A
disp(A);

%si definisce un vettore xs soluzione
%per es. xs=ones(n,1) e lo si visualizzi
xs=ones(n,1);
% xs=[1,2,3]';
disp(xs);

%si determina il vettore dei termini noti
b=A*xs;

%Si risolve il sistema lineare con operatore left-division di MATLAB
x1=A\b;
%si stampa la soluzione x1
disp(x1);

%si fattorizza la matrice A con function lu di MATLAB
[L,U,P]=lu(A);
disp('matrice L');
disp(L)
disp('matrice U');
disp(U)
disp('matrice P');
disp(P)

%si risolvono i sistemi piu' semplici
y=lsolve(L,P*b);
x2=usolve(U,y);

%si stampa la soluzione x2
disp(x2);
