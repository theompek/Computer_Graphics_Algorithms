function [ Normals ] =VertNormals(R, F)

%ari8mos trigwnwn
n=length(F(1,:));
%ari8mos koryfwn
numKor=length(R(1,:));

Normals=zeros(3,numKor);
for i=1:1:n
 %dianusmata pleurwn
 q1=R(:,F(2,i))-R(:,F(1,i));
 q1=q1/norm(q1);
 q2=R(:,F(3,i))-R(:,F(2,i));
 q2=q2/norm(q2);
 %Normal vector tou trigwnou
 Qnorm=cross(q1,q2);
 Qnorm=Qnorm./norm(Qnorm);
 %Pros8esh twn normal vector me ta normal vector apo geitonika trigwna gia
 %ka8e koryfh
 Normals(:,F(1,i))=Normals(:,F(1,i))+Qnorm;
 Normals(:,F(2,i))=Normals(:,F(2,i))+Qnorm;
 Normals(:,F(3,i))=Normals(:,F(3,i))+Qnorm;
end

for i=1:1:length(Normals)  
 %Monadiaio
 Normals(:,i)=Normals(:,i)./norm(Normals(:,i)); 
end

end