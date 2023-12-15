close all
clear all

snr=Inf; % Signal to noise ratio
M=2; % M
n=10; % Number of bits
fc=1000; % Carrier frequency
sr=fc; % Symbol rate
T=1/sr; % Symbol duration
ss=100; % Samples per symbol

m=randi([0,M-1],1,round(n/M)); % Random symbols
[y,t]=psk_mod(m,M,T,fc,ss); % PSK
n_pwr=(mean(y.^2))/(10^(snr/10)); % Noise power 
n=sqrt(n_pwr)*randn(size(y)); % WGN
y=y+n; % Add WGN
figure('Name',strcat(num2str(M),'-PSK Modulation'))
plot(t,y); % Plot signal+noise
xlabel('t [s]'); % X-label

[iq_,m_]=psk_demod(y,M,T,fc,ss); % Demodulation

figure('Name',strcat(num2str(M),'-PSK Constellation'))
scatter(real(iq_),imag(iq_),'o'); % Constellation diagram
xlabel('I'); % X-label
ylabel('Q'); % Y-label
xlim([-2 2]); % Limits
ylim([-2 2]); % Limits
grid on

m_bin=de2bi(m,log2(M)); % To bits (transmitted)
m_bin_=de2bi(m_,log2(M)); % To bits (received)
ber=sum(sum(m_bin~=m_bin_))/numel(m) % BER
