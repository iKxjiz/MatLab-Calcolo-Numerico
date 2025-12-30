function spline  =curv2_spline_load(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline = curv2_spline_load(filename)
%Legge una curva 2D spline da file
%filename --> nome del file di estensione .db
%spline <-- struttura di una curva spline:
%          spline.deg <-- grado della curva
%          spline.cp  <-- lista dei punti di controllo (ncp)x2 
%          spline.knot <-- vettore dei nodi (ncp+g+1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen(filename,'r');
ss=fscanf(fid,'%s',1);
ss=fscanf(fid,'%s',1);

spline.deg=fscanf(fid,'%5d',1);    %grado 

ss=fscanf(fid,'%s',1);

ncp=fscanf(fid,'%5d',1);   %num. control point
spline.cp=zeros(ncp,2);

ss=fscanf(fid,'%s',1);

nt=fscanf(fid,'%5d',1);    %num. nodi

ss=fscanf(fid,'%s',1);
for i=1:ncp
  xs=fscanf(fid,'%s',1);
  ys=fscanf(fid,'%s',1);
  spline.cp(i,1)=str2num(xs);
  spline.cp(i,2)=str2num(ys);
end  

ss=fscanf(fid,'%s',1);
for i=1:nt
    ts=fscanf(fid,'%s',1);
    spline.knot(i)=str2num(ts);
end   

status=fclose(fid);
