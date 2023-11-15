close all
clear all

Ac=1;                   % Carrier amplitude
fc=10000;               % Carrier frequency
Am=1;                   % Amplitude of the modulating signal
fm=1000;                % Frequency of the modulating signal
Tm=1/fm;                % Modulating signal period

k=2*pi*3000;            % Coefficient of the FM                                                                           
wc=2*pi*fc;             % Angular frequency of the carrier
wm=2*pi*fm;             % Angular frequency of the modulating signal

t=linspace(0,4*Tm,8192);% Time for two periods (from 0 to 2T) with 8192 elements (power of 2)
dt=t(end)/length(t);    % Time step (sampling time)
Fs=1/dt;                % Sampling frequency

sc=Ac*cos(wc*t);        % Carrier

sm=Am*cos(wm*t);        % Harmonic modulating signal
                        % Rectangular modulating signal
%sm=Am*(2*pulstran(t,0:1/fm:0.1,"rectpuls",0.5/fm)-1);

psi=cumsum(wc+k*sm)*dt; % Phase angle. Cumulative sum instead integral. The result is not perfect
sfm=Ac*cos(psi);        % Frequency modulation

                        % Time domain Plots
figure('Name','FM');
subplot(3,1,1);         % First plot
plot(t,sm);             % Plot the modulating signal
xlabel('t [s]');        % X label
ylabel('s_{m}(t)');     % Y label
subplot(3,1,2);         % Second plot
plot(t,sc);             % Plot the carrier
xlabel('t [s]');        % X label
ylabel('s_{c}(t)');     % Y label
subplot(3,1,3);         % Third plot
plot(t,sfm);            % Plot the FM
xlabel('t [s]');        % X label
ylabel('s_{FM}(t)');    % Y label
hold on
plot(t,sm);             % Plot the modulating

                        % Plot the differentiated FM
figure('Name','Differentiated FM');
                        % Plot the diferentiated FM
plot(t(1:end-1),diff(sfm)/dt);
xlabel('t [s]');        % X label
ylabel('ds_{FM}(t)/dt');% Y label

                        % Spectrum
spectr(sfm,Fs,'FM',[0 50000]);


