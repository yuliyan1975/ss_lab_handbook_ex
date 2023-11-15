clear all
close all
L=10e-3;                % L
C=10e-6;                % C
                        % R
%R=100;
R=63.246;
%R=44.715;
%R=10;

w0=1/sqrt(L*C);         % Resonant frequency
zeta=(R/2)*sqrt(C/L);   % Damping factor

H=tf([1],[L*C R*C 1]);  % Transfer function
w=linspace(10,1e5,1000);% Frequencies
[mag,ph,w]=bode(H,w);   % Frequency response
mag=squeeze(mag);       % Magnitude response
ph=squeeze(ph);         % Phase response

figure
subplot(2,1,1)
                        % Log magnitude response in dB
semilogx(w,20*log10(mag))
xlabel('\omega [rad/s]')
ylabel('Magnitude [db]')
grid on
subplot(2,1,2)
semilogx(w,ph)          % Log phase response
xlabel('\omega [rad/s]')
ylabel('Phase [deg]')
grid on

figure
pzmap(H)                % Pole-zero plot

                        % Time
t=linspace(0,0.1,1000);
%h=impulse(H,t);        % Impulse response
%figure
%plot(t,h)              % Plot impulse response
%xlabel('t [s]')
%ylabel('h(t)')
grid on
g=step(H,t);            % Step response
figure
plot(t,g)
xlabel('t [s]')         % Plot step response
ylabel('g(t)')
grid on