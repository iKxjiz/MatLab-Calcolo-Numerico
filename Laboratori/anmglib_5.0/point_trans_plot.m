function q=point_trans_plot(p,M,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function q=point_trans_plot(p,M,varargin)
%Disegna punti, liste di punti o griglie di punti 2D e 3D dopo
%averli trasformati con la matrice M
%p  --> punto/i 2D o 3D
%M  --> matrice di trasformazione
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%q  <-- punto/i 2D o 3D trasformati
%ATTENZIONE: se i punti sono 2D la matrice deve essere 3x3,
%            se i punti 3D la matrice deve essere 4x4.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%check sul numero di opzionali inseriti
numvarargs = length(varargin);
if numvarargs > 5
    error('Inserire al massimo 5 parametri opzionali');
end

%default per i parametri opzionali
optargs = {'-k' 1 'k' [0.5,0.5,0.5] 6};

%sovrascrivo in optargs gli opzionali specificati in varargin
optargs(1:numvarargs) = varargin;

[ls, lw, mec, mfc, ms] = optargs{:};

[m,n,l]=size(p);
q=zeros(m,n,l);
[mm,nn]=size(M);
if (l==1)
  if (n==2 && mm==3)
    for i=1:m
     w=[p(i,1),p(i,2),1];
     w=(M*w')';
     q(i,1)=w(1);
     q(i,2)=w(2);
    end
  elseif (n==3 && mm==4)
    for i=1:m
     w=[p(i,1),p(i,2),p(i,3),1];
     w=(M*w')';     
     q(i,1)=w(1);
     q(i,2)=w(2);
     q(i,3)=w(3);
    end
  else
    disp('ERRORE: le dimensioni dei punti e della matrice non sono compatibili');
  end
else
  if (l==3 && mm==4)    
    for i=1:m
      for j=1:n
        w=[p(i,j,1),p(i,j,2),p(i,j,3),1];
        w=(M*w')';
        q(i,j,1)=w(1);
        q(i,j,2)=w(2);
        q(i,j,3)=w(3);
      end
    end
  else
    disp('ERRORE: le dimensioni dei punti e della matrice non sono compatibili');
  end
end

point_plot(q,varargin{:});
end

