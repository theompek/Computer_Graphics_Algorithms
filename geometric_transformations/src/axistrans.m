function d = axistrans(c,L)

%O ari8mos twn dianusmatwn u
N=length(c(1,:));
d=[];
for i=1:1:N
    
%O pinakas d=inv(L)*c mege8ous 3xN  
d=[d L\c(:,i)];

end

end