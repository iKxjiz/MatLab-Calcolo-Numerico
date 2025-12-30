function vect3_plot(p,v,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vect3_plot(p,v,varargin)
%Disegna il vettore 3D definito dal punto 3D p e dal vettore 3D v
%p  --> punto 3D
%v  --> vettore 3D
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize,
%             ArrowFaceSize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%check sul numero di opzionali inseriti
numvarargs = length(varargin);
if numvarargs > 6
    error('Inserire al massimo 6 parametri opzionali');
end

%Default per i parametri opzionali
optargs = {'-k' 1 'k' [0.5,0.5,0.5] 6 0};

%Sovrascrivo in optargs gli opzionali specificati in varargin
optargs(1:numvarargs) = varargin;

[ls, lw, mec, mfc, ms, afs] = optargs{:};

x=[p(1),p(1)+v(1)];
y=[p(2),p(2)+v(2)];
z=[p(3),p(3)+v(3)];
plot3(x,y,z,ls,...
    'LineWidth',lw,...
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);
plot3(p(1),p(2),p(3),'ko',...
    'LineWidth',lw,...    
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor','k',...
    'MarkerSize',3);

if (v(1)~=0 || v(2)~=0)
    vort=[-v(2),v(1),0];
elseif (v(3)~=0)
    vort=[-v(3),0,v(1)];
else
    disp('v is a null vector');
    return
end

if (afs > 0)
    scv=afs*sin(pi/10);
    normv=norm(v);
    vn=v./normv;
    vnort=scv/normv.*vort;
    vn=v-afs/normv.*v;
    xf=p(1)+[v(1),vn(1)-vnort(1),vn(1)+vnort(1)];
    yf=p(2)+[v(2),vn(2)-vnort(2),vn(2)+vnort(2)];
    zf=p(3)+[v(3),vn(3)-vnort(3),vn(3)+vnort(3)];
    fill3(xf,yf,zf,ls);
else
    sc=0.9;
    scv=0.01*norm(v);
    xf=p(1)+[v(1),sc*v(1)-scv*vort(1),sc*v(1)+scv*vort(1),v(1)];
    yf=p(2)+[v(2),sc*v(2)-scv*vort(2),sc*v(2)+scv*vort(2),v(2)];
    zf=p(3)+[v(3),sc*v(3)-scv*vort(3),sc*v(3)+scv*vort(3),v(3)];
    plot3(xf,yf,zf,ls,...
        'LineWidth',lw,...    
        'MarkerEdgeColor',mec,...
        'MarkerFaceColor',mfc,...
        'MarkerSize',ms);
    end
end

