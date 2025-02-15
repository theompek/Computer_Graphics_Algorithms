function [Y] = Tripaint(X, V, C , P, cv, S, ka, kd, ks, ncoeff, Ia, I0)
tic;

%Ypologismos energwn akmwn,enrgwn shmeiwn
eikona=X;
V=V';

%Briskoume thn megisth kai elaxistinh koryfh tou trigwnou
[ymax, ~]=max(V(:,2));
[ymin, B]=min(V(:,2));

[xmax, ~]=max(V(:,1));
[xmin, ~]=min(V(:,1));
%To shmeio pou antistoixei sto ymin einai to pio xamilo
%shmeio tou trigvnou apo to opoio 3ekinaei o algori8os.
%Antistoixei sth B-sth grammh tou pinaka korufwn V

%Oi energes akmes einai
EnergAkmes=[];
NormalAkmwn=[]; %pinakas xrwmatwn twn energwn akmwn
for i=1:3
    
  if i~=B
  EnergAkmes=[EnergAkmes [V(B,:);V(i,:)]];
  NormalAkmwn=[NormalAkmwn [C(B,:);C(i,:)]];
  end
end
%O pinaka EnergAkmes einai 2x4 kai periexei 2 akmes ths morfhs
%gia paradeigma [AB AC]=| xa ya xa ya | opou AB kai AC akmes 
%                       | xb yb xc yc |
%kai A to shmeio gia to opoio exoume ymin

%Gia na mhn kanoume synexws elegxo gia thn ananewsh twn akmwn 8a broume
%e3arxhs pou 8a ginei h allagh,dhladh to amesws epomeno shmeio se
%ypsos apo ta 2 pou exoun meinei

[a, b]=min([EnergAkmes(2,2) EnergAkmes(2,4)]);

if a~=ymin
    EnergShmeia=[V(B,1) V(B,1)]; %ths morfhs [xi xi]
else
%dhladh an a==ymin tote shmainei oti gia ymin exoume orizontia akmh kai oi
%energes akmes einai diaforetikes [xi xj] kai den 3ekiname apo thn idia korufh xi
  
   %Allagh se morfh [AC BC] se periptwsh orizontias pleuras AB
    EnergAkmes(1,(2*b-1):2*b)=EnergAkmes(2,(2*b-1):2*b);
    EnergAkmes(2,(2*b-1):2*b)=EnergAkmes(2,(4/b-1):4/b);
    
    EnergShmeia=[EnergAkmes(1,1) EnergAkmes(1,3)]; %ths morfhs [xi xj]
    
    %Allagh pinaka xrwmatwn
    NormalAkmwn(1,b*b:b*b+2)=NormalAkmwn(2,b*b:b*b+2);
    NormalAkmwn(2,b*b:b*b+2)=NormalAkmwn(2,4/(b*b):4/(b*b)+2);
end


%%
%Sarwsh tou trigvnou,entopismos energwn shmeiwn kai xrwmatismos trigwnou

%Ypologizoume ta �y �x
dx1=EnergAkmes(2,1)-EnergAkmes(1,1);
dy1=EnergAkmes(2,2)-EnergAkmes(1,2);

dx2=EnergAkmes(2,3)-EnergAkmes(1,3);
dy2=EnergAkmes(2,4)-EnergAkmes(1,4);


%Metasxhmatizoume ta arxika shmeia shmfwna me thn sxesh x'=x*dy
EnergShmeia(1)=EnergShmeia(1)*dy1;
EnergShmeia(2)=EnergShmeia(2)*dy2;

if a==ymin %An h panw akmh einai orizontia
  a=ymax;     
end

distance1=sqrt((EnergAkmes(1,1)-EnergAkmes(2,1))^2+(EnergAkmes(1,2)-EnergAkmes(2,2))^2);
distance2=sqrt((EnergAkmes(1,3)-EnergAkmes(2,3))^2+(EnergAkmes(1,4)-EnergAkmes(2,4))^2);


