clear;
%1)SHMEIA
p1=[0 0 0].';
p2=[1 0 0].';
p3=[1 1 0].';
p4=[0 1 0].';

P=[p1 p2 p3 p4];
P_omogenhs=[P;ones(1,length(P(1,:)))];

display('ARXIKES SYNTETAGMENES');
display(P);

%Monadiaios diagonios pinakas
I=diag(ones(1,3));

%Dianusmata metatopishs
t1=[-1 -1 3].';
t2=[1 1 -3].';
%Peristofh
fi=pi/2;
K=[4 -2 -3].';
g=[2 3 1].';

%2)METATOPISH
%8a kalesoume thn sunarthsh pou ektelei ton metasxhmatismo
%affine me pinaka metasxhmatismou ton L=I diagonio monadiaio
%kai metatopish ish me t1
P_tonos=pointtrans(P_omogenhs,I,t1);
display('METATOPISH');
display(P_tonos);

%3)PERISTROFH GYRO APO SHMEIO K(4,-2,-3)
%Arxika 8a alla3oume stysthma suntetagmenwn(mono metatopish)
P_tonos=systemtrans(P_tonos,I,K);
%Pinakas Peristrofhs
R=rotmat(fi,g);
%Peristrofh
P_tonos=R*P_tonos;
%Epanafora sto arxiko systhma
P_tonos=systemtrans(P_tonos,I,-K);
display('PERISTROFH');
display(P_tonos);

%4)METATOPISH
P_tonos=pointtrans(P_tonos,I,t2);
display('METATOPISH');
display(P_tonos);
