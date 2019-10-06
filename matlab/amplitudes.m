[x, fs]=audioread('file_example_WAV_10MG.wav');
x(:,2) = [];
amps  = [-10 -10 -10 -5 0 5 10 10 10 10];
%amps = 10 .^ ((amps) / 40);
 N_fft = 1024;
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
%amplitudes(513)=  amps(10);

for i=2:f_k1
    amplitudes(i)= amps(1);
  %  amplitudes(N_fft-(i-2))= amps(1);
end

for i=(f_k1+1):(N_fft)
  
    if (i == f_k1+1)
       k = amps(2);
    elseif (i == f_k2+1)
       k = amps(3);
    elseif (i == f_k3+1)
       k = amps(4);
    elseif (i == f_k4+1)
       k = amps(5);
    elseif (i == f_k5+1)
       k = amps(6);
    elseif (i == f_k6+1)
       k = amps(7);
    elseif (i == f_k7+1)
       k = amps(8);
    elseif (i == f_k8+1)
       k = amps(9);
    elseif (i == f_k9+1)
       k = amps(10);  
    elseif (i == 1024 - (f_k9+1))
       k = amps(9);
    elseif (i == 1024 - (f_k8+1))
       k = amps(8);
       elseif (i == 1024 - (f_k7+1))
       k = amps(7);
       elseif (i == 1024 - (f_k6+1))
       k = amps(6);
       elseif (i == 1024 - (f_k5+1))
       k = amps(5);
       elseif (i == 1024 - (f_k4+1))
       k = amps(4);
       elseif (i == 1024 - (f_k3+1))
       k = amps(3);
        elseif (i == 1024 - (f_k2+1))
       k = amps(2);
    end
        
        amplitudes(i)= k;
    %    amplitudes(N_fft-(i-2))= k;
end

x1 =x(1:1024);
Y= fft(x1).*amplitudes.';
y = ifft(Y);

plot(amplitudes)
%fileID = fopen('Amplitude1.txt','w');
%fprintf(fileID,'%f\n',amplitudes);
%fclose(fileID);