close all
clear all

Fs=360; % Sampling frecuency

load ecgsig.mat % Load ECG data

% Alternative
% load mit200

x=ecgsig'; % Assign and transpose
t=linspace(0,length(x)-1,length(x))/Fs; % Time vector
n=0.3*sin(2*pi*50*t); % 50Hz noise
xn=x+n; % Noisy ECG
w=[45 55]/(Fs/2); % Cut-off frequencies

b=fir1(128,w,'stop');a = 1; % FIR
% [b,a]=butter(8,w,'stop'); % IIR
df_plots(b,a,Fs); % Plot characteristics
y=filter(b,a,xn); % Filtration

% Plots
figure('Name','ECG filtration (FIR, IIR)');
ax1=subplot(2,1,1); % First subplot
plot(0:1:length(xn)-1,xn); % Plot the noisy signal
xlabel('n'); % X-label
ylabel('Amplitude') % Y-label
legend('Noisy ECG'); % Legend
grid on
ax2=subplot(2,1,2); % Second subplot
plot(0:1:length(xn)-1,x); % Plot the original
hold on
plot(0:1:length(y)-1,y,'r'); % Plot filtered
xlabel('n'); % X-label
ylabel('Amplitude') % Y-label
legend('Original ECG','Filtered ECG'); % Legend
grid on
linkaxes([ax1,ax2],'x') % Same scale and position