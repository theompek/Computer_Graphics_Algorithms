function [ I ] = PainterA(Q, T, C, M, N)
close all;

%O ari8mos twn trigwnwn pou prepei na dhmiourghsoume
numberOfTriangles=length(Q(:,1));
%H MxN eikona me leuko background 
I=ones(M,N,3);

%kanoume thn eikona NxM gia sumbatothtata me thn morfh 
%tou kwdika kai tou pinaka T me tis suntetagmenes twn korufwn
I=permute(I,[2 1 3]);

%dhmiourgoume ena ena ta trigwna
for i=1:numberOfTriangles
%Apo8hkevoume tis korufes tou trigvnou ston pinaka V    
V=[T(Q(i,1),:) ; T(Q(i,2),:) ; T(Q(i,3),:)]' ;
%kai ta antistoixa xrvmata twn korufwn
colors=[C(Q(i,1),:) ; C(Q(i,2),:) ; C(Q(i,3),:)] ;


I=TripaintC(I,V,colors);  
end

%epanaferoume thn eikona se MxN morfh
I=permute(I,[2 1 3]);

end

