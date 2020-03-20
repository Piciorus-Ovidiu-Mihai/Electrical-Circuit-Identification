t=scope7(:,1);
u=scope7(:,2);
y=scope7(:,3);
t=t-t(1);
plot(t,[u y])

i1=417;
i2=500;
i3=913; 
i4=972;

yst=mean(y(i3:i4));
ust=mean(u(i3:i4));
y0=mean(y(i1:i2));
u0=mean(u(i1:i2));

k=(yst-y0)/(ust-u0)
hold on
plot(t,yst+0.05.*yst.*ones(1,length(t)),t,yst-0.05.*yst.*ones(1,length(t)))


i5=655;

ymax=y(i5);
sigma=(ymax-yst)/(yst-y0);
zeta=-log(sigma)/sqrt(pi^2+(log(sigma))^2)

i6=865; 

tr=t(i6)-t(i2)
wn=4/(zeta*tr)

H=tf(k*wn^2,[1 2*zeta*wn wn^2]);
% ysim=lsim(H,u,t);
% hold on
% plot(t,ysim,'g')

A=[0 1; -wn^2 -2*zeta*wn];
B=[0; k*wn^2];
C=[1 0];
D=0;
ysim1=lsim(A,B,C,D,u,t,[y(1),0]);
figure
plot(t,[u,y])
hold on
plot(t,ysim1,'g')

J=norm(y-ysim1)
eMPN=norm(y-ysim1)/norm(y-mean(y))



ysimStoI=lsim(A,B,C,D,u1,t1,[y1(1),0]);
plot(t1,[u1 y1 ysimStoI])
ylabel('u[V],y[V]');
xlabel('Timp [s]');
title('Raspunsul la Impuls cu fct de transfer de la Treapta');
legend('Semnal intrare','Semnal iesire','Semnal simulat Treapta')
eMPNStoI=norm(y1-ysimStoI)/norm(y1-mean(y1))

