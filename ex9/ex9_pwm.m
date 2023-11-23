close all
clear all

Ac=1; % Carrier amplitude
fc=5000; % Carrier frequency
Am=1; % Amplitude of the modulating signal
fm=100; % Frequency of the modulating signal
Rm=Am*1.1; % Reference amplitude
two_sided=0; % One sided/two sided

wm=2*pi*fm; % Angular frequency of the modulating signal
Tc=1/fc; % Carrier period
t=linspace(0,100*Tc,8000); % Time for 100 periods
dt=t(2)-t(1); % Time step (sampling time)
Fs=1/dt; % Sampling frequency

if two_sided==0 % If one sided
    r_=(2*Rm/Tc)*(0:dt:Tc)-Rm; % Reference for 1 period
else
  r_=(2*Rm/(Tc/2))*(0:dt:Tc/2)-Rm; % Reference for 1/2 period
  r_=[r_,fliplr(r_)]; % Make two slopes
end
r=repmat(r_,1,ceil(length(t)/length(r_))); % Repeat
r=r(1:length(t)); % Crop
 
% Modulation
sm=Am*cos(wm*t); % Modulating signal
spwm=Ac*double(sm>r); % PWM, A0 if sm>ref, 0 otherwise

% Demodulation
sd=restoration_lpf(spwm,fc/2,Fs); % Low pass filtering

% Plots
figure('Name','PWM'); % Figure
ax1=subplot(2,1,1); % First subplot
plot(t,sm,'b'); % Plot the modulating
hold on;
plot(t,r,'r'); % Plot the reference
xlabel('t [s]'); % X-label
ylabel('s_{m}(t), r(t)'); % Y-label
legend('s_{m}(t)','r(t)'); % Legend
grid on
ax2=subplot(2,1,2); % Second subplot
plot(t,spwm,'b'); % Plot the PWM
ylim([-0.1 1.1*Ac]); % Y limits
xlabel('t [s]'); % X-label
ylabel('s_{PWM}(t)'); % Y-label
grid on
linkaxes([ax1,ax2],'x') % Same scale and position
figure('Name','PWM Demodulated');
plot(t,sm,'b'); % Plot the modulating
hold on
plot(t,sd,'r'); % Plot the demodulated
xlabel('t [s]'); % X label
grid on
legend('Original','Demodulated'); % Legend

spectr(spwm,Fs,'PWM',[0 15000]); % Spectrum