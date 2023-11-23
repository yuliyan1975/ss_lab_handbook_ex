function [t,s]=ift(S,w,t_max)
N=length(w); % Number of samples
dw=w(2)-w(1); % Frequency step
t=linspace(-t_max,t_max,N); % Time
s=zeros(1,N); % Signal
for n=1:N
    s(n)=real((1/(2*pi))*(trapz(S.*exp(sqrt(-1)*w*t(n)))*dw)); % Inverse Fourier transform
end
end