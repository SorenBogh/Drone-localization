%QAM Setup
numbits = 60; %Amount of bits
modOrder = 16; %Modulation Order
fc = 2.4*10^9; %Carrier Frequency
fs = 24*10^9; %Sampling Frequency

randomBit = randi([0,1], numbits, 1); %Generation of binaries (Randomizing)

Modulation = qammod(randomBit, modOrder); %Modulation function

t = 0:0.01:5; %Time (From 0 to 5 sec with 0.01 sec)

I_Part = real(Modulation).*cos(2*pi*fc*t); %I-part of QAM
Q_Part = imag(Modulation).*sin(2*pi*fc*t); %Q-part of QAM

Transmission = I_Part+Q_Part; %Sum of QAM modulation

%Receiving = Transmission.*cos(2*pi*fc*t) - 1i * Transmission.*sin(2*pi*fc*t);

Demodulation = qamdemod(Receiving,modOrder);

demodulatedBits = de2bi(Demodulation, log2(modOrder));

% Reshape the binary bits to a column vector
demodulatedBits = demodulatedBits(:);

% Ensure the number of demodulated bits matches the number of original bit
demodulatedBits = demodulatedBits(1:numbits);

disp('Original Bits:');
disp(Modulation.');

disp('Demodulated Bits:');
disp(demodulatedBits.');

% Calculate Bit Error Rate (BER)
BER = biterr(randomBit, demodulatedBits) / numbits;
disp(['Bit Error Rate (BER): ' num2str(BER)]);