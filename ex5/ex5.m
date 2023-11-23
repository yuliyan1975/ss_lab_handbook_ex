clear all
close all

R=1e3; % Resistor
C=1e-6; % Capacitor
tau=R*C; % Time constant

H=tf([1],[tau, 1]); % Integrating
% H=tf([tau 0],[tau, 1]); % Differentiating
w=linspace(10,1e4,1000); % Frequencies
[mag,ph,w]=bode(H,w); % Magnitude and phase
mag=squeeze(mag); % Magnitude
ph=squeeze(ph); % Phase

figure
subplot(2,1,1) % First subplot
plot(w,mag); % Magnitude response
xlabel('\omega [rad/s]'); % X-label
ylabel('Magnitude'); % Y-label
grid on
subplot(2,1,2) % Second subplot
plot(w,ph); % Phase response
xlabel('\omega [rad/s]'); % X-label
ylabel('Phase [deg]'); % Y-label
grid on

figure
subplot(2,1,1) % First subplot
semilogx(w,20*log10(mag)); % Log magnitude response in dB
xlabel('\omega [rad/s]'); % X-label
ylabel('Magnitude [db]'); % Y-label
grid on
subplot(2,1,2) % Second subplot
semilogx(w,ph); % Log phase response
xlabel('\omega [rad/s]'); % X-label
ylabel('Phase [deg]'); % Y-label
grid on

figure
pzmap(H) % Pole-zero map

t=linspace(0,20*tau,1000); % Time
h=impulse(H,t); % Impulse response
figure
plot(t,h); % Plot the impulse response
xlabel('t [s]'); % X-label 
ylabel('h(t)'); % Y-label
grid on
g=step(H,t); % Step response
figure
plot(t,g); % Plot the step response
xlabel('t [s]'); % X-label
ylabel('g(t)'); % Y-label
grid on

[x,t]=gensig('square',10*tau); % Square
% [x,t]=gensig('sine',2*pi*tau); % Sine

figure
lsim(H,x,t); % Simulate
grid on
