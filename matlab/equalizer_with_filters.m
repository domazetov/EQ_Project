%ODREDJIVANJE ULAZA
[x, fs]=audioread('Miss K8 ft MC Nolz - Metropolis of Massacre (Official Dominator 2014 anthem).mp3');
x(:,2) = []; %uklanjanje druge kolone matrice, jer audioread ocitava matricu(1x2);

%PROJEKTOVANJE EQUALIZERA
%red filtra
M = 1000; 
N = M-1;
M1 = 1001;
N1 = M1-1;

%granicna ucestanost
WnNF = 0.005; %NF
Wn1 = [0.005 0.01]; %PO
Wn2 = [0.01 0.05]; %PO
Wn3 = [0.05 0.1]; %PO
Wn4 = [0.1 0.3]; %PO
Wn5 = [0.3 0.6]; %PO
WnVF = 0.6; %VF

%faktor pojacanja
PNF = 2; %NF
P1 = 1; %PO
P2 = 1; %PO
P3 = 1; %PO
P4 = 1; %PO
P5 = 1; %PO
PVF = 1; %VF

%projektovanje prozora
hanov = hann(M); 
hanov1= hann(M1);

%koeficijenti impulsnog odziva
bNF = fir1 (N, WnNF,hanov); %NF filtar
b1 = fir1 (N, Wn1,hanov); %PO filtar
b2 = fir1 (N, Wn2,hanov); %PO filtar
b3 = fir1 (N, Wn3,hanov); %PO filtar
b4 = fir1 (N, Wn4,hanov); %PO filtar
b5 = fir1 (N, Wn5,hanov); %PO filtar
bVF = fir1 (N1, WnVF,'high',hanov1); %VF filtar

%fft
N_fft =2^20; 
BNF = fft (bNF, N_fft);
B1 = fft (b1, N_fft);
B2 = fft (b2, N_fft);
B3 = fft (b3, N_fft);
B4 = fft (b4, N_fft);
B5 = fft (b5, N_fft);
BVF = fft (bVF, N_fft);

XT = fft (x, N_fft);
X = XT.'; %transponovanje reda XT u kolonu X

YNF = X.*BNF.*PNF;
Y1 = X.*B1.*P1;
Y2 = X.*B2.*P2;
Y3 = X.*B3.*P3;
Y4 = X.*B4.*P4;
Y5 = X.*B5.*P5;
YVF = X.*BVF.*PVF;

Y = YNF + Y1 + Y2 + Y3 + Y4 + Y5 + YVF;

YT= Y.'; %transponovanje kolone Y u red YT zbog citanja

y = ifft(YT);

%AMPLITUDSKE KARAKTERISTIKE
BNFa = abs(BNF(1:N_fft/2));
B1a = abs(B1(1:N_fft/2));
B2a = abs(B2(1:N_fft/2));
B3a = abs(B3(1:N_fft/2));
B4a = abs(B4(1:N_fft/2));
B5a = abs(B5(1:N_fft/2));
BVFa = abs(BVF(1:N_fft/2));
Xa = abs(X(1:N_fft/2));
Ya =abs(Y(1:N_fft/2));

Xf = angle(X);
Yf = angle(Y);

%PRIKAZ 
K = 0:N_fft/2-1; 
w = K*pi/(N_fft/2-1); 

figure; subplot (2, 1, 1); hold on; title ('Amplitudski spektar filtara','FontSize', 14);
plot (w, BNFa); 
plot (w, B1a, 'r'); 
plot (w, B2a, 'k'); 
plot (w, B3a, 'm');
plot (w, B4a, 'y');
plot (w, B5a, 'c');
plot (w, BVFa, 'r');
legend ('NF','PO1','PO2','PO3','PO4','PO5','VF'); 
subplot (2, 1, 2); hold on; title ('Amplitudski spektar filtara u decibelima','FontSize', 14);
plot (w, 20*log10(BNFa)); 
plot (w, 20*log10(B1a), 'r'); 
plot (w, 20*log10(B2a), 'k'); 
plot (w, 20*log10(B3a), 'm');
plot (w, 20*log10(B4a), 'y');
plot (w, 20*log10(B5a), 'c');
plot (w, 20*log10(BVFa), 'r');
legend ('NF','PO1','PO2','PO3','PO4','PO5','VF'); 

figure;
subplot(2,2,1),plot (w, Xa), title ('Amplitudski spektar ulaznog signala', 'FontSize', 14);
subplot(2,2,2),plot (w, Ya), title ('Amplitudski spektar izlaznog signala', 'FontSize', 14);
subplot(2,2,3),plot(w, Ya - Xa), title ('Razlika spektra izlaznog i ulaznog signala', 'FontSize', 14);
%subplot(2,2,4);plot(w, 20*log10(Ya - Xa)), title ('Razlika amplitudskog spektra izlaznog i ulaznog signala u decibelima', 'FontSize', 14); %OVDE JAVLJA WARNING TO NIJE NI TOLIKO BITNO

figure;
subplot(2,1,1), plot(x);
subplot(2,1,2), plot(y);

%PUSTANJE PESME
k = audioplayer(y, fs);
play(k);
