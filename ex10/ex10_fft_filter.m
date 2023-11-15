close all
clear all

Fs=360;                 % Sampling rate
fc1=45;                 % Lower cut-off frequency
fc2=55;                 % Higher cut-off frequency
                        % Load signal
load ecgsig.mat
% Alternative
% load mit200

x=ecgsig';              % Assign and transpose
dt=1/Fs;                % Sampling time
                        % Time vector
t=linspace(0,length(x)-1,length(x))/Fs;
n=0.3*sin(2*pi*50*t);   % 50-Hz noise
xn=x+n;                 % Noisy ECG

X=fftshift(fft(xn));    % Spectrum
                        % Frequency vector
f=linspace(-Fs/2,Fs/2,length(X));
df=f(2)-f(1);           % Frequency step
Y=X;                    % Assign
                        % Find the indices of the undesired spectral components
id=(abs(f)>=fc1&abs(f)<=fc2);
Y(id)=complex(0);       % Clear the undesired spectral components
                        % Restore from spectrum
y=real(ifft(ifftshift(Y)));
figure('Name','Noisy ECG Spectrum');
ax1=subplot(2,1,1);
plot(f,abs(X));         % Magnitude spectrum plot
xlabel('f [Hz]');
ylabel('Magnitude')
grid on
ax2=subplot(2,1,2);
plot(f,angle(X));       % Phase spectrum plot
xlabel('f [Hz]');
ylabel('Phase');
grid on
linkaxes([ax1,ax2],'x');

figure('Name','Filtered ECG Spectrum');
ax1=subplot(2,1,1);
plot(f,abs(Y));         % Magnitude spectrum plot
xlabel('f [Hz]');
ylabel('Magnitude')
grid on
ax2=subplot(2,1,2);
plot(f,angle(Y));       % Phase spectrum plot
xlabel('f [Hz]');
ylabel('Phase');
grid on
linkaxes([ax1,ax2],'x');

                        % Plots
figure('Name','ECG filtration (FFT->Modify->IFFT)');
ax1=subplot(2,1,1);
                        % Plot the noisy signal
plot(0:1:length(xn)-1,xn);
xlabel('n');
ylabel('Amplitude');
legend('Noisy ECG');
grid on
ax2=subplot(2,1,2);
                        % Plot the original
plot(0:1:length(xn)-1,x);
hold on
                        % Plot filtered
plot(0:1:length(y)-1,y,'r');
xlabel('n');
ylabel('Amplitude');
legend('Original ECG','Filtered ECG');
grid on
linkaxes([ax1,ax2],'x');
