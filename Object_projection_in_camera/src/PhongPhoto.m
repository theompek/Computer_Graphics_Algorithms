function Im = PhongPhoto(w, cv, cK, cu, bC, M, N, H, W, R, F, S, ka, kd, ks, ncoeff, Ia, I0)

%Ypologismos twn normals vector
Normals=VertNormals(R, F);
%%
%Provolh twn shmeiwn sto petasma ths cameras
%Oi syntetagmenes R metasxhmatizontai apo to WCS sto CCS eswterika ths projectKu
Provolh = projectKu(w, cv, cK, cu, [R;ones(1,length(R))]);

%Gia sumbatotita me to prwto programma pliroshs ths prwths ergasia prepei na kanoyme
ax=M;
M=N;
N=ax;
%H parapanw probolh einai se fyshkes diastaseis (inches) ara prepei na tis
%metatrepsoume se diastaseis pixel,dhladh se syntetagmenes tou MxN kamva

%Metatroph se suntetagmenes pixel
Provolh(1,:)=ceil((M/W).*Provolh(1,:));
Provolh(2,:)=ceil((N/H).*Provolh(2,:));

%Allagh susthmatos syntetagmenwn tou kamva me arxh thn katw aristerh gwnia
Provolh(1,:)=Provolh(1,:)+M/2;
Provolh(2,:)=Provolh(2,:)+N/2;

%%
%8a paralhpsoume ta trigwna pou den vlepei h
%camera,dhladh einai pisw apo thn emfanh pleura tou bazou
F_new=[];
Ka_new=[];
Kd_new=[];
Ks_new=[];
ApostashKentrwn=[];
%Epishs 8a upologisoume kai ta kentra autwn twn trigwnwn
Kentra_new=[];
for i=1:1:length(F(1,:));
 %kentro trigwnou mesos oros korufwn ws pros to WCS
 Tr=(R(:,F(1,i))+R(:,F(2,i))+R(:,F(3,i)))/3;
 %dianusma camera-kentro trigwnou
 c_Tr=Tr-cv;
 c_Tr=c_Tr./norm(c_Tr);%Monadiaio
 %dianusmata pleurwn
 q1=R(:,F(2,i))-R(:,F(1,i));
 q2=R(:,F(3,i))-R(:,F(2,i));
 %Normal vector tou trigwnou
 Qnorm=cross(q1,q2);
 Qnorm=Qnorm./norm(Qnorm);%Monadiaio
 
 %An to dianusma camera-kentroTrigwnou kai to dianusma pou einai ka8eto
 %sthn epifaneia tou trigwnou sxhmatizoun o3ia gwnia tote to trigwno den
 %fainetai kai epomenos e3ereitai apo to sunolo trigwnwn
 if((c_Tr'*Qnorm)<0)   
    F_new=[F_new F(:,i)];
    Kentra_new=[Kentra_new Tr];
    Ka_new=[Ka_new ka(:,i)];
    Kd_new=[Kd_new kd(:,i)];
    Ks_new=[Ks_new ks(:,i)];
    ApostashKentrwn=[ApostashKentrwn norm(Tr-cv)];
 end

end
%Sto sxhma mporei na uparxoun trigwna apo thn pisw meria pou den fainontai
%kai na exoun amvlia gwnia(e3artatai apo thn gwnia thn opia blepoume to sxhma) 
%gia auto kanoume diata3h twn trigwnwn twn parapanw trigwnwn wste na xrwmatistoun
%prwta ta pio pisw trigwna kai meta ta mprosta pou einai wrata

%Diata3h me bash thn apostash apo thn kamera
[~, Q]=sort(-ApostashKentrwn);

F=zeros(3,length(F_new(1,:)));
ka=zeros(3,length(F_new(1,:)));
Kentra=zeros(3,length(F_new(1,:)));

for i=1:1:length(F_new(1,:));
F(:,i)=F_new(:,Q(i));
Kentra(:,i)=Kentra(:,Q(i));
ka(:,i)=Ka_new(:,Q(i));
kd(:,i)=Kd_new(:,Q(i)); 
ks(:,i)=Ks_new(:,Q(i)); 
end


%F:2xAri8mosEnergwnTrigwnwn pinakas
%Provolh:2xn pinakas
%Normals:3xn pinakas
%bC:Xrwmatikes synistwses Background
%M,N:Diastaseis eikonas se pixel 
Im=Painter(F, Provolh, Kentra_new, Normals, cv, M, N, bC, S, ka, kd, ks, ncoeff, Ia, I0);


end

