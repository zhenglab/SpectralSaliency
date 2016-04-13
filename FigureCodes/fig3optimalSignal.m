% 此程序用于实验不同长度sin信号所对应最优的sigma的值，其中sigma取的是2^k（k=0,1,2,3,4,5,6,7,8,9），
% 这儿选用的信号是两种信号的叠加，即背景和前景，该实验能够通过计算变换重构后信号和重构前信号的方差，
% 寻找方差最小的值作为所对应的最优的sigma。

clc;clear;close all;

% t=[0:1:1000];
% yf=0.*(t<=460)+sin(2*pi*0.2*t).*(t>460&t<=560)-0.*(t>560);
% yf_phase=angle(fft(yf));
% yb=sin(2*pi*0.05*t);
% yb_phase=angle(fft(yb));
% y=yb+yf;
% myfft=fft(y);
% myamplitude=abs(myfft);
% myphase=angle(myfft);
% mylogamplitude=log(myamplitude);
% 
% sgm1=0.5;
% mylogampfilter1=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm1));
% myampfilter1=exp(mylogampfilter1);
% y_f1=ifft(exp(mylogampfilter1+i*yf_phase));
% y_F1=real(y_f1);
% 
% y_b_logamplitude1=log(myamplitude-myampfilter1);
% y_b1=ifft(exp(y_b_logamplitude1+i*yb_phase));
% y_B1=real(y_b1);
% 
% yb_variance1=(yb-y_B1).^2;
% yf_variance1=(yf-y_F1).^2;
% [M N]=size(yb_variance1);
% yb_V1=0;
% yf_V1=0;
% for n=1:N
%     yb_V1=yb_V1+yb_variance1(1,n);
%     yf_V1=yf_V1+yf_variance1(1,n);
% end
% % subplot(331);
% % plot(t,y);
% % title('The original signal')
% subplot(10,2,1);
% plot(t,y_f1);
% title('The new foreground signal1')
% subplot(10,2,2);
% plot(t,y_b1);
% title('The new background signal1')
% 
% sgm2=1;
% mylogampfilter2=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm2));
% myampfilter2=exp(mylogampfilter2);
% y_f2=ifft(exp(mylogampfilter2+i*yf_phase));
% y_F2=real(y_f2);
% 
% y_b_logamplitude2=log(myamplitude-myampfilter2);
% y_b2=ifft(exp(y_b_logamplitude2+i*yb_phase));
% y_B2=real(y_b2);
% 
% yb_variance2=(yb-y_B2).^2;
% yf_variance2=(yf-y_F2).^2;
% [M N]=size(yb_variance2);
% yb_V2=0;
% yf_V2=0;
% for n=1:N
%     yb_V2=yb_V2+yb_variance2(1,n);
%     yf_V2=yf_V2+yf_variance2(1,n);
% end
% % subplot(331);
% % plot(t,y);
% % title('The original signal')
% subplot(10,2,3);
% plot(t,y_f2);
% title('The new foreground signal2')
% subplot(10,2,4);
% plot(t,y_b2);
% title('The new background signal2')
% 
% 
% sgm3=2;
% mylogampfilter3=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm3));
% myampfilter3=exp(mylogampfilter3);
% y_f3=ifft(exp(mylogampfilter3+i*yf_phase));
% y_F3=real(y_f3);
% 
% y_b_logamplitude3=log(myamplitude-myampfilter3);
% y_b3=ifft(exp(y_b_logamplitude3+i*yb_phase));
% y_B3=real(y_b3);
% 
% yb_variance3=(yb-y_B3).^2;
% yf_variance3=(yf-y_F3).^2;
% yb_V3=0;
% yf_V3=0;
% for n=1:N
%     yb_V3=yb_V3+yb_variance3(1,n);
%     yf_V3=yf_V3+yf_variance3(1,n);
% end
% subplot(10,2,5);
% plot(t,y_f3);
% title('The new foreground signal3')
% subplot(10,2,6);
% plot(t,y_b3);
% title('The new background signal3')
% 
% sgm4=4;
% mylogampfilter4=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm4));
% myampfilter4=exp(mylogampfilter4);
% y_f4=ifft(exp(mylogampfilter4+i*yf_phase));
% y_F4=real(y_f4);
% 
% y_b_logamplitude4=log(myamplitude-myampfilter4);
% y_b4=ifft(exp(y_b_logamplitude4+i*yb_phase));
% y_B4=real(y_b4);
% 
% yb_variance4=(yb-y_B4).^2;
% yf_variance4=(yf-y_F4).^2;
% yb_V4=0;
% yf_V4=0;
% for n=1:N
%     yb_V4=yb_V4+yb_variance4(1,n);
%     yf_V4=yf_V4+yf_variance4(1,n);
% end
% subplot(10,2,7);
% plot(t,y_f4);
% title('The new foreground signal4')
% subplot(10,2,8);
% plot(t,y_b4);
% title('The new background signal4')
% 
% 
% sgm5=8;
% mylogampfilter5=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm5));
% myampfilter5=exp(mylogampfilter5);
% y_f5=ifft(exp(mylogampfilter5+i*yf_phase));
% y_F5=real(y_f5);
% 
% y_b_logamplitude5=log(myamplitude-myampfilter5);
% y_b5=ifft(exp(y_b_logamplitude5+i*yb_phase));
% y_B5=real(y_b5);
% 
% yb_variance5=(yb-y_B5).^2;
% yf_variance5=(yf-y_F5).^2;
% yb_V5=0;
% yf_V5=0;
% for n=1:N
%     yb_V5=yb_V4+yb_variance5(1,n);
%     yf_V5=yf_V5+yf_variance5(1,n);
% end
% subplot(10,2,9);
% plot(t,y_f5);
% title('The new foreground signal5')
% subplot(10,2,10);
% plot(t,y_b5);
% title('The new background signal5')
% 
% 
% sgm6=16;
% mylogampfilter6=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm6));
% myampfilter6=exp(mylogampfilter6);
% y_f6=ifft(exp(mylogampfilter6+i*myphase));
% y_F6=real(y_f6);
% 
% y_b_logamplitude6=log(myamplitude-myampfilter6);
% y_b6=ifft(exp(y_b_logamplitude6+i*myphase));
% y_B6=real(y_b6);
% 
% yb_variance6=(yb-y_B6).^2;
% yf_variance6=(yf-y_F6).^2;
% yb_V6=0;
% yf_V6=0;
% for n=1:N
%     yb_V6=yb_V6+yb_variance6(1,n);
%     yf_V6=yf_V6+yf_variance6(1,n);
% end
% subplot(10,2,11);
% plot(t,y_f6);
% title('The new foreground signal6')
% subplot(10,2,12);
% plot(t,y_b6);
% title('The new background signal6')
% 
% 
% sgm7=32;
% mylogampfilter7=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm7));
% myampfilter7=exp(mylogampfilter7);
% y_f7=ifft(exp(mylogampfilter7+i*myphase));
% y_F7=real(y_f7);
% 
% y_b_logamplitude7=log(myamplitude-myampfilter7);
% y_b7=ifft(exp(y_b_logamplitude7+i*myphase));
% y_B7=real(y_b7);
% 
% yb_variance7=(yb-y_B7).^2;
% yf_variance7=(yf-y_F7).^2;
% yb_V7=0;
% yf_V7=0;
% for n=1:N
%     yb_V7=yb_V7+yb_variance7(1,n);
%     yf_V7=yf_V7+yf_variance7(1,n);
% end
% subplot(10,2,13);
% plot(t,y_f7);
% title('The new foreground signal7')
% subplot(10,2,14);
% plot(t,y_b7);
% title('The new background signal7')
% 
% 
% sgm8=64;
% mylogampfilter8=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm8));
% myampfilter8=exp(mylogampfilter8);
% y_f8=ifft(exp(mylogampfilter8+i*myphase));
% y_F8=real(y_f8);
% 
% y_b_logamplitude8=log(myamplitude-myampfilter8);
% y_b8=ifft(exp(y_b_logamplitude8+i*myphase));
% y_B8=real(y_b8);
% 
% yb_variance8=(yb-y_B8).^2;
% yf_variance8=(yf-y_F8).^2;
% yb_V8=0;
% yf_V8=0;
% for n=1:N
%     yb_V8=yb_V8+yb_variance8(1,n);
%     yf_V8=yf_V8+yf_variance8(1,n);
% end
% subplot(10,2,15);
% plot(t,y_f8);
% title('The new foreground signal8')
% subplot(10,2,16);
% plot(t,y_b8);
% title('The new background signal8')
% 
% 
% sgm9=128;
% mylogampfilter9=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm9));
% myampfilter9=exp(mylogampfilter9);
% y_f9=ifft(exp(mylogampfilter9+i*myphase));
% y_F9=real(y_f9);
% 
% y_b_logamplitude9=log(myamplitude-myampfilter9);
% y_b9=ifft(exp(y_b_logamplitude9+i*myphase));
% y_B9=real(y_b9);
% 
% yb_variance9=(yb-y_B9).^2;
% yf_variance9=(yf-y_F9).^2;
% yb_V9=0;
% yf_V9=0;
% for n=1:N
%     yb_V9=yb_V9+yb_variance9(1,n);
%     yf_V9=yf_V9+yf_variance9(1,n);
% end
% subplot(10,2,17);
% plot(t,y_f9);
% title('The new foreground signal9')
% subplot(10,2,18);
% plot(t,y_b9);
% title('The new background signal9')
% 
% 
% sgm10=256;
% mylogampfilter10=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm10));
% myampfilter10=exp(mylogampfilter10);
% y_f10=ifft(exp(mylogampfilter10+i*myphase));
% y_F10=real(y_f10);
% 
% y_b_logamplitude10=log(myamplitude-myampfilter10);
% y_b10=ifft(exp(y_b_logamplitude10+i*myphase));
% y_B10=real(y_b10);
% 
% yb_variance10=(yb-y_B10).^2;
% yf_variance10=(yf-y_F10).^2;
% yb_V10=0;
% yf_V10=0;
% for n=1:N
%     yb_V10=yb_V10+yb_variance10(1,n);
%     yf_V10=yf_V10+yf_variance10(1,n);
% end
% subplot(10,2,19);
% plot(t,y_f10);
% title('The new foreground signal10')
% subplot(10,2,20);
% plot(t,y_b10);
% title('The new background signal10')
t=[0:1:1000];
yf=0.*(t<=500)+sin(2*pi*0.2*t).*(t>500&t<=600)-0.*(t>600);
yf_phase=angle(fft(yf));
yb=sin(2*pi*0.05*t);
yb_phase=angle(fft(yb));
y=yb+yf;
subplot(10,1,1)
plot(t,y)
title('original signal')
myfft=fft(y);
myamplitude=abs(myfft);
myphase=angle(myfft);
mylogamplitude=log(myamplitude);

