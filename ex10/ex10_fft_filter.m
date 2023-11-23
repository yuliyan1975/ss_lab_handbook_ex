close all
clear all

Fs=360; % Sampling rate
fc1=45; % Lower cut-off frequency
fc2=55; % Higher cut-off frequency

load ecgsig.mat % Load signal
% Alternative
% load mit200

x=ecgsig'; % Assign and transpose
dt=1/Fs; % Sampling time

t=linspace(0,length(x)-1,length(x))/Fs; % Time vector
n=0.3*sin(2*pi*50*t); % 50-Hz noise
xn=x+n; % Noisy ECG

X=fftshift(fft(xn)); % Spectrum   
f=linspace(-Fs/2,Fs/2,length(X)); % Frequency vector
df=f(2)-f(1); % Frequency step
Y=X; % Assign                        
id=(abs(f)>=fc1&abs(f)<=fc2); % Find the indices of the undesired spectral components
Y(id)=complex(0); % Clear the undesired spectral components
y=real(ifft(ifftshift(Y))); % Restore from spectrum

% Noisy spectrum
figure('Name','Noisy ECG Spectrum');
ax1=subplot(2,1,1); % First subplot
plot(f,abs(X)); % Magnitude spectrum plot
xlabel('f [Hz]'); % X-label
ylabel('Magnitude'); % Y-label
grid on
ax2=subplot(2,1,2); % Second subplot
plot(f,angle(X)); % Phase spectrum plot
xlabel('f [Hz]'); % X-label
ylabel('Phase'); % Y-label
grid on
linkaxes([ax1,ax2],'x'); % Same scale and position

% Filtered spectrum
figure('Name','Filtered ECG Spectrum');
ax1=subplot(2,1,1); % First subplot
plot(f,abs(Y)); % Magnitude spectrum plot
xlabel('f [Hz]'); % X-label
ylabel('Magnitude'); % Y-label
grid on
ax2=subplot(2,1,2); % Second subplot
plot(f,angle(Y)); % Phase spectrum plot
xlabel('f [Hz]'); % X-label
ylabel('Phase'); % Y-label
grid on
linkaxes([ax1,ax2],'x'); % Same scale and position

% Filtration
figure('Name','ECG filtration (FFT->Modify->IFFT)');
ax1=subplot(2,1,1); % First subplot
plot(0:1:length(xn)-1,xn); % Plot the noisy signal
xlabel('n'); % X-label
ylabel('Amplitude'); % Y-label
legend('Noisy ECG'); % Legend
grid on
ax2=subplot(2,1,2); % Second subplot
plot(0:1:length(xn)-1,x); % Plot the original
hold on
plot(0:1:length(y)-1,y,'r'); % Plot filtered
xlabel('n'); % X-label
ylabel('Amplitude'); % Y-label
legend('Original ECG','Filtered ECG'); % Legend
grid on
linkaxes([ax1,ax2],'x'); % Same scale and position