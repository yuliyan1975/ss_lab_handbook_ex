close all
clear all

Amp=1; % Amplitude
T=1; % Duration
tp=0.5; % Pulse duration
dt=0.001; % Sample time (step)
t=0:dt:T-dt; % Time
s=Amp*double(t<tp); % Rectangular pulse
cy=1; % Cycles
s=repmat(s,1,cy); % Repeat
t=linspace(0,cy*T-dt,length(s)); % Time
n=randn(1,length(t)); % Gaussian noise

% s=n; % Uncomment for WGN only 
% s=s+n; % Uncomment to add WGN to the signal

r=xcorr(s,s)*dt; % ACF
tau=linspace(-length(r)/2,length(r)/2,length(r))*dt; % ACF argument (tau). From (-length/2 to length/2)*dt

% Plots
figure('Name','ACF');
subplot(2,1,1) % First plot
plot(t,s);% Plot the signal
title('Signal'); % Title
xlabel('t [s]'); % X label
grid on
subplot(2,1,2) % Second plot
plot(tau,r); % Plot the ACF
title('ACF'); % Title
xlabel('\tau [s]'); % X label
ylabel('r(\tau)'); % Y label
grid on