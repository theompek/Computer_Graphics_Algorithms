function [Y] = TripaintB(X, V, C)

eikona=X;
V=V';

%Briskoume thn megisth kai elaxistinh koryfh tou trigwnou
[ymax, ~]=max(V(:,2));
[ymin, B]=min(V(:,2));
%To shmeio pou antistoixei sto ymin einai to pio xamilo
%shmeio tou trigvnou apo to opoio 3ekinaei o algori8os.
%Antistoixei sth B-sth grammh tou pinaka korufwn V

%Oi energes akmes einai
EnergAkmes=[];
XrwmataShm=[]; %pinakas xrwmatwn twn energwn akmwn
for i=1:3
  if i~=B
  EnergAkmes=[EnergAkmes [V(B,:);V(i,:)]];
  XrwmataShm=[XrwmataShm [C(B,:);C(i,:)]];
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
    XrwmataShm(1,b*b:b*b+2)=XrwmataShm(2,b*b:b*b+2);
    XrwmataShm(2,b*b:b*b+2)=XrwmataShm(2,4/(b*b):4/(b*b)+2);
end

%%
%Ypologismos twn syntelestwn anadromhs

m1=(EnergAkmes(2,2)-EnergAkmes(1,2))/(EnergAkmes(2,1)-EnergAkmes(1,1));
m2=(EnergAkmes(2,4)-EnergAkmes(1,4))/(EnergAkmes(2,3)-EnergAkmes(1,3));
m3=(EnergAkmes(2,4)-EnergAkmes(2,2))/(EnergAkmes(2,3)-EnergAkmes(2,1));
m=[1/m1 1/m2 1/m3];

%Ka8orizoume to pws 8a ginetai sarosh(pros aristera h de3ia)ths scanline grammhs 
%analoga me thn diata3h twn energwn shmeiwn
if(EnergShmeia(1)+m(1))>(EnergShmeia(2)+m(2))
    step=-1;
else
    step=1;
end
%%
%Sarwsh tou trigvnou,entopismos energwn shmeiwn kai xrwmatismos trigwnou

if a==ymin %An h panw akmh einai orizontia
  a=ymax;     
end

distance1=sqrt((EnergAkmes(1,1)-EnergAkmes(2,1))^2+(EnergAkmes(1,2)-EnergAkmes(2,2))^2);
distance2=sqrt((EnergAkmes(1,3)-EnergAkmes(2,3))^2+(EnergAkmes(1,4)-EnergAkmes(2,4))^2);

for y=ymin:a-1
CA=(sqrt((EnergAkmes(1,1)-EnergShmeia(1))^2+(EnergAkmes(1,2)-y)^2)*XrwmataShm(2,1:3) + ...
   sqrt((EnergAkmes(2,1)-EnergShmeia(1))^2+(EnergAkmes(2,2)-y)^2)*XrwmataShm(1,1:3))/distance1;

CB=(sqrt((EnergAkmes(1,3)-EnergShmeia(2))^2+(EnergAkmes(1,4)-y)^2)*XrwmataShm(2,4:6) + ...
   sqrt((EnergAkmes(2,3)-EnergShmeia(2))^2+(EnergAkmes(2,4)-y)^2)*XrwmataShm(1,4:6))/distance2;


for x=floor(EnergShmeia(1)):step:floor(EnergShmeia(2))
     
 color=findColor(x,EnergShmeia(1),EnergShmeia(2),CA,CB);
  
 eikona(x,y,:)=color;

end

%Ypologizoume ta energa shmeia sumfwna me thn sxesh x(i+1)=x(i)+m 
%opou m=1/mq kai opou mq einai h klish ths ekastote pleuras
EnergShmeia=[EnergShmeia(1)+m(1), EnergShmeia(2)+m(2)];   

end

CA=(sqrt((EnergAkmes(1,1)-EnergShmeia(1))^2+(EnergAkmes(1,2)-y)^2)*XrwmataShm(2,1:3) + ...
   sqrt((EnergAkmes(2,1)-EnergShmeia(1))^2+(EnergAkmes(2,2)-y)^2)*XrwmataShm(1,1:3))/distance1;

CB=(sqrt((EnergAkmes(1,3)-EnergShmeia(2))^2+(EnergAkmes(1,4)-y)^2)*XrwmataShm(2,4:6) + ...
   sqrt((EnergAkmes(2,3)-EnergShmeia(2))^2+(EnergAkmes(2,4)-y)^2)*XrwmataShm(1,4:6))/distance2;


for x=floor(EnergShmeia(1)):step:floor(EnergShmeia(2))
     
 color=findColor(x,EnergShmeia(1),EnergShmeia(2),CA,CB);
 
 eikona(x,a,:)=color;

end

%An den exoume orizonties akmes tote ananeonoume thn lista akmwn kai ta 
%antistoixa xrwmata tou pinaka xrwmatwn pou antidtoixoun sthn trith akmh

if a~=ymin && a~=ymax

m(b)=m(3);

EnergAkmes(1,2*b-1:2*b)=EnergAkmes(2,2*b-1:2*b);
EnergAkmes(2,2*b-1:2*b)=EnergAkmes(2,4/b-1:4/b);

XrwmataShm(1,b*b:b*b+2)=XrwmataShm(2,b*b:b*b+2);
XrwmataShm(2,b*b:b*b+2)=XrwmataShm(2,4/(b*b):4/(b*b)+2);

distance1=sqrt((EnergAkmes(1,1)-EnergAkmes(2,1))^2+(EnergAkmes(1,2)-EnergAkmes(2,2))^2);
distance2=sqrt((EnergAkmes(1,3)-EnergAkmes(2,3))^2+(EnergAkmes(1,4)-EnergAkmes(2,4))^2);

for y=a+1:ymax
    
%Ypologizoume ta energa shmeia sumfwna me thn sxesh x(i+1)=x(i)+m 
%opou m=1/mq kai opou mq einai h klish ths ekastote pleuras    
EnergShmeia=[EnergShmeia(1)+m(1), EnergShmeia(2)+m(2)];     
    
CA=(sqrt((EnergAkmes(1,1)-EnergShmeia(1))^2+(EnergAkmes(1,2)-y)^2)*XrwmataShm(2,1:3) + ...
   sqrt((EnergAkmes(2,1)-EnergShmeia(1))^2+(EnergAkmes(2,2)-y)^2)*XrwmataShm(1,1:3))/distance1;

CB=(sqrt((EnergAkmes(1,3)-EnergShmeia(2))^2+(EnergAkmes(1,4)-y)^2)*XrwmataShm(2,4:6) + ...
   sqrt((EnergAkmes(2,3)-EnergShmeia(2))^2+(EnergAkmes(2,4)-y)^2)*XrwmataShm(1,4:6))/distance2;

for x=floor(EnergShmeia(1)):step:floor(EnergShmeia(2))
     
 color=findColor(x,EnergShmeia(1),EnergShmeia(2),CA,CB);
 
 eikona(x,y,:)=color;

end
end    
end

Y=eikona;

end

