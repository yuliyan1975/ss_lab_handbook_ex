function [y,t]=psk_mod(m,M,T,fc,ss)
N=length(m);            % Message length
                        % IQ
iq=exp(sqrt(-1)*2*pi*m/M);
                        % Repeat
iq=cell2mat(arrayfun(@(a,r)repmat(a,1,r),iq,ss*ones(1,length(iq)),'uni',0));
dt=T/ss;                % Time step
                        % Time
t=linspace(0,N*T-dt,length(iq));
                        % Output
y=real(iq).*cos(2*pi*fc*t)+imag(iq).*sin(2*pi*fc*t);
end

