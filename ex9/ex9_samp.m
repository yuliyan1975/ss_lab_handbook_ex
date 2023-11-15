close all
clear all

f0=100;                 % Fundamental frequency 
T0=1/f0;                % Fundamental period
Fs=5000;                % Sampling frequency
duty=0.1;               % Duty cycle

t=linspace(0,2*T0,8000);% Time for 2 periods
dt=t(2)-t(1);           % Time step

s=saw(t,2*pi*f0,10);    % The signal. Up to 10-th harmonic

                        % Sampling pulses
p=pulstran(t,0:1/Fs:t(end),'rectpuls',duty/Fs);
ssamp=(s).*p;           % Sampling
                        % Restoration (LPF)
srest=(1/duty)*restoration_lpf(ssamp,Fs/2,1/dt);

                        % Time plots
figure('Name','Sampling and restoration');
plot(t,s,'b');          % Continuous
hold on
plot(t,ssamp,'g')       % Sampled
plot(t,srest,'r')       % Restored
xlabel('t [s]');        % X label
ylabel('Amplitude');    % Y label
                        % Legend
legend('Continuous','Sampled','Restored');
grid on

                        % Spectrum
                        % Continuous
spectr(s,1/dt,'Continuous',[0 15000]);
                        % Sampled
spectr(ssamp,1/dt,'Sampled',[0 15000]);