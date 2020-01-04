%root locus-lag
clc
syms T alfa s
mp=0.4;% overshoot
ts=1;% yerle�me zaman�
Kv=40; % h�z hata katsay�s�
num=[0 2.646 32.86 101.8 43.84]
den=[1 11.59 43.63 52.1 75.66] 
Gs=tf(num,den) %%2.646s^3 + 32.86 s^2 + 101.8 s + 43.84/  s^4 + 11.59 s^3 + 43.63 s^2 + 52.1 s + 75.66
sys=(2.646*s^3 + 32.86*s^2 + 101.8*s + 43.84)/(s^4 + 11.59*s^3 + 43.63*s^2 + 52.1*s + 75.66);
C_lag(s) = (s+1/T)/(s+1/(alfa*T)) % kontrolc� denklemi
zeta=1/(sqrt(1+(pi/log(mp))^2))% overshoottan ? (s�n�mleme oran�)zetay� elde etti�im denklem
wn=4/(zeta*ts) %ts=4/(zeta*wn);do�al s�n�m
beta=(pi-acos(zeta))% Beta ac�s�
s1=complex(zeta*wn,sqrt(wn^2-(zeta*wn)^2)) % 4.0000 +13.7144i
pay=polyval(num,s1) %pay ve paydada s1 i s yerine yazd�m
payda=polyval(den,s1)
K=abs(payda/pay) % mutlak de�erini ald�m.
zero=real(s1)/5 % s1 in reel k�sm�
G=limit(sys*C_lag,s,0) % K katsay�s�n� bulmak i�in sistemle gc yi carp�p limitini ald�m.
alfa=double(solve((Kv-G*K),alfa))
pole=double(zero/alfa)
T=double(1/zero)
Gc=tf([K 1/T],[1 1/(alfa*T)])
Key=abs(polyval([K 1/T],s1)/polyval([1 1/(alfa*T)],s1)) % kazanc� elde ettim.
x=polyval([K 1/T],s1)/polyval([1 1/(alfa*T)],s1)
fi=(atan(imag(x)/real(x))) % fi ac�s�n� buldum.
sys2=Gs*Gc
rlocus(sys2);
sys3=feedback(sys2,[1])
figure
step(sys3) % birim basamak
stepinfo(sys3)
