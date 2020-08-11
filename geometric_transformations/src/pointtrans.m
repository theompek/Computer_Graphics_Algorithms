function d = pointtrans(cph,L,ct)

%O ari8mos twn dianusmatwn u
N=length(cph(1,:));
d=[];

%Gia na kanoume pio eukola tis pra3eis
%afairoume tous asous twn omogenwn kai twra cph 3xN
cph=cph(1:3,:);
%Prwta efarmozoume to metasxhmatismo L
%xrhsimopoiontas thn sunarthsh pou ftia3ame prin
d=vectrans(cph,L);
%Metatopizoume kata ct
for i=1:1:N
d(:,i)=d(:,i)+ct;
end
%Telos prosfetoume tous asous sthn teleutaia grammh
%gia na kanoume tis suntetagmenes omogeneis
d=[d;ones(1,N)];
end