N_normal=[];
for y=ymin:a-1
CA=(sqrt((EnergAkmes(1,1)-EnergShmeia(1)/dy1)^2+(EnergAkmes(1,2)-y)^2)*NormalAkmwn(2,1:3) + ...
   sqrt((EnergAkmes(2,1)-EnergShmeia(1)/dy1)^2+(EnergAkmes(2,2)-y)^2)*NormalAkmwn(1,1:3))/distance1;

CB=(sqrt((EnergAkmes(1,3)-EnergShmeia(2)/dy2)^2+(EnergAkmes(1,4)-y)^2)*NormalAkmwn(2,4:6) + ...
   sqrt((EnergAkmes(2,3)-EnergShmeia(2)/dy2)^2+(EnergAkmes(2,4)-y)^2)*NormalAkmwn(1,4:6))/distance2;

cross_count=0;
aid=0;
bid=0;

%Gia to trexon y_scanline 
for x=xmin:xmax 
    
 if dy1>0 && x*dy1>EnergShmeia(1) && aid==0
      cross_count=cross_count+1;
      aid=1;
 elseif dy1<0 && x*dy1<EnergShmeia(1) && aid==0
      cross_count=cross_count+1;
      aid=1;
 end
 
 
 if dy2>0 && x*dy2>EnergShmeia(2) && bid==0
      cross_count=cross_count+1;
      bid=1;
 elseif dy2<0 && x*dy2<EnergShmeia(2) && bid==0
      cross_count=cross_count+1;
      bid=1;
 end
 
 if(mod(cross_count,2)==1)
 N_normal=findNormal(x,EnergShmeia(1),EnergShmeia(2),CA,CB,dy1,dy2)';
   
 eikona(x,y,:) = ambientLight(P, ka, Ia)+diffuseLight(P, N_normal, kd, S, I0)+specularLight(P, N_normal, cv, ks, ncoeff, S, I0);
 else
     aid=0;
     bid=0;
 end
 
end

%Ypologizoume ta enegra shmeia sumfwna me tous tupous ths ekfvnishs opou  
%dx1 dx2 oi diafora twn tetmhmenwn twn koryfwn twn antistoixwn energwn
%akmvn
EnergShmeia=[EnergShmeia(1)+dx1, EnergShmeia(2)+dx2];   

end

CA=(sqrt((EnergAkmes(1,1)-EnergShmeia(1)/dy1)^2+(EnergAkmes(1,2)-y)^2)*NormalAkmwn(2,1:3) + ...
   sqrt((EnergAkmes(2,1)-EnergShmeia(1)/dy1)^2+(EnergAkmes(2,2)-y)^2)*NormalAkmwn(1,1:3))/distance1;

CB=(sqrt((EnergAkmes(1,3)-EnergShmeia(2)/dy2)^2+(EnergAkmes(1,4)-y)^2)*NormalAkmwn(2,4:6) + ...
   sqrt((EnergAkmes(2,3)-EnergShmeia(2)/dy2)^2+(EnergAkmes(2,4)-y)^2)*NormalAkmwn(1,4:6))/distance2;


cross_count=0;
aid=0;
bid=0;
for x=xmin:xmax 
    
 if dy1>0 && x*dy1>EnergShmeia(1) && aid==0
      cross_count=cross_count+1;
      aid=1;
 elseif dy1<0 && x*dy1<EnergShmeia(1) && aid==0
      cross_count=cross_count+1;
      aid=1;
 end
 
 
 if dy2>0 && x*dy2>EnergShmeia(2) && bid==0
      cross_count=cross_count+1;
      bid=1;
 elseif dy2<0 && x*dy2<EnergShmeia(2) && bid==0
      cross_count=cross_count+1;
      bid=1;
 end
 
 if(mod(cross_count,2)==1)
 N_normal=findNormal(x,EnergShmeia(1),EnergShmeia(2),CA,CB,dy1,dy2)';
  
 eikona(x,a,:)=ambientLight(P, ka, Ia)+diffuseLight(P, N_normal, kd, S, I0)+specularLight(P, N_normal, cv, ks, ncoeff, S, I0);
 else
     aid=0;
     bid=0;
 end
 
end



