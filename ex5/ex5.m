clear all
close all

R=1e3;
C=1e-6;
tau=R*C;

H=tf([1],[tau, 1]);             % Integrating
% H=tf([tau 0],[tau, 1]);       % Differentiating
w=linspace(10,1e4,1000);        % Frequencies
[mag,ph,w]=bode(H,w);           % Magnitude and phase
mag=squeeze(mag);               % Magnitude
ph=squeeze(ph);                 % Phase

figure
subplot(2,1,1)
plot(w,mag)                     % Magnitude response
xlabel('\omega [rad/s]')
ylabel('Magnitude')
grid on
subplot(2,1,2)
plot(w,ph)                      % Phase response
xlabel('\omega [rad/s]')
ylabel('Phase [deg]')
grid on

figure
subplot(2,1,1)
semilogx(w,20*log10(mag))       % Log magnitude response in dB
xlabel('\omega [rad/s]')
ylabel('Magnitude [db]')
grid on
subplot(2,1,2)
semilogx(w,ph)                  % Log phase response
xlabel('\omega [rad/s]')
ylabel('Phase [deg]')
grid on

figure
pzmap(H)                        % Pole-zero map

t=linspace(0,20*tau,1000);      % Time
h=impulse(H,t);                 % Impulse response
figure
plot(t,h)                       % Plot the impulse response
xlabel('t [s]')
ylabel('h(t)')
grid on
g=step(H,t);                    % Step response
figure
plot(t,g)                       % Plot step response
xlabel('t [s]')
ylabel('g(t)')
grid on
                                % Square
[x,t]=gensig('square',10*tau);
                                % Sine
%[x,t]=gensig('sine',2*pi*tau);

figure
lsim(H,x,t)                     % Simulate
grid on
