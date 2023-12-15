clear all
close all

delay=0.05; % Delay
snr=Inf; % Signal-to-noise ratio
T=0.1; % Total dration
t0=0.01; % Pulse duration
dt=1.0e-6; % Time step
f0=1000; % Lowest frequency
f1=10000; % Highest frequency
t0=0:dt:t0-dt; % Chirp time
s0=chirp(t0,f0,t0(end),f1); % Chirp
t=0:dt:T-dt; % Time
s=zeros(1,length(t)); % Signal
s(1:length(s0))=s0; % Add chirp
s=circshift(s',round(delay/dt))';s(:,end)=0; % Delayed signal
s0_pwr=mean(s0.^2); % Signal power
n_pwr=s0_pwr/(10^(snr/10)); % Noise power 
n=sqrt(n_pwr)*randn(size(s)); % WGN
s=s+n; % Add WGN
r=xcorr(s,s0)/sum(s0.^2); % Normalized CCF  
r=r(round(length(r)/2)-1:end); % Take the right half of the CCF
tau=linspace(0,length(r)-1,length(r))*dt; % The CCF argument (tau)

%Plots
figure
ax1=subplot(3,1,1); % First subplot
plot(t0,s0); % Plot the templete signal
xlabel('t'); % X-label
ylabel('s_{0}(t)'); % Y-label
legend('Signal (template)'); % Legend
grid on
ax2=subplot(3,1,2); % Second subplot
plot(t,s); % Plot the delayed signal
xlabel('t'); % X-label
ylabel('s(t)+n'); % Y-label
legend('Delayed signal + noise'); % Legend
grid on
ax3=subplot(3,1,3); % Third subplot
plot(tau,r); % PLot the CCF
xlabel('\tau'); % X-label
ylabel('r_{12}(\tau)'); % Y-label
legend('Cross-correlation function'); % Legend
grid on
linkaxes([ax2,ax3],'x'); % Same scale and position