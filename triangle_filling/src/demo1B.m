dedomena;
tic;

I=PainterB(Q,T,C,M,N);
time=toc;

%sunolikos xronos ekteleshs algori8mou
display(['Total time is ',num2str(time),' seconds'])

%probolh ths telikhs eikonas
imshow(I)
title(['PainterB' [' Total time is ',num2str(time),' seconds']])
xlabel(['X axis N=',num2str(N)])
ylabel(['Y axis M=',num2str(M)])
hold;
