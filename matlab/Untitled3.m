[x, fs]=audioread('file_example_WAV_10MG.wav');
x(:,2) = [];

N_fft = 1024;

amps  = [-10 -10 -10 -5 0 5 10 10 10 10];
amps = 10 .^ ((amps) / 40);

%FREKVENCIJE
freqs = [200 400 800 1500 3000 5000 7000 10000 15000];

%SKALIRANE FREKVENCIJA NA 512 ODBIRAKA 
f_k1 = 5; 
f_k2 = 10;  
f_k3 = 19;
f_k4 = 35;
f_k5 = 70;
f_k6 = 117;
f_k7 = 163;
f_k8 = 232;
f_k9 = 348;

%ODREDJIVANJE POJACANJA ZA SVAKI ODBIRAK FFT
amplitudes(1)= amps(1);
amplitudes(513)=  amps(10);

for i=2:f_k1
    amplitudes(i)= amps(1);
    amplitudes(N_fft-(i-2))= amps(1);
end

for i=(f_k1+1):(N_fft/2)
  
    if (i <= f_k2)
       k = amps(2);
    elseif (i > f_k2 && i <=f_k3)
       k = amps(3);
    elseif (i > f_k3 && i <=f_k4)
       k = amps(4);
    elseif (i > f_k4 && i <=f_k5)
       k = amps(5);
    elseif (i > f_k5 && i <=f_k6)
       k = amps(6);
    elseif (i > f_k6 && i <=f_k7)
       k = amps(7);
    elseif (i > f_k7 && i <=f_k8)
       k = amps(8);
    elseif (i > f_k8 && i <=f_k9)
       k = amps(9);
    else
       k = amps(10);   
    end
        
        amplitudes(i)= k;
        amplitudes(N_fft-(i-2))= k;
end

ii = 0;
ypr = x(((N_fft*ii)+1):(N_fft*(ii+1)));
Ypr1 = fft(ypr).';
Ypr = Ypr1.*amplitudes;
y(((N_fft*ii)+1):(N_fft*(ii+1))) = ifft(Ypr);