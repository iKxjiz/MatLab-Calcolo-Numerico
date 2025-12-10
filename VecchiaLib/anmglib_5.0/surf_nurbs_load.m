function surfnurbs=surf_nurbs_load(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surfnurbs=surf_nurbs_load(filename)
%Legge una superficie 3D nurbs da file
%filename --> nome del file di estensione .db
%surfnurbs <-- struttura di una superficie spline:
%      surfnurbs.deguv <-- grado della superficie in u e in v
%      surfnurbs.cp <-- griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  <-- vettore dei knot in u
%      surfnurbs.kv  <-- vettore dei knot in v
%      surfnurbs.w <-- griglia dei pesi (ncpu)x(ncpv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen(filename,'r');
ss=fscanf(fid,'%s',1);
ss=fscanf(fid,'%s',1);

surfnurbs.deguv(1)=fscanf(fid,'%5d',1);    %grado in u
surfnurbs.deguv(2)=fscanf(fid,'%5d',1);

ss=fscanf(fid,'%s',1);

ncpu=fscanf(fid,'%5d',1);   %num. control point in u
ncpv=fscanf(fid,'%5d',1);

ss=fscanf(fid,'%s',1);

nu=fscanf(fid,'%5d',1);    %num. nodi in u
nv=fscanf(fid,'%5d',1);

surfnurbs.cp=zeros(ncpu,ncpv,3);
surfnurbs.w=zeros(ncpu,ncpv);
ss=fscanf(fid,'%s',1);
for i=1:ncpu
    for j=1:ncpv
  xs=fscanf(fid,'%s',1);
  ys=fscanf(fid,'%s',1);
  zs=fscanf(fid,'%s',1);
  ws=fscanf(fid,'%s',1);
%  x(i,j)=str2num(xs);
%  y(i,j)=str2num(ys);
%  z(i,j)=str2num(zs);
%  w(i,j)=str2num(ws);
  surfnurbs.cp(i,j,1)=str2num(xs);
  surfnurbs.cp(i,j,2)=str2num(ys);
  surfnurbs.cp(i,j,3)=str2num(zs);
  surfnurbs.w(i,j)=str2num(ws);
end
end  
ss=fscanf(fid,'%s',1);
for i=1:nu
    us=fscanf(fid,'%s',1);
    surfnurbs.ku(i)=str2num(us);
end   
ss=fscanf(fid,'%s',1);
for i=1:nv
    vs=fscanf(fid,'%s',1);
    surfnurbs.kv(i)=str2num(vs);
end   
status=fclose(fid);
