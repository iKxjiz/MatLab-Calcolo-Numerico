function A=def_mat(imat,n)
%*******************************************************
%function che definisce matrici test ad elementi reali 
% imat --> indice della matrice test
% A    <-- matrice test
%*******************************************************
if (nargin<2)
    n=10;
end
switch imat
    case 1
        A=[2, 1, 0;
           4, 5, 2;
           6, 15, 12];
    case 2
        A=[4, -8, 2;
           2, -4, 6;
           1, -1, 3];
    case 3
        A=[2, 3, 0;
           4, 1, 4;
           6, 3, 3];
    case 4
        A=[0, 2, 3;
           4, 5, 6;
           7, 8, 9];
    case 5
        A=[2,  -0.5, 0, -0.5;
           0,   4,   0,  2;
          -0.5, 0,   6,  0.5;
           0,   0,   1,  9];
    case 6
        A=[4, 3, 2, 1;
           1, 4, 3, 2;
           1, 1, 4, 3;
           1, 1, 1, 4];
    case 7
        A=[1.0e-20, 1;
           1       , 1];
    case 8
        A=[4, 0, 1, 1;
           3, 1, 3, 1;
           0, 1, 2, 0;
           2, 2, 4, 1];
    case 9
        h=1.0e-7;
        A=[1,  1,  1;
           2,  2+h,  5;
           4,  6,  8];
    case 10
        A=[72, -144, -144;
          -144, -36, -360;
          -144, -360, 450];
    case 11
         for j=1:n
           A(1,j)=1.0;
         end
         for i=1:n
           for j=1:n
              A(i,j)=1.0/(i+j+1.0);
           end
         end
    case 12
         for i=1:n
           for j=1:i
             A(i,j)=n-1-i;
             A(j,i)=A(i,j);
           end
         end
    case 13
         for i=1:n
           for j=1:n
              if (i>=j)
	            A(i,j)=i;
              else
                A(i,j)=j;
              end
           end
         end
    case 14
        A=eye(n);
        A(1,n)=1;
        for i=2:n
          A(i,n)=1;
          for j=1:i-1
             A(i,j)=-1;
          end
        end
end
end





