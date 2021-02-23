% practise freq analysis for main
% struggling
% want to extract freq, phase and amplitude from a signal in units we
% understand

n = 100;
x = 1:0.1:n;
eps = 1;
y1 = sin(x);
y2 = sin(x + eps);

figure(1)
plot(x,y1); hold on;
plot(x,y2)

figure(2)
subplot(1,2,1)
[pxx1] = periodogram(y1);
[pxx2, f] = periodogram(y2);
plot(f,pxx1)
hold on;
plot(f,pxx2)

subplot(1,2,2)
fy1 = fft(y1);
f1 = (0:length(fy1)-1)*50/length(fy1);
plot(f1,abs(fy1)); hold on;

fy2 = fft(y2);
f2 = (0:length(fy2)-1)*50/length(fy2);
plot(f2,abs(fy2));