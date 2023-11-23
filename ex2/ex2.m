clear all
close all

Amp=1; % Amplitude
T0=0.1; % Period
bias=0; % Y-axis shift
ini_phase=0; % X-axis shift (initial phase)
duty_cycle=0.5; % Duty cycle (for rectangular pulses only)
K=10; % Number of harmonics 
dt=1.0e-5; % Time step (lower value - better accuracy)
f0=1/T0; % Frequency
w0=2*pi*f0; % Angular frequensy
t=0:dt:T0-dt; % Time

s=(Amp/T0)*t; % Sawtooth
% s=Amp*cos(w0*t); % Cosine
% s=Amp*double(t<=duty_cycle*T0); % Rectangular

s=s+bias; % Y-axis shift
s=circshift(s',-round(ini_phase*length(s)/(2*pi)))'; % X-axis shift

% Analysis
a=zeros(1,K); % Even components
b=zeros(1,K); % Odd components
A=zeros(1,K); % Amplitudes
phi=zeros(1,K); % Initial phases
a0=(1/T0)*trapz(s)*dt; % a0 coefficient (DC level)
phi0=0; % Always zero

for k=1:K
    a(k)=(2/T0)*trapz(s.*cos(k*w0*t)*dt); % Even component
    b(k)=(2/T0)*trapz(s.*sin(k*w0*t)*dt); % Odd component
    A(k)=sqrt(a(k).^2+b(k).^2); % Amplitude
    phi(k)=-atan2(b(k),a(k)); % Phase
end

% Synthesis
s_=zeros(1,length(t)); % Synthesyzed signal
s_=s_+a0; % DC livel
for k=1:K
    s_=s_+A(k)*cos(k*w0*t+phi(k)); % Add a harmonic
end

% Plots
figure('Name','Signal')
plot(linspace(0,3*T0,3*length(s)),[s s s],'b'); % Plot 3 periods
hold on
plot(linspace(0,3*T0,3*length(s_)),[s_ s_ s_],'r'); % Plot 3 periods
xlabel('t [s]'); % X-label                                                             
ylabel('s(t)'); % Y-label
legend('s(t)','s_{approx}(t)'); % Legend
grid on
f=(0:K)*f0; % Frequencies 
figure('Name','Spectrum')
ax1=subplot(2,1,1); % First subplot
stem(f,[a0 A],'b'); % Amplitude spectrum
xlabel('f [Hz]'); % X-label
ylabel(['a_{0}' ', ' 'A_{k}']); % Y-label
grid on
ax2=subplot(2,1,2); % Second subplot
stem(f,[phi0 phi],'b'); % Phase spectrum
xlabel('f [Hz]'); % X-label                                                             
ylabel('\phi_{k} [rad]'); % Y-label
grid on
linkaxes([ax1,ax2],'x'); % Same scale and position

