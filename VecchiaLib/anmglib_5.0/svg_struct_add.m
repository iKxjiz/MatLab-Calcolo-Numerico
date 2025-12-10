function svg_struct = svg_struct_add(ppP,lc,lw,fc,svg_struct)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function svg_struct = svg_struct_add(ppP,lc,lw,fc)
%Aggiunge curve, con informazioni di disegno ad una struttura per sav
%ppP --> curva 2D di Bézier, Bézier a tratti o Bézier a tratti multi-degree
%lc  --> colore del tratto/stroke del bordo
%lw  --> spessore del bordo
%fc  --> colore di riempimento/fill
%svg_struct --> array di strutture di curve Bézier a tratti multi degree:
%svg_struct <-- array di strutture di curve di Bézier, Bézier a tratti e
%               Bézier a tratti multi degree:
%      svg_struct(i).deg <-- grado della curva
%      svg_struct(i).cp  <-- lista dei punti di controllo
%      svg_struct(i).ab  <-- intervallo/i di definizione
%      svg_struct(i).sense <-- senso di percorrenza della curva
%      svg_struct(i).isContained <-- 1/0 se contenuta in altra curva o meno
%      svg_struct(i).transform <-- stringa contenente comandi di trasformazione
%      svg_struct(i).lc  <-- colore del tratto/stroke del bordo
%      svg_struct(i).lw  <-- spessore del bordo
%      svg_struct(i).fc  <-- colore di riempimento/fill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (nargin==4)
        svg_struct=[];
    end
    if (length(ppP.deg)==1 && length(ppP.ab>2))
      ppP=curv2_ppbezier2mdppbezier(ppP);
    end
    i=numel(svg_struct)+1;
    svg_struct(i).deg=ppP.deg;
    svg_struct(i).cp=ppP.cp;
    svg_struct(i).ab=ppP.ab;
    svg_struct(i).sense=1;
    svg_struct(i).isContained="false";
    svg_struct(i).transform=[];
    svg_struct(i).lc=lc;
    svg_struct(i).lw=lw;
    svg_struct(i).fc=fc;
end


