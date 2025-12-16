%**************************************************
%script scompute_u.m
%Gestisce sia il caso BASIC single che BASIC double
%flag: 0 per BASIC single
%      1 per BASIC double
%**************************************************
clear
clc

%cambiare il flag
flag1=0;
flag2=1;

if (flag1==0)
    %****************************************************
    %BASIC single   F(2,24,-127,128)
    %Definizione esplicita di U:        U = 0.5* 2^(1-24)
    %****************************************************
    %stampa di u, def. esplicita
    u = single(2^(-24));
    fprintf("Basic Single \n");
    fprintf('Explicit definition: u = 2^(-24)\n');
    fprintf('%13.8e \n',u);

    %****************************************************
    %calcolo dell'unita' di arrotondamento (U) via
    %caratterizzazione o definizione operativa.
    %****************************************************
    u=single(1);
    t=0;
    while(1+u > 1) % l'ultimo valore di u che soddisfa 1+u > 1 è proprio U
        u=u/2;
        %fprintf("t : %f \n", t);
        t=t+1;
    end
    %stampa di u, caratterizzazione
    fprintf('Largest Finite and Positive Number u such that u+1==1\n');
    fprintf('U in decimale ha valore : %13.8e \n',u);
    fprintf('Exponent (in base 2) -%d\n',t);

end

fprintf("==============================================\n");

if (flag2==1)
    %******************************************************
    %BASIC double   F(2,53,-1023,1024)
    %Definizione esplicita di U:          U = 0.5* 2^(1-53)
    %******************************************************
    %stampa di u, def. esplicita
    u = 2^(-53);
    fprintf("Basic Double \n");
    fprintf('Explicit definition: u = 2^(-53)\n');
    fprintf('%20.15e \n',u);

    %******************************************************
    %calcolo dell'unita' di arrotondamento (U) via
    %caratterizzazione o definizione operativa.
    %******************************************************
    u=1;
    t=0;
    while(1+u > 1)
        u=u/2;
        %fprintf("t : %f \n", t);
        t=t+1;
    end
    %stampa di u, caratterizzazione
    fprintf('Largest Finite and Positive Number u such that u+1==1\n');
    fprintf('U in decimale ha valore : %20.15e\n',u);
    fprintf('Exponent (in base 2) -%d\n',t);
end