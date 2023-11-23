function [w,S]=ft(s,t,w_max)
K=length(t); % Number of harmonics
dt=t(2)-t(1); % Time step
w=linspace(-w_max,w_max,K); % Frequencies
S=complex(zeros(1,K)); % Spectral density
for k=1:K
    S(k)=trapz(s.*exp(sqrt(-1)*w(k)*t))*dt; % Fourier transform
end
end

