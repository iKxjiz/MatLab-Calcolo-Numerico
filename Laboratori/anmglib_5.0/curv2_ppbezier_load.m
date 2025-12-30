function P=curv2_ppbezier_load(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function P=curv2_ppbezier_load(filename)
%Legge una curva 2D di Bezier a tratti da file
%filename --> nome del file di estensione .db
%P <-- struttura formata da tre campi:
%      P.deg <-- grado della curva o di ogni tratto
%      P.cp  <-- lista dei punti di controllo (nc*P.deg+1) x 2
%      P.ab  <-- partizione di [a,b]; nc + 1 elementi
%Nota: nc viene letto dal file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid=fopen(filename,'r');
ss=fscanf(fid,'%s',1);
ss=fscanf(fid,'%s',1);
nc=fscanf(fid,'%5d',1);    %numero di curve 
ss=fscanf(fid,'%s',1);
P.deg=fscanf(fid,'%5d',1); %grado 
ncp=nc*P.deg+1;
P.cp=zeros(ncp,2);
P.ab=zeros(1,nc+1);
ss=fscanf(fid,'%s',1);
for i=1:ncp
  xs=fscanf(fid,'%s',1);
  ys=fscanf(fid,'%s',1);
  P.cp(i,1)=str2num(xs); %control_point
  P.cp(i,2)=str2num(ys); 
end
ss=fscanf(fid,'%s',1);
for i=1:nc+1
  as=fscanf(fid,'%s',1);
  P.ab(i)=str2num(as);
end
status=fclose(fid);
