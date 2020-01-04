mp=0.65;% overshoot
ts=4;  % yerle�me zaman�
num=[1.915 12.71 34.64 48.14 33.5 9.021]
den=[1 7.043 18.79 23.44 13.31 2.576]
% num=[1]
% den=[1 6 5 0]
Gs=tf(rss(5)) 
zeta=1/(sqrt(1+(pi/log(mp))^2)) % overshoottan ? (s�n�mleme oran�)zetay� elde etti�im denklem
wn=4/(zeta*ts) %ts=4/(zeta*wn); do�al s�n�m
s1=complex(-zeta*wn,sqrt(wn^2-(zeta*wn)^2)) % se�ti�imiz kutup -1.0000 + 2.6094i
pay=polyval(num,s1) ;   payda=polyval(den,s1); % pay ve paydada s1 i s yerine yazd�m
  % transfer fonksiyonunda s1 k�k�n� yazd�k
fi=(atan(imag(pay/payda)/real(pay/payda))) % � burdan s1 tf de yerine yaz�p a��y� elde ettik.
beta=(pi-acos(zeta)) % ? ac�s�
pole=abs(s1)*sin((beta-fi)/2)/sin((beta+fi)/2) % kontrol�r�n kutubu elde etti�iz denklem
zero=abs(s1)*sin((beta+fi)/2)/sin((beta-fi)/2) % kontrol�r�n s�f�r�n� elde etti�imz denklem
numc=[1 zero]
denc=[1 pole]
Gsc=tf(numc,denc) % kontrol�r�n tf si
payc=(polyval(numc,s1)) % kontrol�rde s1 i yerine yazd�k
paydac=(polyval(denc,s1)) 
alfa=zero/pole 
Kc=abs((payda*paydac)/(pay*payc)) % K katsay�s�n� bulduk
Gs2=Gs*Gsc % kontrol�r ve sistemimizin �arp�m�
figure
rlocus(Gs2); % son elde etti�imiz tf nin root-locus diyagram�
Gs3=feedback(Kc*Gs2,[1]) % close loop sistemim
figure
step(Gs3+1) % % birim basamak

stepinfo(Gs3) % stepteki rise time,overshoot gibi de�erler.


