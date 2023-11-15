close all
clear all

Ac=1;                   % Carrier amplitude
fc=5000;                % Carrier frequency
Am=1;                   % Amplitude of the modulating signal
fm=100;                 % Frequency of the modulating signal
Rm=Am*1.1;              % Reference amplitude
two_sided=0;            % One sided/two sided

wm=2*pi*fm;             % Angular frequency of the modulating signal
Tc=1/fc;                % Carrier period
                        % Time for 100 periods
t=linspace(0,100*Tc,8000);
dt=t(2)-t(1);           % Time step (sampling time)
Fs=1/dt;                % Sampling frequency

if two_sided==0         % If one sided
                        % Reference for 1 period
  r_=(2*Rm/Tc)*(0:dt:Tc)-Rm;
else
                        % Reference for 1/2 period
  r_=(2*Rm/(Tc/2))*(0:dt:Tc/2)-Rm;
  r_=[r_,fliplr(r_)];   % Make two slopes
end
                        % Repeat the reference many times to make it periodic
r=repmat(r_,1,ceil(length(t)/length(r_)));
r=r(1:length(t));       % Crop to make its length as same as the length of the time
 
                        % Modulation
sm=Am*cos(wm*t);        % Modulating signal
spwm=Ac*double(sm>r);   % PWM, A0 if sm > ref, 0 otherwise

                        % Demodulation
                        % Low pass filtering
sd=restoration_lpf(spwm,fc/2,Fs);

                        % Plots
figure('Name','PWM');   % Figure
ax1=subplot(2,1,1);     % First plot
plot(t,sm,'b');         % Plot the modulating signal
hold on;
plot(t,r,'r');          % Plot the reference
xlabel('t [s]');        % X label
                        % Y label
ylabel('s_{m}(t), r(t)');
                        % Legend
legend('s_{m}(t)','r(t)');
grid on
ax2=subplot(2,1,2);     % Second plot
plot(t,spwm,'b');       % Plot the PWM
ylim([-0.1 1.1*Ac]);    % Y limits
xlabel('t [s]');        % X label
ylabel('s_{PWM}(t)');   % Y label
grid on
linkaxes([ax1,ax2],'x') % Link axis
figure('Name','PWM Demodulated');
plot(t,sm,'b');         % Plot the modulating signal
hold on
plot(t,sd,'r');         % Plot the demodulated signal
xlabel('t [s]');        % X label
grid on
legend('Original','Demodulated');

                        % Spectrum
spectr(spwm,Fs,'PWM',[0 15000]);