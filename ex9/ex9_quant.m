close all
clear all

n=4;                    % Quantization bits
A=1;                    % Amplitude
T0=1;                   % Period

N=2^n;                  % Quantization levels
dt=1e-3;                % Time step

t=0:dt:T0-dt;           % Time

s=A*sin((2*pi/T0)*t);   % Signal

                        % Quantization
levels=linspace(-A,A,N);% Levels
                        % Quantized signal
sq=interp1(levels,levels,s,'nearest');
e=s-sq;                 % Quantization error (noise)

                        % Plots
figure('Name','Quantiaztion');
ax1=subplot(2,1,1);     % Two plots. Use the first plot
plot(t,s,'b');          % Plot the signal
hold on
plot(t,sq,'r');         % Plot the quantized signal
title('Signal quantization');
xlabel('t [s]');        % X-axis label
ylabel('Amplitude');    % Y-axis label
                        % Legend
legend('Original','Quantized');
grid on;
ax2=subplot(2,1,2);     % Two plots. Use the second plot
plot(t,e,'b');          % Plot the quantization noise
                        % Title
title('Quantization noise');
xlabel('t [s]');        % X-axis label
ylabel('Amplitude');    % Y-axis label
grid on;
linkaxes([ax1,ax2],'x') % Link axis
figure('Name','Quantiaztion noise distribution');
hist(e);                % Histogram

                        % SQNR calculation
Ps=var(s);              % Signal power
Pn=var(e);              % Quantization noise power
SQNR=10*log10(Ps/Pn);   % Signal to quantization noise ratio
                        % Print
fprintf('SQNR=%.1f dB\r\n',SQNR);
