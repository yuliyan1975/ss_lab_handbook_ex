function []=df_plots(b,a,Fs)
% Frequency response
figure('Name','Frequency response');
[H,f]=freqz(b,a,1000,Fs); % Frequency response (1000 points)
subplot(2,1,1); % First subplot
plot(f,abs(H),'r'); % Magnitude response
xlabel('f [Hz]'); % X-label
ylabel('|H(f)|'); % Y-label
legend('Magnitude response');
grid on
subplot(2,1,2) % Second subplot
plot(f,unwrap(angle(H)),'b'); % Phase response
xlabel('f [Hz]'); % X-label
ylabel('\angle H(f) [rad]'); % Y-label
legend('Phase response'); % Legend
grid on
% Group delay response
figure('Name','Group delay');
delay=grpdelay(b,a,length(f)); % Group delay
plot(f,delay,'b'); % Plot the group delay
xlabel('f [Hz]'); % X-label
ylabel('Group delay [samples]'); % Y-label
grid on
% Pole-zero plot
figure('Name', 'Pole-zero plot');
zplane(b,a); % Z-plane with poles and zeros
p=roots(a); % Poles
if any(abs(p)>=1) % If any pole is outside of the unit circle
    text(0.5,0.5,'Stable: no','color','red');
else
    xlim([-1.2 1.2]);
    ylim([-1.2 1.2]);
    text(0.5,0.5,'Stable: yes');
end
% Impulse and step response
figure('Name','Impulse and step response');
subplot(2,1,1); % First subplot
[h,n]=impz(b,a); % Impulse response
stem(n,h,'r'); % Plot the impulse response
xlabel('n'); % X-label
ylabel('h[n]'); % Y-label
legend('Impluse response'); % Legend
grid on
subplot(2,1,2); % Second subplot
g=cumsum(h); % Step response
stem(n,g,'b'); % Plot the step response
xlabel('n'); % X-label
ylabel('g[n]'); % Y-label
legend('Step response'); % Legend
grid on
end