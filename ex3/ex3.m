clear all
close all

Amp=1;                  % Amplitude
T=4;                    % Duration
tp=1;                   % Pulse duration
tau=0;                  % Delay
w0=15;                  % Angular frequency 
N=500;                  % Number of samples
cy=1;                   % Number of cycles
t=linspace(-T,T,N);     % Time
dt=t(2)-t(1);           % Time step

% Rectangular pulse
s=Amp*double(t<tp/2+tau & t>-tp/2+tau);

% Cosine with finite duration
% s=Amp*double(t<tp/2+tau & t>-tp/2+tau);s=s.*cos(w0*t);

% Sinc
% s=2*Amp*sin(w0*t)./(2*pi*t);

s=repmat(s,1,cy);       % Repeat
                        % Time
t=linspace(-cy*T,cy*T,length(s));
[w,S]=ft(s,t,8*pi*tp);  % Spectrum
dw=w(2)-w(1);           % Frequency step

figure('Name','Signal');
plot(t,s,'b');          % Plot signal
xlabel('t [s]');        % X-label                                                             
ylabel('s(t)');         % Y-label
grid on                 % Grid

figure('Name','Spectral density (Magnitude, Phase)')
ax1=subplot(2,1,1);     % First subplot
plot(w,abs(S),'b');     % Amplitude spectrum
                        % X-label
xlabel('\omega [rad/s]');       
ylabel('|S(j\omega)|')  % Y-label
grid on                 % Grid
ax2=subplot(2,1,2);     % Second subplot
                        % Phase spectrum
plot(w,atan2(imag(S),real(S)),'b');
                        % X-label
xlabel('\omega [rad/s]');
                        % Y-label
ylabel('arg[S(j\omega)] [rad]');
grid on                 % Grid
linkaxes([ax1,ax2],'x')

figure('Name','Spectral density (Re, Im)')
plot(w,real(S),'b');    % Real part
hold on
plot(w,imag(S),'r');    % Imaginary part
                        % X-label
xlabel('\omega [rad/s]')                                                             
ylabel('S(j\omega)')    % Y-label
legend('Re[S(j\omega)]','Im[S(j\omega)]')
grid on                 % Grid

[t,s]=ift(S,w,t(end));  % Synthesis
figure('Name','Restored signal')
subplot(1,1,1);         % Subplot
plot(t,s,'b');          % Signal
xlabel('t [s]');        % X-label                                                             
ylabel("s'(t)");        % Y-label
grid on                 % Grid
