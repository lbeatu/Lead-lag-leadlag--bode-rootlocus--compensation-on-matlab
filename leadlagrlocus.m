clc
clear all;
mp=0.8; % overshoot
ts=5;%% yerleþme zamaný
K=40; % lead katsayýsý
T2=10; % lag T2 periyodu 10 un katlarý verdim
  num=[0 2.646 32.86 101.8 43.84]
  den=[1 11.59 43.63 52.1 75.66]
%  num=[10]
%  den=[1 7 10 0]
sys=tf(num,den) %%2.646s^3 + 32.86 s^2 + 101.8 s + 43.84/  s^4 + 11.59 s^3 + 43.63 s^2 + 52.1 s + 75.66
zeta=1/(sqrt(1+(pi/log(mp))^2))  %overshoottan ? (sönümleme oraný)zetayý elde ettiðim denklem
wn=4/(zeta*ts) %ts=4/(zeta*wn); % dogal sönüm
beta=pi-acos(zeta) 
s1=complex(zeta*wn,sqrt(wn^2-(zeta*wn)^2))  %   0.8000 +11.2630i
% s1=complex(-2,2*sqrt(3))
pay=polyval(num,s1)
payda=polyval(den,s1)
x=pay/payda;
fi=(atan(imag(x)/real(x)))*180/pi
p=abs(s1)*sin((beta-fi)/2)/sin((beta+fi)/2) % lead-kontrolürün kutubu elde ettiðiz denklem
z=abs(s1)*sin((beta+fi)/2)/sin((beta-fi)/2) % -lead-kontrolürün sýfýrýný elde ettiðimz denklem
numc=[1 z] 
denc=[1 p]
sysc=tf(numc,denc) % lead tf
T1=1/z
alfa=double(T1*p)
numc1=[1 T2]
denc1=[1 1/(alfa*T2)]
sysc1=tf(numc1,denc1) %lag tf
Key=abs(polyval(numc1,s1)/polyval(denc1,s1))
x=polyval(numc1,s1)/polyval(denc1,s1)
fi=(atan(imag(x)/real(x))) % fi acýsý
sys2=sysc1*sysc*sys*K % close loop sistem
figure
rlocus(sys2);
sys3=feedback(sys2,[1])
figure
step(sys3)
stepinfo(sys3)
