t1=scope6(:,1);
u1=scope6(:,2);
y1=scope6(:,3);
t1=t1-t1(1);
plot(t1,[u1 y1])

ylabel('Tensiunea [V]');
xlabel('Timp [s]');
title('Raspunsul la impuls');

i1=931;
i2=976;


yst1=mean(y1(i1:i2));
ust1=mean(u1(i1:i2));
k1=yst1/ust1
hold on
plot(t1,yst1*ones(1,length(t1)))
i3=534;
i4=672;
i5=807;
i6=571;
i7=724;


sigma1=sum(abs(y1(i4:i5)-yst1))/sum(y1(i3:i4)-yst1)
zeta1=-log(sigma1)/sqrt(pi^2+(log(sigma1)^2))

A11=sum(abs(y1(i3:i4)-yst1))*(t1(i4)-t1(i3))
A12=sum(abs(y1(i4:i5)-yst1))*(t1(i5)-t1(i4))

Tosc1=(t1(i7)-t1(i6));
wosc1=pi/(t1(i7)-t1(i6))
wn1=pi/(Tosc1*sqrt(1-zeta1^2))
H=tf(k1*wn1^2,[1 2*zeta1*wn1 wn1^2]);
A1=[0 1;-wn1^2 -2*zeta1*wn1];
B1=[0; k1*wn1^2];
C1=[1 0];
D1=[0];

figure
ysim1=lsim(A1,B1,C1,D1,u1,t1,[y1(1),0]);
plot(t1,[u1 y1])
hold on
plot(t1,ysim1,'g')
eMPN=norm(y1-ysim1)/norm(y1-mean(y1))



% figure
% 
% ysimItoS=lsim(A1,B1,C1,D1,u,t,[y(1),0]);
% plot(t,[u y ysimItoS])
% ylabel('u[V],y[V]');
% xlabel('Timp [s]');
% title('Raspunsul la Treapta cu fct de transfer de la Impuls');
% legend('Semnal intrare','Semnal iesire','Semnal simulat Impuls')
% eMPNItoS=norm(y-ysimItoS)/norm(y-mean(y))




%%%%%%%%%%%%%%%%%%     by Piciorus Ovidiu Mihai