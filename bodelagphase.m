clc
clear all;
syms T alfa s K
Kv=20;
num=[0 2.646 32.86 101.8 43.84]
den=[1 11.59 43.63 52.1 75.66]
Gs=tf(num,den) 
sys=(2.646*s^3 + 32.86*s^2 + 101.8*s + 43.84)/(s^4 + 11.59*s^3 + 43.63*s^2 + 52.1*s + 75.66);
G=limit(K*sys)
K=double(solve((Kv-G),K))
% %% 
% bode(Gs)
figure(1)
margin(Gs*K);
grid on
[Gm,Pm,Wcg,Wcp]=margin(Gs*K)
w=input('Bode diyagramýndan w giriniz:')% w=1.76 40 db
alfa=10^(-w/20)
T=10/(w*alfa)
p = 1/T
z = 1/(T*alfa)
Gc=tf([1 z],[1 p])
sys2=Gs*Gc
figure(2); hold on;
margin(Gc); hold off; 
sys3=feedback(sys2,[1])
step(sys3)
stepinfo(sys3)