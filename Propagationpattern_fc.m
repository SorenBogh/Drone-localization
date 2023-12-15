close all;
clear all;
clf;
clc;
step = 3; % 3 deg
freq_N = 31;
probe_N = 121; % el: -180:3:180 deg
rotate_N = 60; % 0:3:177 deg
indata = readtable('PulseOne_Pattern.txt','VariableNamingRule', 'preserve');
Az = (table2array(indata(:,1)));
El = (table2array(indata(:,2)));
freq = (table2array(indata(:,3)));
Ev = table2array(indata(:,4)) +1j*(table2array(indata(:,5)));
Eh = table2array(indata(:,6)) +1j*(table2array(indata(:,7)));

Az_m = reshape(Az, [freq_N, probe_N, rotate_N]);
ang_r =  rad2deg(squeeze(Az_m(1,1,:)));
El_m = reshape(El, [freq_N, probe_N, rotate_N]);
ang_p = rad2deg(squeeze(El_m(1,:,1)));
Ev = reshape(Ev,[freq_N, probe_N, rotate_N]);
Eh = reshape(Eh,[freq_N, probe_N, rotate_N]);
clear indata Az El Az_m El_m;

%---reshape the data---
f_id  = 1;
el = -90:3:90;
az = 0:3:360-3;
el_N = length(el);
az_N = length(az);
Ev_1 = zeros(el_N, az_N);% for a single frequency point
Eh_1 = zeros(el_N, az_N);
idx_v1 = 1:el_N;
idx_v2 = probe_N:-1:el_N;

pi_id = floor(az_N/2);
for i = 1:rotate_N
    Ev_1(:,i) = squeeze(Ev(f_id,idx_v1,i));
    Ev_1(:,i+pi_id) = squeeze(Ev(f_id,idx_v2,i));

    Eh_1(:,i) = squeeze(Eh(f_id,idx_v1,i));
    Eh_1(:,i+pi_id) = squeeze(Eh(f_id,idx_v2,i));
end

Etotal = Ev_1.*conj(Ev_1) + Eh_1.*conj(Eh_1);
max_db = 10*log10(max(Etotal(:)));
figure;
subplot(3,1,1);
surf(az,el,20*log10(abs(Ev_1)));
shading flat;
xlabel('Az [deg]');
ylabel('El [deg]');
clim([max_db-30, max_db]);
colorbar;
title('Ev');
axis tight;
view(0,90);
subplot(3,1,2);
surf(az,el,20*log10(abs(Eh_1)));
shading flat;
xlabel('Az [deg]');
ylabel('El [deg]');
clim([max_db-30, max_db]);
colorbar;
title('Eh');
axis tight;
view(0,90);
subplot(3,1,3);
surf(az,el,10*log10(Etotal));
shading flat;
xlabel('Az [deg]');
ylabel('El [deg]');
clim([max_db-30, max_db]);
colorbar;
title('E total');
axis tight;
view(0,90);



figure
q = reshape(Ev_1,120,61);
q = Etotal;


patternCustom(20*log10(abs(q(1:60,1:120))),ang_p(1,1:120),ang_r)


 %q = reshape(Ev_1,120,61);
 %hplot = patternCustom(20*log10(abs(q)),el,az, ...
             %"Slice","theta","SliceValue",el(1,1));


% polarplot(10*log10(abs(Ev_1)),az)
% q = reshape(Etotal,61,120);
% patternCustom(10*log10(abs(q)),az,el)
% title('PulseOne Radiation Pattern')



