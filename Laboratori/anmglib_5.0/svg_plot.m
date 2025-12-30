function svg_plot(array_mdppbezier)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function array_mdppbezier=svg_plot(array_mdppbezier)
%Rappresenta un disegno SVG su una Figure Matlab
%array_mdppbezier --> array di strutture di curve di bezier a tratti multi degree:
%      array_mdppbezier(i).deg --> grado della curva
%      array_mdppbezier(i).cp  --> lista dei punti di controllo (bezier.deg+1) x2
%      array_mdppbezier(i).ab  --> intervallo di definizione
%      array_mdppbezier(i).senso --> senso di percorrenza della curva
%      array_mdppbezier(i).isContained --> 1/0 se contenuta in altra curva o meno
%      array_mdppbezier(i).transform --> stringa contenente comandi di trasformazione
%      array_mdppbezier(i).lc  --> colore del tratto/stroke del bordo
%      array_mdppbezier(i).lw  --> spessore del bordo
%      array_mdppbezier(i).fc  --> colore di riempimento/fill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:numel(array_mdppbezier)
    M = array_mdppbezier(i).transform;
    if ~isempty(M)
%GC 16/07/25 aggiunta per gestire comandi di trasformazione 
%e convertirli in matrici 3x3 di trasformazione
        if (ischar(M) || isstring(M))
          M = parseTransform(M);
        end
        array_mdppbezier(i).cp = point_trans(array_mdppbezier(i).cp, M);
    end
    lc=array_mdppbezier(i).lc;
    lw=100*array_mdppbezier(i).lw;
    fc=array_mdppbezier(i).fc;
%GC 25/02/25-Codice alternativo
    pp = curv2_mdppbezier_plot(array_mdppbezier(i), -100, Color.Code(lc), lw);
    if (length(array_mdppbezier(i).deg) > 1 || array_mdppbezier(i).deg > 1)
        if strcmp(lc, 'none')
            point_fill(pp, Color.Code(fc));
        else
            point_fill(pp, Color.Code(fc), Color.Code(lc), lw);
        end
    end
end
end