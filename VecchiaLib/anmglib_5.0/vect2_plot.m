function vect2_plot(p,v,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vect2_plot(p,v,varargin)
%Disegna il vettore 2D definito dal punto 2D p e dal vettore v
%p  --> punto 2D
%v  --> vettore 2D
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
plot(x,y,ls,...
    'LineWidth',lw,...
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);
plot(p(1),p(2),'k-o',...
    'LineWidth',lw,...    
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);

if (afs > 0)
    scv=afs*sin(pi/10);
    normv=norm(v);
    vn=v./normv;
    vnort=scv.*[-vn(2),vn(1)];
    vn=v-afs/normv.*v;
    xf=p(1)+[v(1),vn(1)-vnort(1),vn(1)+vnort(1)];
    yf=p(2)+[v(2),vn(2)-vnort(2),vn(2)+vnort(2)];
    fill(xf,yf,ls);
else
    vort=[-v(2),v(1)];
    sc=0.9;
    tc=0.01;
    scv=0.01*norm(v);
    xf=p(1)+[v(1),sc*v(1)-scv*vort(1),sc*v(1)+scv*vort(1),v(1)];
    yf=p(2)+[v(2),sc*v(2)-scv*vort(2),sc*v(2)+scv*vort(2),v(2)];
    plot(xf,yf,ls,...
        'LineWidth',lw,...    
        'MarkerEdgeColor',mec,...
        'MarkerFaceColor',mfc,...
        'MarkerSize',ms);
end
end