sgm1=0.5;
mylogampfilter1=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm1));
myampfilter1=exp(mylogampfilter1);
y_f1=ifft(exp(mylogampfilter1+i*yf_phase));
y_F1=real(y_f1);

y_b_logamplitude1=log(myamplitude-myampfilter1);
y_b1=ifft(exp(y_b_logamplitude1+i*yb_phase));
y_B1=real(y_b1);

yb_variance1=(yb-y_B1).^2;
yf_variance1=(yf-y_F1).^2;
[M N]=size(yb_variance1);
yb_V1=0;
yf_V1=0;
for n=1:N
    yb_V1=yb_V1+yb_variance1(1,n);
    yf_V1=yf_V1+yf_variance1(1,n);
end
% subplot(331);
% plot(t,y);
% title('The original signal')
subplot(10,1,2);
plot(t,y_f1);
axis([0 1000 -2 2])
title('reconstructed foreground signal 1 (\sigma = 0.5)')
% subplot(10,2,2);
% plot(t,y_b1);
% title('The new background signal1')

sgm2=1;
mylogampfilter2=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm2));
myampfilter2=exp(mylogampfilter2);
y_f2=ifft(exp(mylogampfilter2+i*yf_phase));
y_F2=real(y_f2);

y_b_logamplitude2=log(myamplitude-myampfilter2);
y_b2=ifft(exp(y_b_logamplitude2+i*yb_phase));
y_B2=real(y_b2);

