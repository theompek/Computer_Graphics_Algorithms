function [ I ] = specularLight(P, N, V, ks, ncoeff, S, I0)
 %P: dianusma 3x1 me suntetagmenes shmeiou
 %N: dianusma 3x1 ka8eto sthn epifaneia tou shmeiou
 %kd: dianusma 3x1 suntelesths diaxuths anaklashs
 %S: pinakas 3xn me suntetasmenes twn phgwn
 %Io: pinakas 3xn me thn entash ka8e phghs gia RGB 
 %I: dianusma 3x1(RGB) me to a8roisma olwn twn entasewn twn phgwn
 
 %Ari8mos phgwn
 n=length(S(1,:));
 
 %Metatroph tou N se monadiaio
 N=N./norm(N);
 
 %%
 %Pinakas L 3xn me suntetagmenes twn dianusmatwn apo to shmeiou P pros tis phges 
 L=S;
 for i=1:1:n
 L(:,i)=S(:,i)-P;
 %Metatroph se monadiaia
 L(:,i)=L(:,i)./norm(L(:,i));
 end
%%
 %Dianusma Vvector 3x1 pros ton parathrhth
 Vvector=V-P;
 %Monadiaio
 Vvector=Vvector./norm(Vvector);
%%
%1xn pinakas me ta cos(b-a)^ncoeff gia ka8e phgh
Phong=zeros(1,n);
for i=1:1:n
Phong(i)=((2*N*(N'*L(:,i))-L(:,i)).'*Vvector).^ncoeff;
%An yparxoyn trigwna ta opoia h phgh den ta fwtizei apo thn pleura apo thn 
%opoia ta vlepei h camera tote isxuei oti Phong(i)<0,amvlia gwnia meta3u up
%vector kai dianysma shmeiou-phghs
if Phong(i)<0
    Phong(i)=0;
end
end

%%Sunolikos fwtismos
%3x1 pinakas(RGB) me to a8roisma olwn twn fwteismwn
I=zeros(3,1);
I(1)=sum(I0(1,:).*ks(1).*Phong); 
I(2)=sum(I0(2,:).*ks(2).*Phong); 
I(3)=sum(I0(3,:).*ks(3).*Phong);

end

