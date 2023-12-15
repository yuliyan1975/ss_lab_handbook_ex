close all
clear all

Ac=1; % Carrier amplitude
fc=2000; % Carrier frequency
fm=100; % Modulating signal frequency
m=0.5; % Modulation index

Am=m*Ac; % Modulating signal amplitude
wc=2*pi*fc; % Angular frequency of the carrier
wm=2*pi*fm; % Angular frequency of the modulating signal

t=linspace(0,0.1,1024); % Time
dt=t(2)-t(1); % Time step
Fs=1/dt; % Sampling frequency

sc=Ac*cos(wc*t); % Carrier

sm=Am*cos(wm*t); % Cosine modulating
% sm=Am*saw(t,wm,10); % Sawtooth bipolar

sam=(Ac+sm).*cos(wc*t); % AM signal

% Demodulation
[b,a]=lpf(fc/2,5,Fs); % Low-pass filter, 5-th order, fc/2 is the cut-off frequency
sd=filtfilt(b,a,abs(sam)); % Filter the absolute value of the AM

% Time domain plots
figure('Name','AM Time domain');
subplot(3,1,1); % First subplot
plot(t,sm); % Plot the modulating signal
xlabel('t'); % X-label
ylabel('s_{m}(t)'); % Y-label
subplot(3,1,2); % Second subplot
plot(t,sc); % Plot the carrier
xlabel('t'); % X-label
ylabel('s_{c}(t)'); % Y-label
subplot(3,1,3); % Third subplot
plot(t,sam); % Plot the AM
xlabel('t'); % X-label
ylabel('s_{AM}(t)'); % Y-label
figure('Name','AM Demodulated (non-coherent)');
plot(t,sm,'b'); % Plot the modulating signal
hold on
plot(t,sd,'r'); % Plot the demodulated signal
xlabel('t'); % X-label
grid on
legend('Original','Demodulated'); % Legend
spectr(sam,Fs,'AM'); % Spectrum plot