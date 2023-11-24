close all;
clc;
clear all;

PLF = 1;
G_R = 1;
G_T = 1;

c = 3E8;
f_c = input("Insert the used frequency in MHz\n");
lambda = c/(f_c * 1E6);

d = 1:1:1E4;

FSPL = ((4*pi*d).^2)/(lambda^2*PLF*G_T*G_R);

figure(1)
plot(d, 10*log10(FSPL));
xlabel("d [m]");
ylabel("FSPL [dB]");
title("FSPL vs. distance")
grid on

%Skal måske lave det sådan man kan se hvordan ændring i polarisering og
%gain spiller rolle her.
%kan også være der skal tilføjes et forloop for at køre med flere
%frekvenser.

