function surfspline = surf_spline_load(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surfspline = surf_spline_load(filename)
%Legge una superficie 3D spline da file
%filename --> nome del file di estensione .db
%surfspline <-- struttura di una superficie spline:
%      surfspline.deguv <-- grado della superficie in u e in v
%      surfspline.cp <-- griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfspline.ku  <-- vettore dei knot in u
%      surfspline.kv  <-- vettore dei knot in v
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen(filename,'r');
ss=fscanf(fid,'%s',1);
ss=fscanf(fid,'%s',1);

surfspline.deguv(1)=fscanf(fid,'%5d',1);    %grado in u
surfspline.deguv(2)=fscanf(fid,'%5d',1);    %grado in v

ss=fscanf(fid,'%s',1);

ncpu=fscanf(fid,'%5d',1);   %num. control point in u
ncpv=fscanf(fid,'%5d',1);

ss=fscanf(fid,'%s',1);

nu=fscanf(fid,'%5d',1);    %num. nodi in u
nv=fscanf(fid,'%5d',1);

surfspline.cp=zeros(ncpu,ncpv,3);
ss=fscanf(fid,'%s',1);
for i=1:ncpu
    for j=1:ncpv
  xs=fscanf(fid,'%s',1);
  ys=fscanf(fid,'%s',1);
  zs=fscanf(fid,'%s',1);
  surfspline.cp(i,j,1)=str2num(xs);
  surfspline.cp(i,j,2)=str2num(ys);
  surfspline.cp(i,j,3)=str2num(zs);
end
end  
ss=fscanf(fid,'%s',1);
for i=1:nu
    us=fscanf(fid,'%s',1);
    surfspline.ku(i)=str2num(us);
end   
ss=fscanf(fid,'%s',1);
for i=1:nv
    vs=fscanf(fid,'%s',1);
    surfspline.kv(i)=str2num(vs);
end   
status=fclose(fid);
