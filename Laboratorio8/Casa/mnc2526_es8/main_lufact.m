%main script iniziale da completare

fprintf('mat_k  nxn         max|l_ij|     max|u_ij|    2^(n-1)max|a_ij|\n');
nn=[5,10,50];
for n=nn
        for k=11:14
                A=def_mat(k,n);

                %fattorizza la matrice A
                [L,U,P]=lu(A);
                % disp('matrice L');
                % disp(L)
                % disp('matrice U');
                % disp(U)
                % disp('matrice P');
                % disp(P)

                % massimo elemento della matrice L in valore assoluto
                maxl=max(max(abs(L)));
                % massimo elemento della matrice U in valore assoluto
                maxu=max(max(abs(U)));
                % bound teorico per la matrice U
                bound=2^(n-1)*max(max(abs(A)));
                % stampa
                fprintf('%5d %2dx%2d  %14.5f  %14.5e  %14.5e\n',k,n,n,maxl,maxu,bound);
        end
end
