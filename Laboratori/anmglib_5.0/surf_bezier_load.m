function surfbezier=surf_bezier_load(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surfbezier=surf_bezier_load(filename)
%Legge una superficie 3D di Bezier da file
%filename --> nome del file di estensione .db
%surfbezier <-- struttura di una superficie di Bezier:
%      surfbezier.deguv <-- gradi della superficie in u e in v
%      surfbezier.cp <-- griglia dei punti di controllo (degu+1)x(degv+1)x3
%      surfbezier.ab  <-- intervallo di definizione in u
%      surfbezier.cd  <-- intervallo di definizione in v
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen(filename,'r');
ss=fscanf(fid,'%s',1);
ss=fscanf(fid,'%s',1);

surfbezier.deguv(1)=fscanf(fid,'%5d',1);    %grado in u
surfbezier.deguv(2)=fscanf(fid,'%5d',1);    %grado in v 

surfbezier.cp=zeros(surfbezier.deguv(1)+1,surfbezier.deguv(2)+1,3);
ss=fscanf(fid,'%s',1);
for i=1:surfbezier.deguv(1)+1
    for j=1:surfbezier.deguv(2)+1
  xs=fscanf(fid,'%s',1);
  ys=fscanf(fid,'%s',1);
  zs=fscanf(fid,'%s',1);
  surfbezier.cp(i,j,1)=str2num(xs);
  surfbezier.cp(i,j,2)=str2num(ys);
  surfbezier.cp(i,j,3)=str2num(zs);
end
end  

ss=fscanf(fid,'%s',1);
as=fscanf(fid,'%s',1);
surfbezier.ab(1)=str2num(as);
bs=fscanf(fid,'%s',1);
surfbezier.ab(2)=str2num(bs);

ss=fscanf(fid,'%s',1);
cs=fscanf(fid,'%s',1);
surfbezier.cd(1)=str2num(cs);
ds=fscanf(fid,'%s',1);
surfbezier.cd(2)=str2num(ds);

status=fclose(fid);
end