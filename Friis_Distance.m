close all;
clc;
clear all;

PLF = 1;
G_R = 1;
G_T = 1;

c = 3E8;


d = 1:1:1E4;

for f_c = 3000:1000:6000

    lambda = c/(f_c * 1E6);
    
    FSPL = ((4*pi*d).^2)/(lambda^2*PLF*G_T*G_R);
    
    figure(1)
    plot(d, 10*log10(FSPL));
    xlabel("d [m]");
    ylabel("FSPL [dB]");
    title("FSPL vs. distance")
    grid on
    hold on
end
hold off
legend("3GHz", "4GHz", "5GHz", "6GHz", "Location","southeast");

%Skal måske lave det sådan man kan se hvordan ændring i polarisering og
%gain spiller rolle her.