yb_variance2=(yb-y_B2).^2;
yf_variance2=(yf-y_F2).^2;
[M N]=size(yb_variance2);
yb_V2=0;
yf_V2=0;
for n=1:N
    yb_V2=yb_V2+yb_variance2(1,n);
    yf_V2=yf_V2+yf_variance2(1,n);
end
% subplot(331);
% plot(t,y);
% title('The original signal')
subplot(10,1,3);
plot(t,y_f2);
axis([0 1000 -2 2])
title('reconstructed foreground signal 2 (\sigma = 1)')
% subplot(10,2,4);
% plot(t,y_b2);
% title('The new background signal2')


sgm3=2;
mylogampfilter3=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm3));
myampfilter3=exp(mylogampfilter3);
y_f3=ifft(exp(mylogampfilter3+i*yf_phase));
y_F3=real(y_f3);

y_b_logamplitude3=log(myamplitude-myampfilter3);
y_b3=ifft(exp(y_b_logamplitude3+i*yb_phase));
y_B3=real(y_b3);

yb_variance3=(yb-y_B3).^2;
yf_variance3=(yf-y_F3).^2;
yb_V3=0;
yf_V3=0;
for n=1:N
    yb_V3=yb_V3+yb_variance3(1,n);
    yf_V3=yf_V3+yf_variance3(1,n);
