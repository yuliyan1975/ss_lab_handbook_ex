function [s]=saw(t,w0,K)
s=zeros(1,length(t));
                        % For each spectral component
for k=1:K
                        % From Fourier series
    s=s+(2/(k*pi))*cos(k*w0*t-pi/2);
end
end

