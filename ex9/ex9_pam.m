close all
clear all

Ac=1; % Carrier amplitude
fc=5000; % Carrier frequency
fm=100; % Frequency of the modulating signal
Am=0.5; % Modulating signal amplitude
duty=0.25; % Duty cycle

wc=2*pi*fc; % Angular frequency of the carrier
wm=2*pi*fm; % Angular frequency of the modulating signal
Tc=1/fc; % Carrier period

t=linspace(0,100*Tc,8000); % Time for 100 periods
dt=t(2)-t(1); % Time step (sampling time)
Fs=1/dt; % Sampling frequency

% Modulation
sm=Am*cos(wm*t);        % Cosine as modulating
% sm=Am*saw(t,wm,10);    % Sawtooth as modulating

sc=Ac*pulstran(t,0:1/fc:t(end),'rectpuls',duty/fc); % Carrier
spam=(1+sm).*sc; % PAM

% Demodulation
sd=(1/duty)*restoration_lpf(spam,fc/2,Fs); % Low pass filtering (demodulation)

% Plots
figure('Name','PAM');
ax1=subplot(3,1,1); % First subplot
plot(t,sm); % Plot the modulating
xlabel('t [s]'); % X-label
ylabel('s_{m}(t)'); % Y-label
ax2=subplot(3,1,2); % Second subplot
plot(t,sc); % Plot the carrier
ylim([-0.1 1.1*Ac]); % Y-limits
xlabel('t [s]'); % X label
ylabel('s_{c}(t)'); % Y label
grid on
ax3=subplot(3,1,3); % Third subplot
plot(t,spam); % Plot the PAM
ylim([-0.1 1.1*(1+Am)*Ac]); % Y-limits
xlabel('t [s]'); % X-label
ylabel('s_{PAM}(t)'); % Y-label
grid on
linkaxes([ax1,ax2,ax3],'x') % Same scale and position
figure('Name','PAM Demodulated');
plot(t,sm,'b'); % Plot the modulating signal
hold on
plot(t,sd,'r'); % Plot the demodulated signal
xlabel('t [s]'); % X-label
grid on
legend('Original','Demodulated'); % Legend

% Spectrum
spectr(spam,Fs,'PAM',[0 25000]); % PAM spectrum