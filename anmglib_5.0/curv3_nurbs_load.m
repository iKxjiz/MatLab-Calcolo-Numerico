function nurbs=curv3_nurbs_load(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [g, P, W t]=curv3_nurbs_load(filename)
%Legge una curva 3D nurbs da file
%filename --> nome del file di estensione .db
%nurbs <-- struttura formata da 4 campi:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp x3)
%          nurbs.knot  --> vettore dei nodi (ncp+nurbs.deg+1)
%          nurbs.w --> lista dei pesi (ncp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen(filename,'r');
ss=fscanf(fid,'%s',1);
ss=fscanf(fid,'%s',1);

nurbs.deg=fscanf(fid,'%5d',1);    %grado 

ss=fscanf(fid,'%s',1);

ncp=fscanf(fid,'%5d',1);   %num. control point

ss=fscanf(fid,'%s',1);
nurbs.cp=zeros(ncp,2);
nurbs.w=zeros(ncp,1);

nt=fscanf(fid,'%5d',1);    %num. nodi

ss=fscanf(fid,'%s',1);
for i=1:ncp
  xs=fscanf(fid,'%s',1);
  ys=fscanf(fid,'%s',1);
  zs=fscanf(fid,'%s',1);
  ws=fscanf(fid,'%s',1);
  nurbs.cp(i,1)=str2num(xs);
  nurbs.cp(i,2)=str2num(ys);
  nurbs.cp(i,3)=str2num(zs);
  nurbs.w(i,1)=str2num(ws);
end  

ss=fscanf(fid,'%s',1);
for i=1:nt
    ts=fscanf(fid,'%s',1);
    nurbs.knot(i)=str2num(ts);
end   

status=fclose(fid);