end
subplot(10,1,4);
plot(t,y_f3);
axis([0 1000 -2 2])
title('reconstructed foreground signal 3 (\sigma = 2)')
% subplot(10,2,6);
% plot(t,y_b3);
% title('The new background signal3')

sgm4=4;
mylogampfilter4=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm4));
myampfilter4=exp(mylogampfilter4);
y_f4=ifft(exp(mylogampfilter4+i*yf_phase));
y_F4=real(y_f4);

y_b_logamplitude4=log(myamplitude-myampfilter4);
y_b4=ifft(exp(y_b_logamplitude4+i*yb_phase));
y_B4=real(y_b4);

yb_variance4=(yb-y_B4).^2;
yf_variance4=(yf-y_F4).^2;
yb_V4=0;
yf_V4=0;
for n=1:N
    yb_V4=yb_V4+yb_variance4(1,n);
    yf_V4=yf_V4+yf_variance4(1,n);
end
subplot(10,1,5);
plot(t,y_f4,'color','r');
axis([0 1000 -2 2])
title('reconstructed foreground signal 4 (\sigma = 4)','color','r')
% subplot(10,2,8);
% plot(t,y_b4);
% title('The new background signal4')


sgm5=8;
mylogampfilter5=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm5));
myampfilter5=exp(mylogampfilter5);
y_f5=ifft(exp(mylogampfilter5+i*yf_phase));
y_F5=real(y_f5);

y_b_logamplitude5=log(myamplitude-myampfilter5);
y_b5=ifft(exp(y_b_logamplitude5+i*yb_phase));
y_B5=real(y_b5);

yb_variance5=(yb-y_B5).^2;
yf_variance5=(yf-y_F5).^2;
yb_V5=0;
yf_V5=0;
for n=1:N
    yb_V5=yb_V4+yb_variance5(1,n);
    yf_V5=yf_V5+yf_variance5(1,n);
end
subplot(10,1,6);
plot(t,y_f5);
axis([0 1000 -2 2])
title('reconstructed foreground signal 5 (\sigma = 8)')
% subplot(10,2,10);
% plot(t,y_b5);
% title('The new background signal5')


sgm6=16;
mylogampfilter6=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm6));
myampfilter6=exp(mylogampfilter6);
y_f6=ifft(exp(mylogampfilter6+i*myphase));
y_F6=real(y_f6);

y_b_logamplitude6=log(myamplitude-myampfilter6);
y_b6=ifft(exp(y_b_logamplitude6+i*myphase));
y_B6=real(y_b6);

yb_variance6=(yb-y_B6).^2;
yf_variance6=(yf-y_F6).^2;
yb_V6=0;
yf_V6=0;
for n=1:N
    yb_V6=yb_V6+yb_variance6(1,n);
    yf_V6=yf_V6+yf_variance6(1,n);
