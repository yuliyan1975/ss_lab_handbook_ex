clear all
close all

L=10e-3; % L
C=10e-6; % C

% R
R=100;
% R=63.246;
% R=44.715;
% R=10;

w0=1/sqrt(L*C); % Resonant frequency
zeta=(R/2)*sqrt(C/L); % Damping factor

H=tf([1],[L*C R*C 1]); % Transfer function
w=linspace(10,1e5,1000); % Frequencies
[mag,ph,w]=bode(H,w); % Frequency response
mag=squeeze(mag); % Magnitude response
ph=squeeze(ph); % Phase response

figure
subplot(2,1,1) % First subplot
semilogx(w,20*log10(mag)); % Log magnitude response in dB
xlabel('\omega [rad/s]'); % X-label
ylabel('Magnitude [db]'); % Y-label
grid on
subplot(2,1,2) % Second subplot
semilogx(w,ph); % Log phase response
xlabel('\omega [rad/s]') % X-label
ylabel('Phase [deg]') % Y-label
grid on

figure
pzmap(H);% Pole-zero plot

t=linspace(0,0.1,1000); % Time
h=impulse(H,t); % Impulse response
figure
plot(t,h); % Plot the impulse response
xlabel('t [s]') % X-label
ylabel('h(t)') % Y-label
grid on
g=step(H,t); % Step response
figure
plot(t,g); % Plot the step response
xlabel('t [s]'); % X-label
ylabel('g(t)'); % Y-label
grid on