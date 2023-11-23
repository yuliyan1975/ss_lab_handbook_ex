function [y]=restoration_lpf(x,fc,fs)
X=fftshift(fft(x)); % FFT
f=linspace(-fs/2,fs/2,length(X)); % Frequencies
Y=X; % Assign
id=(abs(f)>=fc); % Find the indices of the spectral components to be attenuated
Y(id)=complex(0); % Clear the spectral components
y=real(ifft(ifftshift(Y))); % Inverse FFT
end

