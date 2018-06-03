clc; clear all;

PRN = 1:32;

%%

ca   = cacode(PRN);

%% TASK2: Analyze CA Code properties, compute autocorr, inverted autocorr, crosscorr.

cac12 = cacode(12);
ca12 = repmat(cac12',3,1);

% set window size
r = 25;
autocorr = zeros(1,2*r+1);
invcorr = zeros(1,2*r+1);
corr = zeros(32,2*r+1);
invca = -1 * cac12;

for p = -r : r
    autocorr( p+r+1 ) = 1/1023 * cac12 * ca12( 1024+p : 2046+p );
    invcorr( p+r+1 ) = 1/1023 * invca * ca12( 1024+p : 2046+p ); 
    corr( :, p+r+1 ) = 1/1023 * cac12 * ca12( 1024+p : 2046+p );

end

figure
plot(-r : r, autocorr);
grid on

figure
hold on
grid on
for q = 1:32
    plot (-r : r, corr(q,:));
end
hold off

%% TASK 3
% Generate a BPSK modulated signal
fi = 4.092e6;		% Hz
fs = 16.368e6;		% Hz
fca = 1.023e6;		% Hz

for prn = 1:32
    G = 1;
    phi = 0;
        for i=1:16368
%         GPSCode_int(i) = cacode(prn,floor(mod(G,1024)));
        GPSCode_int(i) = ca(prn,floor(mod(G,1024)));
        G = G + fca / fs;
        SIGNAL(i) = 3 * sin(phi);
        phi = phi + (2 * pi * fi) / fs;   
        BPSK2(prn,i) = SIGNAL(i) * GPSCode_int(i);
    end;
end;

% plot BPSK2 signal
t = linspace(1,fs,100);
figure
hold on
plot(t,BPSK2(5,1:100))
title('BPSK2 signal for PRN 5')
xlabel('Time [us]');
ylabel('BPSK2 Samples')

%% TASK 4

sig = importdata('signal.txt');
R = 1/16368 * BPSK2 *  sig;
maxR = max(R(:))
SatSV = find(R == maxR)
figure
hold on
plot(R,'*');
for x = 1:32;
    text(x, R(x), num2str(x))
end
title('Identification of the signal of satellite');
ylabel('Correlation[-]');
xlabel('PRN Number[-]');


%% TASK END
