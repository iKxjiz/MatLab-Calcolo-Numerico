function surfspline = surf_spline_interp(Q,param,intu,intv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surfspline = surf_spline_interp(Q,param,intu,intv)
%Calcola la superficie spline cubica di interpolazione 
%di una griglia di punti 3D 
%Q           --> matrice (n punti in direzione u)x(m punti in direzione v)x3
%param       --> scelta della parametrizzazione
%                      0=uniforme, 1=centripeta, 2=corda
%intu        --> scelta dell'interpolazione in direzione u
%                      1=derivate agli estremi, 2=not-a-knot, 
%                      3=naturale, 4=periodica
%intv        --> scelta dell'interpolazione in direzione v
%                      1=derivate agli estremi, 2=not-a-knot, 
%                      3=naturale, 4=periodica
%surfspline  <-- struttura della superficie spline 
%       surfspline.deguv  <-- grado della spline in u e v (1x2)
%       surfspline.knotu  <-- partizione nodale estesa nella direzione u
%       surfspline.knotv  <-- partizione nodale estesa nella direzione v
%       surfspline.cp     <-- matrice 3D dei control point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = Q(:,:,1);
y = Q(:,:,2);
z = Q(:,:,3);
[npu,npv]=size(x);

%Gradi superficie (bicubica)
gv=3;
gu=3;
%Calcola parametrizzazione
[pu,pv] = surf_param(param, npu, npv, x, y, z);
%Calcola partizioni nodali superficie
switch intv
        case 1
            v=partition_der(pv);
        case 2 
            v=partition_nak(pv);
        case 3
            v=partition_nat(pv);
        case 4
            v=partition_per(pv);
end
switch intu
        case 1
            u=partition_der(pu);
        case 2 
            u=partition_nak(pu);
        case 3
            u=partition_nat(pu);
        case 4
            u=partition_per(pu);
end

%Interpolazione punti della griglia con curve nella direzione v
for i=1:npu
    R(:,1) = Q(i,:,1);
    R(:,2) = Q(i,:,2);
    R(:,3) = Q(i,:,3);
%GC290618 quando ciclo per i=1:npu si deve interpolare in v
    switch intv
        case 1          
            D(:,1) = scalar_derivatives(pv,R(:,1));
            D(:,2) = scalar_derivatives(pv,R(:,2));
            D(:,3) = scalar_derivatives(pv,R(:,3));
            cp = curv3_spline_cps_der(R,v,pv,D);
        case 2 
            cp = curv3_spline_cps_nak(R,v,pv);
        case 3
            cp = curv3_spline_cps_nat(R,v,pv);
        case 4
            cp = curv3_spline_cps_per(R,v);
    end
    C(i,:,1) = cp(:,1);
    C(i,:,2) = cp(:,2);
    C(i,:,3) = cp(:,3);
end


clear R;

%GC290618 dopo la prima batteria di interpolazioni, a seconda del metodo
%usato i punti da interpolare nella seconda passata possono essere cambiati
npv=length(C(1,:,1));

%Interpolazione punti griglia dei CP con curve nella direzione u
for j=1:npv
    R(:,1) = C(:,j,1);
    R(:,2) = C(:,j,2);
    R(:,3) = C(:,j,3);
%GC290618 quando ciclo per i=1:npv si deve interpolare in u
    switch intu
        case 1          
            D(:,1) = scalar_derivatives(pu,R(:,1));
            D(:,2) = scalar_derivatives(pu,R(:,2));
            D(:,3) = scalar_derivatives(pu,R(:,3));
            cp = curv3_spline_cps_der(R,u,pu,D);
        case 2 
            cp = curv3_spline_cps_nak(R,u,pu);
        case 3
            cp = curv3_spline_cps_nat(R,u,pu);
        case 4
            cp = curv3_spline_cps_per(R,u);
    end
    F(:,j,1) = cp(:,1);
    F(:,j,2) = cp(:,2);
    F(:,j,3) = cp(:,3);
end

surfspline.deguv(1)=gu;
surfspline.deguv(2)=gv;
surfspline.kv=v;
surfspline.ku=u;
surfspline.cp(:,:,1)=F(:,:,1);
surfspline.cp(:,:,2)=F(:,:,2);
surfspline.cp(:,:,3)=F(:,:,3);

end
