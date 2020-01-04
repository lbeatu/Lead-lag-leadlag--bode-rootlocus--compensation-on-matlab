mp=0.65;% overshoot
ts=4;  % yerleþme zamaný
num=[1.915 12.71 34.64 48.14 33.5 9.021]
den=[1 7.043 18.79 23.44 13.31 2.576]
% num=[1]
% den=[1 6 5 0]
Gs=tf(rss(5)) 
zeta=1/(sqrt(1+(pi/log(mp))^2)) % overshoottan ? (sönümleme oraný)zetayý elde ettiðim denklem
wn=4/(zeta*ts) %ts=4/(zeta*wn); doðal sönüm
s1=complex(-zeta*wn,sqrt(wn^2-(zeta*wn)^2)) % seçtiðimiz kutup -1.0000 + 2.6094i
pay=polyval(num,s1) ;   payda=polyval(den,s1); % pay ve paydada s1 i s yerine yazdým
  % transfer fonksiyonunda s1 kökünü yazdýk
fi=(atan(imag(pay/payda)/real(pay/payda))) % Ø burdan s1 tf de yerine yazýp açýyý elde ettik.
beta=(pi-acos(zeta)) % ? acýsý
pole=abs(s1)*sin((beta-fi)/2)/sin((beta+fi)/2) % kontrolürün kutubu elde ettiðiz denklem
zero=abs(s1)*sin((beta+fi)/2)/sin((beta-fi)/2) % kontrolürün sýfýrýný elde ettiðimz denklem
numc=[1 zero]
denc=[1 pole]
Gsc=tf(numc,denc) % kontrolürün tf si
payc=(polyval(numc,s1)) % kontrolürde s1 i yerine yazdýk
paydac=(polyval(denc,s1)) 
alfa=zero/pole 
Kc=abs((payda*paydac)/(pay*payc)) % K katsayýsýný bulduk
Gs2=Gs*Gsc % kontrolür ve sistemimizin çarpýmý
figure
rlocus(Gs2); % son elde ettiðimiz tf nin root-locus diyagramý
Gs3=feedback(Kc*Gs2,[1]) % close loop sistemim
figure
step(Gs3+1) % % birim basamak

stepinfo(Gs3) % stepteki rise time,overshoot gibi deðerler.