%An den exoume orizonties akmes tote ananeonoume thn lista akmwn kai ta 
%antistoixa xrwmata tou pinaka xrwmatwn pou antidtoixoun sthn trith akmh
if a~=ymin && a~=ymax

%Metasxhmatizoume ta arxika shmeia shmfwna me thn sxesh x'=x*dy
EnergShmeia(1)=EnergShmeia(1)/dy1;
EnergShmeia(2)=EnergShmeia(2)/dy2;
   
EnergAkmes(1,2*b-1:2*b)=EnergAkmes(2,2*b-1:2*b);
EnergAkmes(2,2*b-1:2*b)=EnergAkmes(2,4/b-1:4/b);

NormalAkmwn(1,b*b:b*b+2)=NormalAkmwn(2,b*b:b*b+2);
NormalAkmwn(2,b*b:b*b+2)=NormalAkmwn(2,4/(b*b):4/(b*b)+2);

distance1=sqrt((EnergAkmes(1,1)-EnergAkmes(2,1))^2+(EnergAkmes(1,2)-EnergAkmes(2,2))^2);
distance2=sqrt((EnergAkmes(1,3)-EnergAkmes(2,3))^2+(EnergAkmes(1,4)-EnergAkmes(2,4))^2);

%Ypologizoume ta �y �x
dx1=EnergAkmes(2,1)-EnergAkmes(1,1);
dy1=EnergAkmes(2,2)-EnergAkmes(1,2);

dx2=EnergAkmes(2,3)-EnergAkmes(1,3);
dy2=EnergAkmes(2,4)-EnergAkmes(1,4);

%Metasxhmatizoume ta arxika shmeia shmfwna me thn sxesh x'=x*dy
EnergShmeia(1)=EnergShmeia(1)*dy1;
EnergShmeia(2)=EnergShmeia(2)*dy2;

for y=a+1:ymax

%Ypologizoume ta enegra shmeia sumfwna me tous tupous ths ekfvnishs opou  
%dx1 dx2 oi diafora twn tetmhmenwn twn koryfwn twn antistoixwn energwn akmvn    
EnergShmeia=[EnergShmeia(1)+dx1, EnergShmeia(2)+dx2];     
    
CA=(sqrt((EnergAkmes(1,1)-EnergShmeia(1)/dy1)^2+(EnergAkmes(1,2)-y)^2)*NormalAkmwn(2,1:3) + ...
   sqrt((EnergAkmes(2,1)-EnergShmeia(1)/dy1)^2+(EnergAkmes(2,2)-y)^2)*NormalAkmwn(1,1:3))/distance1;

CB=(sqrt((EnergAkmes(1,3)-EnergShmeia(2)/dy2)^2+(EnergAkmes(1,4)-y)^2)*NormalAkmwn(2,4:6) + ...
   sqrt((EnergAkmes(2,3)-EnergShmeia(2)/dy2)^2+(EnergAkmes(2,4)-y)^2)*NormalAkmwn(1,4:6))/distance2;

cross_count=0;
aid=0;
bid=0;
for x=xmin:xmax 
    
 if dy1>0 && x*dy1>EnergShmeia(1) && aid==0
      cross_count=cross_count+1;
      aid=1;
 elseif dy1<0 && x*dy1<EnergShmeia(1) && aid==0
      cross_count=cross_count+1;
      aid=1;
 end
 
 
 if dy2>0 && x*dy2>EnergShmeia(2) && bid==0
      cross_count=cross_count+1;
      bid=1;
 elseif dy2<0 && x*dy2<EnergShmeia(2) && bid==0
      cross_count=cross_count+1;
      bid=1;
 end
 
 if(mod(cross_count,2)==1)
 N_normal=findNormal(x,EnergShmeia(1),EnergShmeia(2),CA,CB,dy1,dy2)';
  
 eikona(x,y,:)=ambientLight(P, ka, Ia)+diffuseLight(P, N_normal, kd, S, I0)+specularLight(P, N_normal, cv, ks, ncoeff, S, I0);
 else
     aid=0;
     bid=0;
 end
 

end
end    
end

Y=eikona;


end

