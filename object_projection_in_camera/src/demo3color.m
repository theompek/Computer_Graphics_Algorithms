clear;
close all;

load('vase_color.mat');
H = 1/2;
W = 2/3;
M = 300;
N = 400;
cv = [-100, -100, -10]';
cK = [-30, -40, -20]';
cu = [0,0,1]';
w = 1;
bC = [0.5, 0.5, 0.5]';
ka = (1/255)*C;
kd = ka;
ks = ka;
ncoeff = 3;
Ia = [1, 1, 1]';
S = [100, -150, 120]';
I0 = [1, 1, 1]';

I=PhongPhoto(w, cv, cK, cu, bC, M, N, H, W, R, F, S, ka, kd, ks, ncoeff, Ia, I0);
figure(1);

imshow(I);
title('A8roisma fwtismwn');

