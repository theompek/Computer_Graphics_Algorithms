function [ I ] = Painter(Trigwno, Korufes, kentoTrigwnou, Normals, cv, M, N, bC, S, ka, kd, ks, ncoeff, Ia, I0)
close all;

%O ari8mos twn trigwnwn pou prepei na dhmiourghsoume
numberOfTriangles=length(Trigwno(1,:));
%H MxN eikona me bC=[R G B] background 
I=ones(M,N,3);
I(:,:,1)=bC(1)*I(:,:,1);
I(:,:,2)=bC(2)*I(:,:,2);
I(:,:,3)=bC(3)*I(:,:,3);

%dhmiourgoume ena ena ta trigwna
for i=1:numberOfTriangles
%Apo8hkevoume tis korufes tou trigwnou ston pinaka V 2x3   
V=[Korufes(:,Trigwno(1,i))  Korufes(:,Trigwno(2,i))  Korufes(:,Trigwno(3,i))] ;
%kai ta antistoixa Normal vectors twn korufwn
NormalKorufwn=[Normals(:,Trigwno(1,i))  Normals(:,Trigwno(2,i))  Normals(:,Trigwno(3,i))]'; 

%Gia ta shmeia twn trigwnwn ta opoia logo provolhs taytizontai meta3u tous
%dhladh probalontai panw sto idio shmeio
if V(1,1)==V(1,2) && V(1,1)==V(1,3)
    V(1,1) = V(1,1)-1;
end

if V(2,1)==V(2,2) && V(2,1)==V(2,3)
    V(2,1) = V(2,1)-1;
end

%Ean ta trigwna briskontai entos kamva xrwmatise ta
  if V(1,1)>0 && V(1,2)>0 && V(1,3)>0 &&...
     V(1,1)<=M && V(1,2)<=M && V(1,3)<=M &&...
     V(2,1)>0 && V(2,2)>0 && V(2,3)>0 &&...
     V(2,1)<=N &&V(2,2)<=N && V(2,3)<=N
          
     I=Tripaint(I,V,NormalKorufwn,kentoTrigwnou(:,i), cv, S, ka(:,i), kd(:,i), ks(:,i), ncoeff, Ia, I0);  
  end
end

I=permute(I,[2 1 3]);

%Times tou fwtismou megaluteres ths monadas ginontai ises me monada
for i=1:N
   for j=1:M
         if I(i,j,1)>1
             I(i,j,1)=1;
         end
         if I(i,j,2)>1
             I(i,j,2)=1;
         end
         if I(i,j,3)>1
             I(i,j,3)=1;
         end
           
   end
    
end


end

