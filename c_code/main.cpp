#include <stdio.h>
#include <stdlib.h>
#include <sndfile.h>
#include <iostream>
#include <fstream>
#include <complex>
#include <math.h>
#include <array>

#define PI 3.1415926535897932384626433832795028841971693993751058209749445923


using namespace std;
typedef complex<double> dcomp;

dcomp W(int N, int k, int n)
{
    std::complex<double> i(0 , 1);
    dcomp W;
    W = exp((-2*PI*k*n/N)*i);
    return W;
}
dcomp WI(int N, int k, int n)
{
    std::complex<double> i(0 , 1);
    dcomp W;
    W = exp((2*PI*k*n/N)*i);
    return W;
}
double* read_audio()
{
    SNDFILE *sf;
    SF_INFO info;
    int num, num_items;
    double *buf;
    int f,sr,c;
    int i;
    int j = 0;

    /* Open the WAV file. */
    info.format = 0;
    sf = sf_open("../vp/skracenapesma.wav",SFM_READ,&info);
    if (sf == NULL)
    {
        printf("Failed to open the file.\n");
        exit(-1);
    }
    /* Print some of the info, and figure out how much data to read. */
    f = info.frames;
    sr = info.samplerate;
    c = info.channels;
    printf("frames=%d\n",f);
    printf("samplerate=%d\n",sr);
    printf("channels=%d\n",c);
    num_items = f*c;
    printf("num_items=%d\n",num_items);
    /* Allocate space for the data to be read, then read it. */
    buf = (double *) malloc(num_items*sizeof(double));
    num = sf_read_double(sf,buf,num_items);
    sf_close(sf);
    printf("Read %d items\n",num);
    double* x= new double[num/2];

    for (i = 0; i < num; i += 2)
        {
            x[j]=buf[i];
            j++;
        }
    return x;
}
int get_number_of_frames()
{
    SNDFILE *sf;
    SF_INFO info;
    int f;
    info.format = 0;

    sf = sf_open("skracenapesma.wav",SFM_READ,&info);
    if (sf == NULL)
    {
        printf("Failed to open the file.\n");
        exit(-1);
    }
    f = info.frames;
    sf_close(sf);
    return f;
}
dcomp* FFT(double* x, int N)
{
    dcomp *X = new dcomp[N];
    dcomp W1, W2;
    dcomp *Xp = new dcomp[N/2];
    dcomp *Xn = new dcomp[N/2];

    for(int i = 0; i < N/2; i++)
    {
        W1 = W(N,i,1);

        for(int j = 0; j < N/2; j++)
        {
            W2 = W(N/2,i,j);

            Xp[i]+=x[2*j]*W2;
            Xn[i]+=x[2*j+1]*W2;
        }

        X[i] = Xp[i] + W1*Xn[i];
        X[i+N/2] = Xp[i] - W1*Xn[i];
    }
    return X;
}
double* IFFT(dcomp* Y, int N)
{
    double* y = new double[N];
    dcomp W1,W2;
    dcomp* Y1= new dcomp[N];
    dcomp* Y1p = new dcomp[N/2];
    dcomp* Y1n = new dcomp[N/2];

    for(int i = 0; i < N/2; i++)
    {
        W1 = WI(N,i,1);
        for(int j =0; j < N/2;j++)
        {
            W2 = WI(N/2,i,j);
            Y1p[i]+=Y[2*j]*W2;
            Y1n[i]+=Y[2*j+1]*W2;
        }
        Y1[i] = Y1p[i] + W1*Y1n[i];
        Y1[i+N/2] = Y1p[i] - W1*Y1n[i];
    }

    for(int t =0; t< N; t++)
        y[t] = real(Y1[t])/N;

    return y;
}
double* read_txt()
{
    static double NIZ[1024*2540];
    ifstream inputFile;
    inputFile.open("../vp/skracena.txt");

    if(!inputFile)
        cout<<"Error opening text file"<<endl;
    else
    {
        for(int i = 0; i < 1024*2540; i++)
        {
            inputFile>>NIZ[i];
        }
    }
    inputFile.close();
    return NIZ;
}

