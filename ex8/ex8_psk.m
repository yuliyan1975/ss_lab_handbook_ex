close all
clear all

M=2;                    % M
n=10;                   % Number of bits
fc=1000;                % Carrier frequency
sr=fc;                  % Symbol rate
T=1/sr;                 % Symbol duration
ss=100;                 % Samples per symbol

                        % Random symbols
m=randi([0,M-1],1,round(n/M));
                        % PSK
[y,t]=psk_mod(m,M,T,fc,ss);

                        % Noise
y=awgn(y,inf,'measured');
figure('Name',strcat(num2str(M),'-PSK Modulation'))
plot(t,y)               % Plot signal+noise
xlabel('t [s]')

                        % Demodulation
[iq_,m_]=psk_demod(y,M,T,fc,ss);

figure('Name',strcat(num2str(M),'-PSK Constellation'))
                        % Constellation diagram
scatter(real(iq_),imag(iq_),'o');
xlabel('I')
ylabel('Q')
xlim([-2 2])
ylim([-2 2])
grid on

m_bin=de2bi(m,log2(M)); % To bits
                        % To bits
m_bin_=de2bi(m_,log2(M));
                        % BER
ber=sum(sum(m_bin~=m_bin_))/numel(m)
