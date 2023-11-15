close all
clear all

Ac=1;                   % Carrier amplitude
fc=2000;                % Carrier frequency
Am=1;                   % Modulating signal amplitude
fm=100;                 % Modulating signal frequency

wc=2*pi*fc;             % Angular frequency of the carrier
wm=2*pi*fm;             % Angular frequency of the modulating signal

t=linspace(0,0.1,1024); % Time
dt=t(2)-t(1);           % Time step
Fs=1/dt;                % Sampling frequency

%sm=Am*cos(wm*t);       % Harmonic (cosine) modulating
sm=Am*saw(t,wm,10);     % Sawtooth bipolar

I=sm.*cos(wc*t);
Q=-imag(hilbert(sm)).*-sin(wc*t);

sam_ssb=I+Q;

[b,a]=lpf(fc/2,5,Fs);   % Low-pass filter, 5-th order, fc/2 is the cut-off frequency
I=sam_ssb.*cos(wc*t);   % I
Q=sam_ssb.*-sin(wc*t);  % Q
sd=imag(hilbert(filtfilt(b,a,Q)))+filtfilt(b,a,I);

                        % Time domain plots
figure('Name','AM-SSB Time domain');
subplot(2,1,1);         % First plot (modulating)
plot(t,sm);             % Plot
xlabel('t [s]');        % X label
ylabel('s_{m}');        % Y label
subplot(2,1,2);         % Third plot (AM-SSB)
plot(t,sam_ssb);        % Plot
xlabel('t [s]');        % X label
ylabel('s_{AM-SSB}(t)');% Y label
                        % Figure
figure('Name','AM-SSB Demodulated (coherent)');
plot(t,sm,'b');         % Plot
hold on
plot(t,sd,'r');         % Plot
xlabel('t [s]');        % X label
grid on
legend('Original','Demodulated');

                        % Spectrum plot
spectr(sam_ssb,Fs,'AM-SSB');