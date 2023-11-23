close all
clear all

Ac=1; % Carrier amplitude
fc=2000; % Carrier frequency
Am=1; % Modulating signal amplitude
fm=100; % Modulating signal frequency

wc=2*pi*fc; % Angular frequency of the carrier
wm=2*pi*fm; % Angular frequency of the modulating signal

t=linspace(0,0.1,1024); % Time
dt=t(2)-t(1); % Time step
Fs=1/dt; % Sampling frequency

% sm=Am*cos(wm*t); % Cosine as modulating
sm=Am*saw(t,wm,10); % Sawtooth bipolar as modulating

% Modulation
I=sm.*cos(wc*t); % I
Q=-imag(hilbert(sm)).*-sin(wc*t); % Q
sam_ssb=I+Q; % Combine

% Demodulation
[b,a]=lpf(fc/2,5,Fs); % Low-pass filter, 5-th order, fc/2 is the cut-off frequency
I=sam_ssb.*cos(wc*t); % I
Q=sam_ssb.*-sin(wc*t); % Q
sd=imag(hilbert(filtfilt(b,a,Q)))+filtfilt(b,a,I); % Combine

% Time domain plots
figure('Name','AM-SSB Time domain');
subplot(2,1,1); % First subplot
plot(t,sm); % Plot the modulating
xlabel('t [s]'); % X-label
ylabel('s_{m}'); % Y-label
subplot(2,1,2); % Second subplot
plot(t,sam_ssb); % Plot the modulated
xlabel('t [s]'); % X-label
ylabel('s_{AM-SSB}(t)'); % Y-label
figure('Name','AM-SSB Demodulated (coherent)');
plot(t,sm,'b'); % Plot the modulating
hold on
plot(t,sd,'r'); % Plot the demodulated
xlabel('t [s]'); % X-label
grid on
legend('Original','Demodulated'); % Legend

spectr(sam_ssb,Fs,'AM-SSB'); % Spectrum plot