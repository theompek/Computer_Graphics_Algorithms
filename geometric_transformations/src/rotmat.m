function  R = rotmat( a,u )
%Gia ta a kai u prepei a se rad kai u monadiaio dianusma
u=u./norm(u);

%Gia eukolia 8etoume
Ux=u(1);
Uy=u(2);
Uz=u(3);

%To pikana peristrofhs ton upologizoume symfwna me ton 
%typo 5.45 twn shmeiwn sthn selida 62

R=[(1-cos(a))*Ux*Ux+cos(a) (1-cos(a))*Ux*Uy-sin(a)*Uz (1-cos(a))*Ux*Uz+sin(a)*Uy ;...
   
   (1-cos(a))*Uy*Ux+sin(a)*Uz (1-cos(a))*Uy*Uy+cos(a) (1-cos(a))*Uy*Uz-sin(a)*Ux ;...
   
   (1-cos(a))*Uz*Ux-sin(a)*Uy (1-cos(a))*Uz*Uy+sin(a)*Ux (1-cos(a))*Uz*Uz+cos(a) ...
  ];

%Metatrepoume ton pikana gia thn periptwsh twn omogenwn
R=[[R zeros(3,1)];zeros(1,3) 1];

end

