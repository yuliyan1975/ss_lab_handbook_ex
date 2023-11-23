close all
clear all

n=4; % Quantization bits
A=1; % Amplitude
T0=1; % Period

N=2^n; % Quantization levels
dt=1e-3; % Time step

t=0:dt:T0-dt; % Time

s=A*sin((2*pi/T0)*t); % Signal

% Quantization
levels=linspace(-A,A,N); % Levels
sq=interp1(levels,levels,s,'nearest'); % Quantized signal
e=s-sq; % Quantization error (noise)

% Plots
figure('Name','Quantiaztion');
ax1=subplot(2,1,1); % First subplot
plot(t,s,'b'); % Plot the signal
hold on
plot(t,sq,'r'); % Plot the quantized version
title('Signal quantization');
xlabel('t [s]'); % X-axis label
ylabel('Amplitude'); % Y-axis label
legend('Original','Quantized'); % Legend
grid on;
ax2=subplot(2,1,2); % Second subplot
plot(t,e,'b'); % Plot the quantization noise
title('Quantization noise'); % Title
xlabel('t [s]'); % X-label
ylabel('Amplitude'); % Y-label
grid on;
linkaxes([ax1,ax2],'x') % Same scale and position
figure('Name','Quantiaztion noise distribution');
hist(e); % Histogram

% SQNR calculation
Ps=var(s); % Signal power
Pn=var(e); % Quantization noise power
SQNR=10*log10(Ps/Pn); % Signal to quantization noise ratio
fprintf('SQNR=%.1f dB\r\n',SQNR); % Print the SQNR
