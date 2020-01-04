%%faz gerilemeli-ilermeli via Frekans -Bode
clc
clear all;
syms T alfa s K
Kv=60;
Fm0=40;
kazanc=2.80
num=[0 2.646 32.86 101.8 43.84]
den=[1 11.59 43.63 52.1 75.66]
% num=[1]
% den=[1 6 5 0]
Gs=tf(num,den) 
sys=(2.646*s^3 + 32.86*s^2 + 101.8*s + 43.84)/(s^4 + 11.59*s^3 + 43.63*s^2 + 52.1*s + 75.66);
% sys=1/(s^3+6*s^2+5*s)
G=limit(K*sys)
K=double(solve((Kv-G),K))
wc=0.6*kazanc
[mag,faz]=bode(Gs*K,wc)
Fm=180+faz
fimax=(Fm0-Fm+10)*pi/180
alfa=(1-sin(fimax))/(1+sin(fimax))
zlead = wc*sqrt(alfa)
plead = wc/sqrt(alfa)
beta=1/alfa
T=10/wc
zlag = 1/T
plag = 1/(T*beta)
T*beta
Gclag=tf([1 zlag],[1 plag])
Gclead=tf([1 zlead],[1 plead])
 sys2=K*Gs*Gclag*Gclead
 hold on; 
 sys3=feedback(sys2,[1])
 step(sys3)
  figure(2)
 margin(Gs);
% grid on
% [Gm,Pm,Wcg,Wcp]=margin(Gs*K)
% w=input('Bode diyagramýndan w giriniz:')% w=1.76 40 db