clear all
close all


%grafic settings
open_figure(1);
hold on;
grid("on");

%faccio la spirale con
p = linspace(-3*pi,pi/2,41);


t = linspace(0, 10*pi, 1000); % Parametro da 0 a 10π
a = 0.1; % Fattore di scala
b = 9; % Fattore di crescita

for i=1:41
    [Crf(i,1),Crf(i,2)]=c2_circle(p(i),(a+b*t(i)));
    CrfNeg = -Crf;
    point_plot(Crf);
    point_plot(CrfNeg,'r');
end

%bez a tratti della spirale

%inizializzo la join

X =Crf(1:5,1:2);
bezCrfIniz =curv2_bezier_interp(X,0,1,2);
curv2_ppbezier_plot(bezCrfIniz,60,'r');
bezCrfIniz
%bezCrfIniz=curv2_bezier_de(bezCrfIniz,1);

%prima

X1 =Crf(5:9,1:2);
bezCrfIniz1 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz1,60,'r');
bezCrfIniz1
bezCrfIniz12 = curv2_mdppbezier_join(bezCrfIniz1,bezCrfIniz,1.0e-4);
%seconda

X1 =Crf(9:13,1:2);
bezCrfIniz2 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz2,60,'r');
bezCrfIniz2
bezCrfIniz21 = curv2_mdppbezier_join(bezCrfIniz2,bezCrfIniz12,1.0e-4);


%terza


X1 =Crf(13:17,1:2);
bezCrfIniz1 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz1,60,'r');
bezCrfIniz1
bezCrfIniz12 = curv2_mdppbezier_join(bezCrfIniz1,bezCrfIniz21,1.0e-4);

%quarta

X1 =Crf(17:21,1:2);
bezCrfIniz2 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz2,60,'r');
bezCrfIniz2
bezCrfIniz21 = curv2_mdppbezier_join(bezCrfIniz2,bezCrfIniz12,1.0e-4);

%curv2_ppbezier_plot(bezCrfIniz21,60,'g',3);



%quinta
X1 =Crf(21:25,1:2);
bezCrfIniz1 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz1,60,'r');
bezCrfIniz1
bezCrfIniz12 = curv2_mdppbezier_join(bezCrfIniz1,bezCrfIniz21,1.0e-4);

%sesta

X1 =Crf(25:29,1:2);
bezCrfIniz2 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz2,60,'r');
bezCrfIniz2
bezCrfIniz21 = curv2_mdppbezier_join(bezCrfIniz2,bezCrfIniz12,1.0e-4);


%settima


X1 =Crf(29:33,1:2);
bezCrfIniz1 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz1,60,'r');
bezCrfIniz1
bezCrfIniz12 = curv2_mdppbezier_join(bezCrfIniz1,bezCrfIniz21,1.0e-4);

%ottava

X1 =Crf(33:37,1:2);
bezCrfIniz2 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz2,60,'r');
bezCrfIniz2
bezCrfIniz21 = curv2_mdppbezier_join(bezCrfIniz2,bezCrfIniz12,1.0e-4);

%curv2_ppbezier_plot(bezCrfIniz21,60,'g',3);


%nona
X1 =Crf(37:41,1:2);
bezCrfIniz1 =curv2_bezier_interp(X1,0,1,2);
curv2_ppbezier_plot(bezCrfIniz1,60,'r');
bezCrfIniz12 = curv2_mdppbezier_join(bezCrfIniz1,bezCrfIniz21,1.0e-4);

curv2_ppbezier_plot(bezCrfIniz12,60,'g',3);
bezCrfIniz12
%bezCrfIniz12 curva a tratti della spirale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%faccio un crf di centro il punto della spirale e raggio la distanza dal
%punto successivo

%prendo il punto della spirale
m = linspace(0,2*pi,16);
raggio = 0.1;
for i=1:41

    %raggio = sqrt((Crf(i,1)-Crf(i+1,1))^2+(Crf(i,2)-Crf(i+1,2)^2));
    %raggio = (a+b*t(i));
    raggio = (a+b*t(i))/7;
    [Cerchio(:,1),Cerchio(:,2)]=c2_circle(m,raggio);
    CerchioN=-Cerchio;
    Cerchio=Cerchio+[Crf(i,1) Crf(i,2)];
    CerchioN = CerchioN+[CrfNeg(i,1) CrfNeg(i,2)];
    %cerchi positivi
    bezCer =curv2_bezier_interp(Cerchio,0,1,0);
    xy = curv2_ppbezier_plot(bezCer,60,'k');
    fill(xy(:,1),xy(:,2),'r');
    curv2_ppbezier_plot(bezCer,60,'b',2);

    %cerchi negativi
    bezCerN =curv2_bezier_interp(CerchioN,0,1,0);
    xy = curv2_ppbezier_plot(bezCerN,60,'k');
    fill(xy(:,1),xy(:,2),'r');
    curv2_ppbezier_plot(bezCerN,60,'b',2);

end

%circonferenza di centro l'origine e raggio unitario
function [x,y]=c2_circle(t,r)
%r raggio
%t angolo
x=r*cos(t);
y=r*sin(t);
end