close all
clear all

Ac=1;                   % Carrier amplitude
fc=2000;                % Carrier frequency
Am=1;                   % Modulating signal amplitude
fm=100;                 % Modulating signal frequency
phi=0;                  % Phase difference between carriers at the transmitter and receiver

wc=2*pi*fc;             % Angular frequency of the carrier
wm=2*pi*fm;             % Angular frequency of the modulating signal

t=linspace(0,0.1,1024); % Time
dt=t(2)-t(1);           % Time step
Fs=1/dt;                % Sampling frequency

sc=Ac*cos(wc*t+phi);    % Carrier

%sm=Am*cos(wm*t);       % Cosine modulating
sm=Am*saw(t,wm,10);     % Sawtooth bipolar
                        % Sawtooth unipolar
%sm=Am/2+0.5*Am*saw(t,wm,10);

sdsb_sc=sm.*sc;         % AM-DSB-SC

                        % Demodulation
[b,a]=lpf(fc/2,5,Fs);   % Low-pass filter, 5-th order, fc/2 is the cut-off frequency
                        % Filter the product: carrier x modulating
sd=filtfilt(b,a,(2*sdsb_sc.*cos(wc*t)));

                        % Time domain plots
figure('Name','DSB-SC Time domain');
subplot(3,1,1);         % First plot (modulating)
plot(t,sm);             % Plot
xlabel('t');            % X label
ylabel('s_{m}(t)');     % Y label
subplot(3,1,2);         % Second plot (carrier)
plot(t,sc);             % Plot
xlabel('t');            % X label
ylabel('s_{c}(t)');     % Y label
subplot(3,1,3);         % Third plot (AM-CS)
plot(t,sdsb_sc);        % Plot
xlabel('t');            % X label
                        % Y label
ylabel('s_{DSB-SC}(t)'); 
figure('Name','DSB-SC Demodulated (coherent)');
plot(t,sm,'b');         % Plot
hold on
plot(t,sd,'r');         % Plot
xlabel('t');            % X label
grid on
legend('Original','Demodulated');

                        % Spectrum plot
spectr(sdsb_sc, Fs,'DSB-SC');