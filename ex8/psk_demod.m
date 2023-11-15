function [iq,m]=psk_demod(y,M,T,fc,ss)
N=length(y);            % Input length
dt=T/ss;                % Time step
t=linspace(0,N*dt-dt,N);% Time
I=y.*cos(2*pi*fc*t);
Q=y.*sin(2*pi*fc*t);
iq=[];
k=1;
while 1
    if k+ss-1>N
        break;
    end
    ii=(2/T)*trapz(I(k:k+ss-1))*dt;
    qq=(2/T)*trapz(Q(k:k+ss-1))*dt;
    iq=[iq,complex(ii,qq)];
    k=k+ss;
end
                        % Symbols
m=zeros(1,length(iq));
                        % Constellation
c=exp(sqrt(-1)*2*pi*[0:M-1]/M);
for k=1:length(iq)
                        % Euclidean distance
    d=abs(repmat(iq(k),1,M)-c);
                        % Minimal Euclidean distance
    [~,m(k)]=min(d);
end
m=m-1;                  % From 0 to M-1
end
