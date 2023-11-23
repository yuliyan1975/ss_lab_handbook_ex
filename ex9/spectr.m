function []=spectr(x,Fs,name,lim)
N=length(x); % Signal length
X=2*abs(fftshift(fft(x)))/N; % Magnitude spectrum
df=Fs/N; % Frequency step
f=linspace(-Fs/2,Fs/2-df,N); % Frequencies
figure('Name',['Magnitude spectrum: ',name]);
stem(f(N/2:end),X(N/2:end)); % Spectrum plot
xlabel('f [Hz]'); % X-Label
if nargin>3
    xlim([lim(1) lim(2)]) % Limits
end
grid on
end