end
subplot(10,1,7);
plot(t,y_f6);
axis([0 1000 -2 2])
title('reconstructed foreground signal 6 (\sigma = 16)')
% subplot(10,2,12);
% plot(t,y_b6);
% title('The new background signal6')


sgm7=32;
mylogampfilter7=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm7));
myampfilter7=exp(mylogampfilter7);
y_f7=ifft(exp(mylogampfilter7+i*myphase));
y_F7=real(y_f7);

y_b_logamplitude7=log(myamplitude-myampfilter7);
y_b7=ifft(exp(y_b_logamplitude7+i*myphase));
y_B7=real(y_b7);

yb_variance7=(yb-y_B7).^2;
yf_variance7=(yf-y_F7).^2;
yb_V7=0;
yf_V7=0;
for n=1:N
    yb_V7=yb_V7+yb_variance7(1,n);
    yf_V7=yf_V7+yf_variance7(1,n);
end
subplot(10,1,8);
plot(t,y_f7);
axis([0 1000 -2 2])
title('reconstructed foreground signal 7 (\sigma = 32)')
% subplot(10,2,14);
% plot(t,y_b7);
% title('The new background signal7')


sgm8=64;
mylogampfilter8=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm8));
myampfilter8=exp(mylogampfilter8);
y_f8=ifft(exp(mylogampfilter8+i*myphase));
y_F8=real(y_f8);

y_b_logamplitude8=log(myamplitude-myampfilter8);
y_b8=ifft(exp(y_b_logamplitude8+i*myphase));
y_B8=real(y_b8);

yb_variance8=(yb-y_B8).^2;
yf_variance8=(yf-y_F8).^2;
yb_V8=0;
yf_V8=0;
for n=1:N
    yb_V8=yb_V8+yb_variance8(1,n);
    yf_V8=yf_V8+yf_variance8(1,n);
end
subplot(10,1,9);
plot(t,y_f8);
axis([0 1000 -2 2])
title('reconstructed foreground signal 8 (\sigma = 64)')
% subplot(10,2,16);
% plot(t,y_b8);
% title('The new background signal8')


sgm9=128;
mylogampfilter9=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm9));
myampfilter9=exp(mylogampfilter9);
y_f9=ifft(exp(mylogampfilter9+i*myphase));
y_F9=real(y_f9);

y_b_logamplitude9=log(myamplitude-myampfilter9);
y_b9=ifft(exp(y_b_logamplitude9+i*myphase));
y_B9=real(y_b9);

yb_variance9=(yb-y_B9).^2;
yf_variance9=(yf-y_F9).^2;
yb_V9=0;
yf_V9=0;
for n=1:N
    yb_V9=yb_V9+yb_variance9(1,n);
    yf_V9=yf_V9+yf_variance9(1,n);
end
subplot(10,1,10);
plot(t,y_f9);
axis([0 1000 -2 2])
title('reconstructed foreground signal 9 (\sigma = 128)')

print('-dpdf','-r1000','optimalScale');% subplot(10,2,18);
% plot(t,y_b9);
% title('The new background signal9')


% sgm10=256;
% mylogampfilter10=imfilter(mylogamplitude, fspecial('gaussian',[1 500],sgm10));
% myampfilter10=exp(mylogampfilter10);
% y_f10=ifft(exp(mylogampfilter10+i*myphase));
% y_F10=real(y_f10);
% 
% y_b_logamplitude10=log(myamplitude-myampfilter10);
% y_b10=ifft(exp(y_b_logamplitude10+i*myphase));
% y_B10=real(y_b10);
% 
% yb_variance10=(yb-y_B10).^2;
% yf_variance10=(yf-y_F10).^2;
% yb_V10=0;
% yf_V10=0;
% for n=1:N
%     yb_V10=yb_V10+yb_variance10(1,n);
%     yf_V10=yf_V10+yf_variance10(1,n);
% end
% subplot(10,1,10);
% plot(t,y_f10);
% axis([0 1000 -2 2])
% title('The new foreground signal10')
% % subplot(10,2,20);
% % plot(t,y_b10);
% % title('The new background signal10')