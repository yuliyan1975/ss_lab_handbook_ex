close all
clear all

f0=100; % Fundamental frequency 
T0=1/f0; % Fundamental period
Fs=5000; % Sampling frequency
duty=0.1; % Duty cycle

t=linspace(0,2*T0,8000); % Time for 2 periods
dt=t(2)-t(1); % Time step

s=saw(t,2*pi*f0,10); % The signal. Up to 10-th harmonic

p=pulstran(t,0:1/Fs:t(end),'rectpuls',duty/Fs); % Sampling pulses
ssamp=s.*p; % Sampling
                     
srest=(1/duty)*restoration_lpf(ssamp,Fs/2,1/dt); % Restoration (LPF)

% Time plots
figure('Name','Sampling and restoration');
plot(t,s,'b'); % Plot the continuous
hold on
plot(t,ssamp,'g'); % Plot the sampled
plot(t,srest,'r'); % Plot the restored
xlabel('t [s]'); % X-label
ylabel('Amplitude'); % Y-label
legend('Continuous','Sampled','Restored'); % Legend
grid on

% Spectrum
spectr(s,1/dt,'Continuous',[0 15000]); % Continuous
spectr(ssamp,1/dt,'Sampled',[0 15000]); % Sampled