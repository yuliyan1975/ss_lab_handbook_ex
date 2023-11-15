function [w,S]=ft(s,t,w_max)
K=length(t);            % Number of harmonics
dt=t(2)-t(1);           % Time step
                        % Frequencies
w=linspace(-w_max,w_max,K);
S=complex(zeros(1,K));  % Spectral density
for k=1:K
                        % Fourier transform
    S(k)=trapz(s.*exp(sqrt(-1)*w(k)*t))*dt;
end
end

