clear;
[P,F]=readplg('stanford_bunny.plg');


%Metatrepoume se morfh omogenwn
P_omogenhs=[P;ones(1,length(P(1,:)))];

%Monadiaios diagonios pinakas
I=diag(ones(1,3));

%Dianusmata metatopishs
t1=[-1 -1 3].';
t2=[1 1 -3].';
%Peristofh
fi=pi/2;
K=[4 -2 -3].';
g=[2 3 1].';

%1)ARXIKH 8ESH
title('Erwthmata 1,2,3 kai 4');
plotplg(P,F);

%2)METATOPISH
%8a kalesoume thn sunarthsh pou ektelei ton metasxhmatismo
%affine me pinaka metasxhmatismou ton L=I diagonio monadiaio
%kai metatopish ish me t1
P_tonos=pointtrans(P_omogenhs,I,t1);

plotplg(P_tonos(1:3,:),F);

%3)PERISTROFH GYRO APO SHMEIO K(4,-2,-3)
%Arxika 8a alla3oume stysthma suntetagmenwn(mono metatopish)
P_tonos=systemtrans(P_tonos,I,K);
%Pinakas Peristrofhs
R=rotmat(fi,g);
%Peristrofh
P_tonos=R*P_tonos;
%Epanafora sto arxiko systhma
P_tonos=systemtrans(P_tonos,I,-K);

plotplg(P_tonos(1:3,:),F);

%4)METATOPISH
P_tonos=pointtrans(P_tonos,I,t2);

plotplg(P_tonos(1:3,:),F);

%5)PROOPTIKH PROBOLH
cv=[-10 -20 -30].';
cx=[1 0 0].';
cy=[0 1 0].';
w=1;
%Prooptikh provolh
P_pro=project(w,cv,cx,cy,P_tonos);
%pros8etoume ta mhdekina sthn teleutaia grammh
P_pro=[P_pro ; zeros(1,length(P_pro))];
figure(2);
title('Erwthma 5');
plotplg(P_pro,F);

%6)PROOPTIKH PROBOLH_KU
cv=[-40 -10 -40].';
ck=[10 10 10].';
cu=[0 0 1].';
w=1;
%Prooptikh provolh
P_pro=projectKu(w,cv,ck,cu,P_tonos);
%pros8etoume ta mhdekina sthn teleutaia grammh
P_pro=[P_pro ; zeros(1,length(P_pro))];
figure(3);
title('Erwthma 6');
plotplg(P_pro,F);