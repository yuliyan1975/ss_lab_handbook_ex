function []=spectr(x,Fs,name)
L=length(x); % Signal length
N=ceil(log2(L)); % Next power of 2
X=fft(x,2^N)/(L/2); % FFT
f=(Fs/2^N)*(0:2^(N-1)-1); % Frequency vector
figure('Name',['Amplitude spectrum: ',name]);  
plot(f,abs(X(1:2^(N-1)))); % Plot the amplitude spectrum
xlabel('f [Hz]'); % X-label
grid on
end
