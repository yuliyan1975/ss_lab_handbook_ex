clear all
close all

delay=0.05;             % Delay
snr=Inf;                % Signal-to-noise ratio
T=0.1;                  % Total dration
t0=0.01;                % Pulse duration
dt=1.0e-6;              % Time step
f0=1000;                % Lowest frequency
f1=10000;               % Highest frequency
t0=0:dt:t0-dt;          % Chirp time
                        % Chirp
s0=chirp(t0,f0,t0(end),f1);
t=0:dt:T-dt;            % Time
s=zeros(1,length(t));   % Signal
s(1:length(s0))=s0;     % Add chirp
                        % Delayed signal
s=circshift(s',round(delay/dt))';s(:,end)=0;
                        % Signal power
s0_pwr=10*log10(mean(s0.^2));
s=awgn(s,snr,s0_pwr);   % Add AWGN
                        % Normalized CCF
r=xcorr(s,s0)/sum(s0.^2);  
                        % Take the right half of the CCF
r=r(round(length(r)/2)-1:end);
                        % The CCF argument (tau) 
tau=linspace(0,length(r)-1,length(r))*dt;

                        %Plots
figure
ax1=subplot(3,1,1);
plot(t0,s0)
xlabel('t')
ylabel('s_{0}(t)')
legend('Signal (template)')
grid on
ax2=subplot(3,1,2);
plot(t,s)
xlabel('t')
ylabel('s(t)+n')
legend('Delayed signal + noise')
grid on
ax3=subplot(3,1,3);
plot(tau,r)
xlabel('\tau')
ylabel('r_{12}(\tau)')
legend('Cross-correlation function')
grid on
linkaxes([ax1,ax2,ax3],'x')