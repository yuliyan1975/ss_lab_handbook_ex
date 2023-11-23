function [iq,m]=psk_demod(y,M,T,fc,ss)
N=length(y); % Input length
dt=T/ss; % Time step
t=linspace(0,N*dt-dt,N);% Time
I=y.*cos(2*pi*fc*t); % I
Q=y.*sin(2*pi*fc*t); % Q
iq=[];
k=1;
while 1
    if k+ss-1>N
        break; % Beak in case of the last symbol
    end
    ii=(2/T)*trapz(I(k:k+ss-1))*dt; % Dot product
    qq=(2/T)*trapz(Q(k:k+ss-1))*dt; % Dot product
    iq=[iq,complex(ii,qq)]; % To complex
    k=k+ss; % Next
end
m=zeros(1,length(iq)); % Symbols
c=exp(sqrt(-1)*2*pi*[0:M-1]/M); % Constellation
for k=1:length(iq)
    d=abs(repmat(iq(k),1,M)-c); % Euclidean distance
    [~,m(k)]=min(d); % Minimal Euclidean distance
end
m=m-1; % From 0 to M-1
end
