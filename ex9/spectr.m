function []=spectr(x,Fs,name,lim)
N=length(x);            % Signal length
                        % Magnitude spectrum
X=2*abs(fftshift(fft(x)))/N;
df=Fs/N;                % Frequency step
                        % Frequencies
f=linspace(-Fs/2,Fs/2-df,N);
figure('Name',['Magnitude spectrum: ',name]);
                        % Spectrum plot
stem(f(N/2:end),X(N/2:end));
xlabel('f [Hz]');       % X-Label
if nargin>3
                        % Limits
    xlim([lim(1) lim(2)])
end
grid on
end
