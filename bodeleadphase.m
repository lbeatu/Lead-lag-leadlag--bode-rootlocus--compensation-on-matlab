
clc
syms T alfa s K
Kv=10; % hýz hata katsayýsý
Fp=35; %faz marjini
% num=[10]
% den=[1 1 0]
num=[0 2.646 32.86 101.8 43.84]
den=[1 11.59 43.63 52.1 75.66]
Gs=tf(num,den)  % transfer fonskiyonu

sys=(2.646*s^3 + 32.86*s^2 + 101.8*s + 43.84)/(s^4 + 11.59*s^3 + 43.63*s^2 + 52.1*s + 75.66);
G=limit(K*sys*s)
K=solve((Kv-G),K) % K yý buldum.
bode(num,den)  % bode diyagramý
figure
margin(Gs);
grid on
[Gm,Pm,Wcg,Wcp]=margin(Gs) % burdan wc deðerini elde ettim.
fi=(Fp-Pm+5)*pi/180
alfa=double(solve((sin(fi)*(1+alfa)-(1-alfa)),alfa)) % elfayý bulup burdan sýfýr ve kutuplarý buldum.
resp=mag2db(1/sqrt(alfa))
Wc=(pi+Wcp)
z = Wc*sqrt(alfa)
p = Wc/sqrt(alfa)
Gc=tf([1 z],[1 p])
sys2=Gs*Gc
figure(1); hold on;
margin(Gc); hold off; 
sys3=feedback(sys2,[1])
step(sys3+0.1)





