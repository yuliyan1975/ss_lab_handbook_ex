close all
clear all

Fs=360; %Sampling frecuency


load ecgsig.mat %Load ECG data

%Alternative
%load mit200

x=ecgsig'; %Assign and transpose
t=linspace(0,length(x)-1,length(x))/Fs; %Time vector
n=0.3*sin(2*pi*50*t); %50Hz noise
xn=x+n; %Noisy ECG
w=[45 55]/(Fs/2); %Cut-off frequencies

a=fir1(128,w,'stop');b = 1; %FIR
%[a,b]=butter(8,w,'stop'); %IIR

df_plots(a,b,Fs); %Plot characteristics 

y=filter(a,b,xn); %Filtration

%Plots
figure('Name','ECG filtration (FIR, IIR)');
ax1=subplot(2,1,1);
plot(0:1:length(xn)-1,xn); %Plot the noisy
xlabel('n'); %Label
ylabel('Amplitude') %Label
legend('Noisy ECG'); %Legend
grid on %Grid
ax2=subplot(2,1,2);
plot(0:1:length(xn)-1,x); %Plot the original
hold on
plot(0:1:length(y)-1,y,'r'); %Plot filtered
xlabel('n'); %Label
ylabel('Amplitude') %Label
legend('Original ECG','Filtered ECG'); %Legend
grid on %Grid
linkaxes([ax1,ax2],'x') %Link axis