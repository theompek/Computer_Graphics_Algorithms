function [ I ] = diffuseLight(P, N, kd, S, I0)
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
%%Sunolikos fwtismos
%1xn pinakas me ta cos(a) gia ka8e phgh
cos_a=N'*L;
%Gia osa den ta blepei h phgh dhladh sxhmatizoun amblia gwnia ta
%mhdenizoume
for i=1:1:n
if cos_a(i)<0
    cos_a(i)=0;
end
%3x1 pinakas(RGB) me to a8roisma olwn twn fwteismwn
I=zeros(3,1);
I(1)=sum(I0(1,:).*kd(1).*cos_a); 
I(2)=sum(I0(2,:).*kd(2).*cos_a); 
I(3)=sum(I0(3,:).*kd(3).*cos_a);

end

