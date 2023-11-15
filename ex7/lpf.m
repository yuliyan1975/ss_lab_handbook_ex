function [b,a]=lpf(Fc,order,Fs)
                        % Butterworth
[b,a]=butter(order,Fc/(Fs/2));
end
