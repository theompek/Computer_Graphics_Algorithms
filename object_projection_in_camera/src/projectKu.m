function P = projectKu(w, cv, ck, cu, p)
%Dianusma apo thn kamera sto stoxo
CK=ck-cv;
%Monadiaio z dianusma e3iswsh 6.6 selida 74
Zc=CK./norm(CK);
%Monadiaio y dianusma e3iswsh 6.7
t=cu-(cu.'*Zc).*Zc;
Yc=t./norm(t);
%Gia to trito dianusma e3wteriko ginomeno
Xc=cross(Zc,Yc);
%Twra pou 3eroume ta Xc kai Yc mporoume na kalesoume thn
%sunarthsh pou ftia3ame prin
P=project(w,cv,Xc,Yc,p);

end

