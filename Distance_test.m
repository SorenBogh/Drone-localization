% This MatLAB code is made to process and plot data from tests to locate an Rx
% antenna.

clear all;

%% Data handeling section (Import and sort)
%Here we imort all the data readings and seperate them into time and
%frequency matrices.
clc;
close all;
%importing data:

Rx1Files = dir("AntenneGR514V2\Rx1\");
Rx2Files = dir("AntenneGR514V2\Rx2\");
Rx3Files = dir("AntenneGR514V2\Rx3\");

%data for rx1 setup
n1 = length(Rx1Files);
dataFrqRx1 = cell(2, n1/2);
dataTimeRx1 = cell(2, n1/2);
n1frq = 0; %position of freq entry
n1Time = 0; %Time pos

for i = 1:length(Rx1Files)

    if contains(Rx1Files(i).name, "frq") == 1
        n1frq = n1frq + 1;
        sprintf("Freq Data saved: ..%c%s", char(92), Rx1Files(i).name)
        dataFrqRx1{1, n1frq} = Rx1Files(i).name;
        dataFrqRx1{2, n1frq} = readmatrix(sprintf("%s%c%s", Rx1Files(i).folder, char(92), Rx1Files(i).name));

    elseif contains(Rx1Files(i).name, "time") == 1
        n1Time = n1Time + 1;
        sprintf("Time Data saved: ..%c%s", char(92), Rx1Files(i).name)
        dataTimeRx1{1, n1Time} = Rx1Files(i).name;
        dataTimeRx1{2, n1Time} = readmatrix(sprintf("%s%c%s", Rx1Files(i).folder, char(92), Rx1Files(i).name));

    end

end
clear i n1 n1frq n1Time Rx1Files

%data for rx2 setup
n2 = ceil(length(Rx2Files)/2);
dataFrqRx2 = cell(2, n2);
dataTimeRx2 = cell(2, n2);
n2frq = 0; %position of freq entry
n2Time = 0; %Time pos

for i = 1:length(Rx2Files)

    if contains(Rx2Files(i).name, "frq") == 1
        n2frq = n2frq + 1;
        sprintf("Freq Data saved: ..%c%s", char(92), Rx2Files(i).name)
        dataFrqRx2{1, n2frq} = Rx2Files(i).name;
        dataFrqRx2{2, n2frq} = readmatrix(sprintf("%s%c%s", Rx2Files(i).folder, char(92), Rx2Files(i).name));

    elseif contains(Rx2Files(i).name, "time") == 1
        n2Time = n2Time + 1;
        sprintf("Time Data saved: ..%c%s", char(92), Rx2Files(i).name)
        dataTimeRx2{1, n2Time} = Rx2Files(i).name;
        dataTimeRx2{2, n2Time} = readmatrix(sprintf("%s%c%s", Rx2Files(i).folder, char(92), Rx2Files(i).name));

    end

end
clear i n2 n2frq n2Time Rx2Files

%data for rx3 setup
n3 = ceil(length(Rx3Files)/2);
dataFrqRx3 = cell(2, n3);
dataTimeRx3 = cell(2, n3);
n3frq = 0; %position of freq entry
n3Time = 0; %Time pos

for i = 1:length(Rx3Files)

    if contains(Rx3Files(i).name, "frq") == 1
        n3frq = n3frq + 1;
        sprintf("Freq Data saved: ..%c%s", char(92), Rx3Files(i).name)
        dataFrqRx3{1, n3frq} = Rx3Files(i).name;
        dataFrqRx3{2, n3frq} = readmatrix(sprintf("%s%c%s", Rx3Files(i).folder, char(92), Rx3Files(i).name));

    elseif contains(Rx3Files(i).name, "time") == 1
        n3Time = n3Time + 1;
        sprintf("Time Data saved: ..%c%s", char(92), Rx3Files(i).name)
        dataTimeRx3{1, n3Time} = Rx3Files(i).name;
        dataTimeRx3{2, n3Time} = readmatrix(sprintf("%s%c%s", Rx3Files(i).folder, char(92), Rx3Files(i).name));

    end

end
clear i n3 n3frq n3Time Rx3Files

%% User interface
%Here the user will have to choose which position will be calculated in
%this run.
clc
disp("The following degrees can be chosen:");
disp("15°, 60°, 105°, 150°, 195°, 240°, 285°, 330°");
deg = input("Choose drone pos in degrees:\n"); %input puts the code on hold.

%Add input to choose height
disp("\nNow we have to choose a height for the measurement, following heights are available:");
disp("z = 0, 0.5, 1, 1.5");
z_in = 0; %input("Choose the z-value:\n");

%% Calculating distances and generating plots
%Self note:
%Here i have to rename files, as there is inconsistancy in naming. Code is
%made to have a . between degrees and 
clc
close all


%save the functions that fit UI
Data_Pro = {};
disp("-----------RX1------------");
Data_Pro = horzcat(Data_Pro, dataFind(dataTimeRx1, deg, z_in));
disp("-----------RX2------------");
Data_Pro = horzcat(Data_Pro, dataFind(dataTimeRx2, deg, z_in));
disp("-----------RX3------------");
Data_Pro = horzcat(Data_Pro, dataFind(dataTimeRx3, deg, z_in));

%clear dataTimeRx1 dataTimeRx2 dataTimeRx3 % This is just for simplifing
%when done 
TH = -100; %setting treshhold

fig = figure('Name', 'Test Results','Units','normalized' , 'Position', [0.5 0.25 0.35 0.6]);
subplot(3,1,1);
plot(Data_Pro{2, 1}(:, 1), Data_Pro{2, 1}(:, 2));
ylim([-150, -30]);
title('Tx1');
hold on;
plot(Data_Pro{3, 1}(1),Data_Pro{3, 1}(2) , 'x', 'MarkerSize', 10);
plot_TH(Data_Pro{2, 1}(1, 1), Data_Pro{2, 1}(end-1, 1), TH);

subplot(3,1,2);
plot(Data_Pro{2, 2}(:, 1), Data_Pro{2, 2}(:, 2));
title('Tx2');
ylim([-150, -30]);
ylabel('RSS [dB]', 'FontSize',13)
hold on;
plot(Data_Pro{3, 2}(1),Data_Pro{3, 2}(2) , 'x', 'MarkerSize', 10);
plot_TH(Data_Pro{2, 2}(1, 1), Data_Pro{2, 2}(end-1, 1), TH);

subplot(3,1,3);
plot(Data_Pro{2, 3}(:, 1), Data_Pro{2, 3}(:, 2));
title('Tx3');
ylim([-150, -30]);
hold on;
plot(Data_Pro{3, 3}(1),Data_Pro{3, 3}(2) , 'x', 'MarkerSize', 10);
plot_TH(Data_Pro{2, 3}(1, 1), Data_Pro{2, 3}(end-1, 1), TH);
xlabel('Time [s]', 'FontSize',13)

sgtitle('RSS in time domain', 'Fontsize', 14)

% Finding the distance using TH TOA method. Fills the first row of d.
d(1, 1) = TH_dist(Data_Pro{2, 1}, TH);
d(1, 2) = TH_dist(Data_Pro{2, 2}, TH);
d(1, 3) = TH_dist(Data_Pro{2, 3}, TH);

% Finding dist using Max TOA method. Fills second row.
d(2, 1) = Max_dist(Data_Pro{3, 1});
d(2, 2) = Max_dist(Data_Pro{3, 2});
d(2, 3) = Max_dist(Data_Pro{3, 3});

% Finding dist using Friis metod. Fills third row.

d(3, 1) = Friis_dist(Data_Pro{3,1});
d(3, 2) = Friis_dist(Data_Pro{3,2});
d(3, 3) = Friis_dist(Data_Pro{3,3});


% Plotting trilateration:
Trilat_TT_Rx(deg, d, 1);
Trilat_TT_Rx(deg, d, 2);
%Trilat_TT_Rx(deg, d, 3);

% Might be able to add some code here (Or in function) to save figures as .pdf in folders.






%% Functions

function Data_pro = dataFind(data, deg, z_in)
    l = sum(~cellfun(@isempty,data), 2); %sums all the valid entries, thereby removing the empty entries.
    for i =1:(l(1))
    
        if contains(data{1, i}, sprintf(".%i.", deg))

            if contains(data{1, i}, sprintf(".z%i.t", z_in))
                disp(data{1, i});
                Data_pro{1, 1} = data{1, i};
                Data_pro{2, 1} = data{2, i};

                % plot_time(data{2, i}(:, 1), data{2, i}(:, 2));
            else
                disp("Wrong height")
            end
        else
            disp("Wrong deg");
        end
    end

    [Ymax, xindx] = max(Data_pro{2, 1}(:, 2));
    xVal = Data_pro{2, 1}(xindx, 1);

    Data_pro{3, 1} = [xVal, Ymax];


end



% write plot function of file in time domain
function plot_TH(x_start, x_end, TH)
    %example to plot treshhold
    x = [x_start, x_end];
    y = [TH, TH];                    %Here we choose a value to be the treshhold above noise.
    line(x, y, 'LineStyle', '--');
    legend('Tx', 'P_r max', 'Threshold');
end



% Write call functions to calculate distance: TOA and Friis.

function d_TH = TH_dist(data, TH)
    indx = find(data(:, 2) > TH, 1);
    x_TH = data(indx, 1);

    d_TH = x_TH * 3E8;
end

function d_Max = Max_dist(data)
    d_Max = data(1) * 3E8;
end

function d_fri = Friis_dist(data)
    PLF = 1;
    Gr = 10^(2.9/10); % Pulseone antenna.
    Gt = 10^(2/10);   % UWB antenna.
    f = 4.5E9;

    lin = 10^(data(2)/10);

   d_fri = sqrt((PLF*Gr*Gt*(3E8)^2)/((4*pi*f)^2)*lin);
end


% Also functions to draw circles and points of BS and drone.

% Plotting the trilateration in the case of Turn Table being seen as the
% drone
function Trilat_TT_Rx(deg, dist, method)

%setting up measured koordinates.
%Trun table rx/drone pos
%               Deg       X-cord      Y-cord
    deg_pos = [  0,        0,         -60; 
                15,      -15.53,      -57.956;
                60,      -51.962,     -30;
               105,      -57.956,      15.53;
               150,      -30,          51.962;
               195,       15.53,       57.96;
               240,       51.962,      30;
               285,       57.96,      -15.53;
               330,       30,         -51.962];

    for i = 1:length(deg_pos)
        if deg == deg_pos(i, 1)
           Rx_x = deg_pos(i, 2);
           Rx_y = deg_pos(i, 3);
           Rx_cord = [Rx_x, Rx_y];
        end
    end

    P0 = [-396.65, 106.28];
    P1 = [-396.65, -158.72];
    P2 = [132.14, -158.72];
         
    
    % Setting up the plot
    if method == 1
        Mtxt = 'Treshhold';
    elseif method == 2
        Mtxt = 'TOA MaxPoint';
    elseif method == 3
        Mtxt = 'Friis';
    end

    
    % Points that were measured
    figure('Name', sprintf('Trilateration: 2D plot %s', Mtxt) ,'Units','normalized' , 'Position', [0.1 0.25 0.35 0.6]);
    plot(P0(1), P0(2), '^', 'MarkerSize', 8, 'Color', 'c');
    hold on
    plot(P1(1), P1(2), '^', 'MarkerSize', 8, 'Color', 'g');
    plot(P2(1), P2(2), '^', 'MarkerSize', 8, 'Color', 'b');
    plot(Rx_cord(1), Rx_cord(2), 'x', 'MarkerSize', 8, 'Color', 'r');
    hold on
    title(sprintf('Method: %s', Mtxt));
    ylabel('Y position [cm]');
    xlabel('X position [cm]');

    %Plot circles
    rad0 = dist(method, 1) * 100;
    rad1 = dist(method, 2) * 100;
    rad2 = dist(method, 3) * 100;

    rectangle('Position',[P0(1)-rad0, P0(2)-rad0, 2*rad0, 2*rad0],...
    'Curvature',[1 1], 'EdgeColor', 'c', 'LineWidth', 1, ...
    'LineStyle','--');

    rectangle('Position',[P1(1)-rad1, P1(2)-rad1, 2*rad1, 2*rad1],...
    'Curvature',[1 1], 'EdgeColor', 'g', 'LineWidth', 1, ...
    'LineStyle','--');

    rectangle('Position',[P2(1)-rad2, P2(2)-rad2, 2*rad2, 2*rad2],...
    'Curvature',[1 1], 'EdgeColor', 'b', 'LineWidth', 1, ...
    'LineStyle','--');

    axis equal;


end

