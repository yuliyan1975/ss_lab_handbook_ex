close all
clear all

Fs=1000;                % Sampling frequency

b=[0.245 0.245];
a=[1 -0.509];           % a0 is always 1 for IIR

df_plots(b,a,Fs);       % Plot characteristics    