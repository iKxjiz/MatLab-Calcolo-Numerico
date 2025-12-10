function bezier = curv3_from_bezier_surf(surfbezier, fuv, uv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bezier = curv3_from_bezier_surf(surfbezier, fuv, uv)
%Determina una isocurva 3D di Bezier da una superficie 3D di Bezier
%surfbezier --> struttura di una superficie di Bezier:
%      surfbezier.deguv --> gradi della superficie in u e in v
%      surfbezier.cp --> griglia dei punti di controllo (degu+1)x(degv+1)x3
%      surfbezier.ab  --> intervallo di definizione in u
%      surfbezier.cd  --> intervallo di definizione in v
%fuv   --> direzione u o v; 1=estrae curva in u; 2=estrae curva in v
%uv    --> parametro u o v (a seconda di fuv) 
%          fuv=1 allora uv deve contenere un valore v=costante
%          fuv=2 allora uv deve contenere un valore u=costante
%bezier <-- struttura contenente l'isocurva di Bezier risultante:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo
%          bezier.ab  --> intervallo di definizione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ncpu,ncpv,dim]=size(surfbezier.cp);

%direzione di valutazione
if (fuv==2)
%Algoritmo2: usa de Casteljau
%calcola ncpv curve in u:=uv
Q=zeros(ncpu,3);
for j=1:ncpv
    Q=squeeze(surfbezier.cp(:,j,:));
    bezierA.cp= Q;
    bezierA.ab=[surfbezier.ab(1) surfbezier.ab(2)];
    bezierA.deg=surfbezier.deguv(1);
    R(j,:)=decast_val(bezierA,uv); 
end
    %struttura da restituire
    bezier.cp=R;
    bezier.ab=[surfbezier.cd(1) surfbezier.cd(2)];
    bezier.deg=surfbezier.deguv(2);

else
%Algoritmo2: usa de Casteljau
%calcola ncpu curve in v:=uv
    Q=zeros(ncpv,3);
    for i=1:ncpu
        Q=squeeze(surfbezier.cp(i,:,:));
        bezierA.cp= Q;
        bezierA.ab=[surfbezier.cd(1) surfbezier.cd(2)];
        bezierA.deg=surfbezier.deguv(2);
        R(i,:)=decast_val(bezierA,uv);
    end
        %struttura da restituire
        bezier.cp=R;
        bezier.ab=[surfbezier.ab(1) surfbezier.ab(2)];
        bezier.deg=surfbezier.deguv(1);
end

end

