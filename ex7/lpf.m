function [b,a]=lpf(Fc,order,Fs)
[b,a]=butter(order,Fc/(Fs/2)); % Butterworth
end
