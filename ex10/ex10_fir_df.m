close all
clear all

Fs=1000;                % Sampling frequency
a=1;                    % Always 1 for FIR

N=2;                    % Order
b=(1/N)*ones(1,N);
%b=[1/2 -1/2];
%b=[1/2 0 -1/2];
%b=[1/2 0 1/2];

df_plots(b,a,Fs);       % Plot the characteristics               