dcomp* hardware_IP(dcomp* X, int package_length, double* ampl, int* frekv)
{
    dcomp* Y=new dcomp[package_length];
    double k = ampl[0];

    for(int i=0; i<package_length; i++)
    {
        if(i == frekv[0])
            k = ampl[1];
        else if(i == frekv[1])
            k = ampl[2];
        else if(i == frekv[2])
            k = ampl[3];
        else if(i == frekv[3])
            k = ampl[4];
        else if(i == frekv[4])
            k = ampl[5];
        else if(i == frekv[5])
            k = ampl[6];
        else if(i == frekv[6])
            k = ampl[7];
        else if(i == frekv[7])
            k = ampl[8];
        else if(i == frekv[8])
            k = ampl[9];
        else if(i == (1025 - frekv[8]))
            k = ampl[8];
        else if(i == (1025 - frekv[7]))
            k = ampl[7];
        else if(i == (1025 - frekv[6]))
            k = ampl[6];
        else if(i == (1025 - frekv[5]))
            k = ampl[5];
        else if(i == (1025 - frekv[4]))
            k = ampl[4];
        else if(i == (1025 - frekv[3]))
            k = ampl[3];
        else if(i == (1025 - frekv[2]))
            k = ampl[2];
        else if(i == (1025 - frekv[1]))
            k = ampl[1];
        else if(i == (1025 - frekv[0]))
            k = ampl[0];

        Y[i] = X[i]*k;
    }

    return Y;
}
int main()
{
    double ampll[10] = {-10, -10, -10, -5, 0, 5, 10, 10, 10, 10};
    double ampl[10];

    for(int i = 0; i < 10; i ++)
        ampl[i] = pow(10, ampll[i]/40);

    int frekv[9] = {5, 10, 19, 35, 70, 117, 163, 232, 348};

    int package_length = 1024;
    int N = get_number_of_frames();
    int number_of_packages = N/package_length;

    double input_package[package_length];
    double* output_package;

    dcomp* X;
    dcomp* Y;

    double* Output_array = new double[package_length*number_of_packages];

    /*** SOFTWARE READ AUDIO BLOCK ***/
    double* Input_array=read_audio();

    for(int i=0; i< number_of_packages; i++)
    {
        /*** SOFTWARE INPUT PACKAGE BLOCK***/
        for(int j=0; j<package_length;j++)
            input_package[j] = Input_array[package_length*i + j];

        /*** HARDWARE IP FFT (OKORISTIMO OD VIVADA)***/
        X = FFT(input_package, package_length);

        /*** HARDWARE AMPLITUDE AND MULTIPLICATION IP ***/
        Y = hardware_IP(X, package_length, ampl, frekv);

        /*** HARDWARE IP IFFT (KORISTIMO OD VIVADA)***/
        output_package = IFFT(Y, package_length);

        /*** SOFTWARE OUTPUT PACKAGE BLOCK***/
        for(int j=0; j<package_length;j++)
            Output_array[package_length*i + j] = output_package[j];
    }


    /**** PROVERA POJACANJA ***/
    /*double* provera_amplitude = ocitaj_koeficijente();
    int tacno= 0;
    for(int i = 0; i <1024; i++)
    {
        if(amplitudes[i] == provera_ampitude[i])
            tacno ++;
        else
            cout<<"Greska: ["<<i<<"] !"<<endl;
        if(tacno == 1024)
            cout<<"Sve je tacno"<<endl;
    }*/

    /*** PROVERA REZULTATA NA IZLAZU ***/
   double* Golden_vector = read_txt();
    int Thrue= 0;
    for(int i = 0; i <package_length*number_of_packages; i++)
    {
        if(abs(Output_array[i] - Golden_vector[i]) < pow(10, -10)) // OVDE SAM OSTAVIO DA TACNOST BUDE 0.0000000001 jer kad sacuvam iz matlaba kod ne konvertuje se u pun double format i onda ima ta mala greska
            Thrue ++;
        else
        {
            cout<<"Absolute error = "<<abs(Output_array[i] - Golden_vector[i])<<" output_element -> ["<<i<<"] "<<endl;
            break;
        }

        if(Thrue == package_length*number_of_packages)
            cout<<"Everything is true"<<endl;
    }

    return 0;
}
