function [ d ] = systemtrans( cph,L,c0 )

%O ari8mos twn dianusmatwn u
N=length(cph(1,:));
d=[];

%afairoume tous asous twn omogenwn
cph=cph(1:3,:);
%To c0 to kanoume 3xN pinaka ths morfhs [c0 c0 ... c0]
%gia na kanoume thn afairesh cph-c0 parakatw
c0=repmat(c0,1,N);

%Gia na upologisoume tis nees syntetagmenes 8a xrhsimopoihsoume
%ton tupo 5.27 c'=L^-1(c-c0) twn shmeiwsewn sthn selida 55 
%kai thn sunarthsh "axistrans" pou ftia3ame prohgoumenos
d=axistrans(cph-c0,L);

%Omogeneis suntetagmenes
d=[d;ones(1,N)];

end

