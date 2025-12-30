%main script iniziale da completare

fprintf('mat_k  nxn         max|q_ij|     max|r_ij|    sqrt(n)*max|a_ij|\n');
nn=[5,10,50];
for n=nn
    for k=11:14
        A=def_mat(k,n);
        
        %fattorizza la matrice A
        [Q,R]=qr(A);
        % disp('matrice Q');
        % disp(Q)
        % disp('matrice R');
        % disp(R)

% massimo elemento della matrice Q in valore assoluto
        maxq=max(max(abs(Q)));
% massimo elemento della matrice R in valore assoluto
        maxr=max(max(abs(R)));
% Bound teorico per la matrice U
        bound=sqrt(n)*max(max(abs(A)));

        fprintf('%5d %2dx%2d  %14.5f  %14.5e  %14.5e\n',k,n,n,maxq,maxr,bound);
    end
end                
