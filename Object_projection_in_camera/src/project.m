function P = project(w, cv, cx, cy, p)

N=length(p(1,:));
P=[];

%To trito dianusma prokyptei ws e3wteriko ginomeno twn allwn 2
cz=cross(cx,cy);
%Pinakas peristrofhs
R=[cx cy cz];
%O pinakas ths sxeshs 6.13 selida 76
D=[  R.'    -R.'*cv;...
   [0 0 0]    1  ];

for i=1:1:N
%Oi suntetagmenes ws prws to CCS einai
q=D*p(:,i);

%Apo thn sxesh 6.4 selida 73 exoume
J=[1 0 0 0;...
   0 1 0 0;...
   0 0 0 0;...
   0 0 1 0];
Zp=q(3);
P=[P (J*q).*(w/Zp)];

end
%Pernoume mono ta x kai y
P=P(1:2,1:N);
end

