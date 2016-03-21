clear all;
close all;
clc;
Fs1=30.72; % sampling Frequency 1
Fs2=61.44; % sampling Frequency 2
order1=50; % order 1
order2=90; % order 2
fc1=9; % Cutoff Frequency 1
fc2=9; % Cutoff Frequency 2
Fc1=fc1/(Fs1); % New Corner Frequency 1
Fc2=fc2/(Fs2); % New Corner Frequency 2
num1=fir1(order1,Fc1,'low',hann(order1+1)); % Numerator value 1 
num2=fir1(order2,Fc2,'low',hann(order2+1)); % Numerator value 2
den1=[1]; % Denominator Value 1
den2=[1]; % Denominator Value 2
% Generating random signal
f=1:1e+9:10e+9; % random frequency
t=0:0.01:2*pi;  % random time
x=zeros(1,length(t)); % define range
for i=1:length(f); 
x=x+sin(2*pi*f(i)*t); % sine wave form
end
% Random Signal
figure;plot(x,'r');title('input signal generation'); 
% noise adding
snr=2.51; % signal to noise ratio
x_noise=awgn(x,snr);
% plotting noise signal
figure;plot(x_noise,'g');title('noise signal')
% clip signal
x_noise(x_noise> 1.5585)=1.5585;
x_noise(x_noise<-1.5585)=-1.5585;
figure; plot(x_noise); title('Clipped Noise signal');
% FFT of Clipped Signal"
figure;plot(abs(fft(x_noise)),'y');
title('FFT of clipped noise signal');
% send through filter
y1=filter(num1,den1,x_noise);
y2=filter(num2,den2,x_noise);
% frequancy domain
figure;subplot(2,1,1); plot (y1);title('Filter 1 signal ');
subplot(2,1,2);plot (y2);title('Filter 2 signal');
%FFT of filtered signal
figure;subplot(2,1,1); plot(abs(fft(y1)),'b'); 
title('FFT of filtered 1 signal');
subplot(2,1,2); plot(abs(fft(y2)),'b'); 
title('FFT of filter 2 signal');
% Frequency Response of the filter 1
figure;subplot(2,1,1);
freqz(num1,den1);title('FILTER 1 FREQ RESPONSE');
figure;subplot(2,1,2);
freqz(num2,den2);title('FILTER 2 FREQ RESPONSE');
