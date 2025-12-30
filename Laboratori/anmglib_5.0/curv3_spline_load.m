function spline=curv3_spline_load(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv3_spline_load(filename)
%Legge una curva 3D spline da file
%filename --> nome del file di estensione .db
%spline <-- struttura formata di una curva spline:
%          spline.deg <-- grado della curva
%          spline.cp  <-- lista dei punti di controllo (ncp)x3 
%          spline.knot  <-- vettore dei nodi (ncp+g+1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen(filename,'r');
ss=fscanf(fid,'%s',1);
ss=fscanf(fid,'%s',1);

spline.deg=fscanf(fid,'%5d',1);    %grado 

ss=fscanf(fid,'%s',1);

ncp=fscanf(fid,'%5d',1);   %num. control point
P=zeros(ncp,2);

ss=fscanf(fid,'%s',1);

nt=fscanf(fid,'%5d',1);    %num. nodi

ss=fscanf(fid,'%s',1);
for i=1:ncp
  xs=fscanf(fid,'%s',1);
  ys=fscanf(fid,'%s',1);
  zs=fscanf(fid,'%s',1);
  spline.cp(i,1)=str2num(xs);
  spline.cp(i,2)=str2num(ys);
  spline.cp(i,3)=str2num(zs);
end  

ss=fscanf(fid,'%s',1);
for i=1:nt
    ts=fscanf(fid,'%s',1);
    spline.knot(i)=str2num(ts);
end   

status=fclose(fid);
