%OCITAVANJE ULAZA
[x, fs]=audioread('file_example_WAV_10MG.wav');
%ULAZNI NIZ BEZ STEREA
x(:,2) = [];

N_fft = 1024;

%POJACANJA FREKVENCIJA
amps  = [0 2 4 10 5 0];
amps = 10 .^ ((amps)/40);
%FREKVENCIJE
freqs = [100 500 1000 5000 10000]; 

%ODBIRCI FFT KOJI PRIBLIZNO ODGOVARAJU FREKVENCIJAMA 
f_k1 = 2; %100 Hz
f_k2 = 12; %500 Hz
f_k3 = 23; %1000 Hz
f_k4 = 116; %5000 Hz
f_k5 = 232; %10000 Hz

%ODREDJIVANJE POJACANJA ZA FFT
amplitudes(1)= amps(1);
amplitudes(513)=  amps(6);

for i=2:f_k1
    amplitudes(i)= amps(1);
    amplitudes(N_fft-(i-2))= amps(1);
end

for i=(f_k1+1):(N_fft/2)
  
    if (i <= f_k2)
       k = (amps(2)-amps(1))/(f_k2-f_k1);
    elseif (i > f_k2 && i <=f_k3)
       k = (amps(3)-amps(2))/(f_k3-f_k2);
    elseif (i > f_k3 && i <=f_k4)
       k = (amps(4)-amps(3))/(f_k4-f_k3);
    elseif (i > f_k4 && i <=f_k5)
       k = (amps(5)-amps(4))/(f_k5-f_k4);
    else
       k = (amps(6)-amps(5))/(N_fft/2-f_k5);    
    end
        
        amplitudes(i)= amplitudes(i-1)+k;
        amplitudes(N_fft-(i-2))= amplitudes(N_fft-(i-3))+k;
end

%FFT ULAZNOG SIGNALA PO SEGMENTIMA OD 1024 TACKE I IFFT
%RACUNANJE (EQUALIZING)
for i = 0:(N_fft-1)
    ypr = x(((N_fft*i)+1):(N_fft*(i+1)));
    Ypr = fft(ypr).';
    Ypr = Ypr.*amplitudes;
    y(((N_fft*i)+1):(N_fft*(i+1))) = ifft(Ypr);
end

%PUSTANJE PESME
k = audioplayer(y,fs);
play(k);

%PRIKAZ POJACANJA FFT-a
plot(amplitudes);

