function []=df_plots(b,a,Fs)
figure('Name','Frequency response');
                        % Frequency response (1000 points)
[H,f]=freqz(b,a,1000,Fs);
subplot(2,1,1);
plot(f,abs(H),'r');     % Magnitude response
xlabel('f [Hz]');
ylabel('|H(f)|');
legend('Magnitude response');
grid on
subplot(2,1,2)
                        % Phase response
plot(f,unwrap(angle(H)),'b');
xlabel('f [Hz]');
ylabel('\angle H(f) [rad]');
legend('Phase response');
grid on
figure('Name','Group delay');
                        % Group delay
delay=grpdelay(b,a,length(f));
plot(f,delay,'b');      % Plot the group delay
xlabel('f [Hz]');
ylabel('Group delay [samples]');
grid on
                        % Pole-zero plot
figure('Name', 'Pole-zero plot');
zplane(b,a);            % Z-plane with poles and zeros
p=roots(a);             % Poles
if any(abs(p)>=1)       % If any pole outside of the unit circle
    text(0.5,0.5,'Stable: no','color','red');
else
    xlim([-1.2 1.2]);
    ylim([-1.2 1.2]);
    text(0.5,0.5,'Stable: yes');
end
                        % Impulse and step response
figure('Name','Impulse and step response');
subplot(2,1,1);
[h,n]=impz(b,a);        % Impulse response
stem(n,h,'r');          % Plot the impulse response
xlabel('n');
ylabel('h[n]');
legend('Impluse response');
grid on
subplot(2,1,2);
g=cumsum(h);            % Step response
stem(n,g,'b');          % Plot the step response
xlabel('n');
ylabel('g[n]');
legend('Step response');
grid on
end