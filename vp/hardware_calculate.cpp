#include "hardware_calculate.hpp"

using namespace sc_core;
using namespace sc_dt;
using namespace std;

hardware_calculate::hardware_calculate(sc_module_name name) :
	sc_module(name)
{
	SC_CTHREAD(hardware_function, clk.pos());
	reset_signal_is(rst,false);
}

void hardware_calculate::hardware_function()
{
    /*** READ AMPLIFICATIONS ***/
    for(int i = 0; i < 10; i++)
    {
        cout << "Starting P...\n";
        wait();
        s00_axi_bvalid.write(SC_LOGIC_0);
        s00_axi_awready.write(SC_LOGIC_0);
        s00_axi_wready.write(SC_LOGIC_0);
        wait();

        while(1)
        {
            wait();
            if(s00_axi_awvalid.read() == SC_LOGIC_1)
                adress_p[i] = (sc_uint<7>)s00_axi_awaddr.read();
            if(s00_axi_wvalid.read() == SC_LOGIC_1)
                data_p[i] = (sc_uint<32>)s00_axi_wdata.read();
            if(s00_axi_bready.read() == SC_LOGIC_1)
                break;
        }
        wait();
        s00_axi_awready.write(SC_LOGIC_1);
        s00_axi_wready.write(SC_LOGIC_1);

        wait();

        s00_axi_bvalid.write(SC_LOGIC_1);

        cout << "amplification[" <<i<<"] receved."<<endl;
        wait();
    }
    /*** READ BOUNDARIES ***/
    for(int i = 0; i < 9; i++)
    {
        cout << "Starting PR...\n";
        wait();
        s00_axi_bvalid.write(SC_LOGIC_0);
        s00_axi_awready.write(SC_LOGIC_0);
        s00_axi_wready.write(SC_LOGIC_0);
        wait();

        while(1)
        {
            wait();
            if(s00_axi_awvalid.read() == SC_LOGIC_1)
                adress_pr[i] = (sc_uint<7>)s00_axi_awaddr.read();
            if(s00_axi_wvalid.read() == SC_LOGIC_1)
                data_pr[i] = (sc_uint<32>)s00_axi_wdata.read();
            if(s00_axi_bready.read() == SC_LOGIC_1)
                break;
        }
        wait();
        s00_axi_awready.write(SC_LOGIC_1);
        s00_axi_wready.write(SC_LOGIC_1);

        wait();

        s00_axi_bvalid.write(SC_LOGIC_1);

        cout << "boundary[" << i<<"] receved."<<endl;
        wait();
    }

    for(int i = 0; i < number_of_amplifications; i++)
    {
        pp[i] = data_p[i];
        p[i] = (double)pp[i] / (1 << 22);
        cout << "amplification["<<i<<"] = " <<p[i]<<",  address-> "<<adress_p[i]  <<endl;
    }
    for(int i = 0; i < number_of_boundaries; i++)
    {
        pr[i] = data_pr[i];
        cout << "amplification["<<i<<"] = " <<pr[i]<<",  address-> "<<adress_pr[i]  <<endl;
    }

    /*** EQUALIZER EVALUATION ***/
	while(1)
	{
        cout << "Starting...\n";
		arsize = 0;
		m00_axis_tvalid.write(SC_LOGIC_0);
		m00_axis_tlast.write(SC_LOGIC_0);
		s00_axis_tready.write(SC_LOGIC_1);
		wait();

		while(1)
		{
			wait();
			if (s00_axis_tvalid.read() == SC_LOGIC_1)
			{
                sc_uint<24> m = s00_axis_tdata.read();
                unsigned int mm = m;
				nums[arsize++] = double(mm) / (1 << 22);
				if(s00_axis_tlast.read() == SC_LOGIC_1)
					break;
			}
		}

		wait();
		cout << "Received transaction of size " << arsize << endl;
		s00_axis_tready.write(SC_LOGIC_0);

        /*** AUXILIARY VARIABLES ***/
		N = arsize;
        dcomp *X = new dcomp[package_length];
        dcomp *Xp = new dcomp[package_length/2];
        dcomp *Xn = new dcomp[package_length/2];
        dcomp *Y = new dcomp[package_length];
        dcomp *Y1 = new dcomp[package_length];
        dcomp *Y1p = new dcomp[package_length/2];
        dcomp *Y1n = new dcomp[package_length/2];
        dcomp W1, W2, W3, W4;
        double *x = new double[package_length];
        double *y = new double[package_length];
        double *fft_out_re = new double[package_length];
        double *fft_out_im = new double[package_length];
        double *ip_out_re = new double[package_length];
        double *ip_out_im = new double[package_length];

		/*** READ AUDIO SAMPLES ***/
        for(int i = 0; i < N; i++)
            x[i] = nums[i].to_double();

        /*** FAST FOURIER TRANSFORM (raddix 2 algorithm) ***/
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
        delete[] x;
        delete[] Xp;
        delete[] Xn;

        /*** WRITE FFT OUTPUT ***/
        for(int i = 0; i < N; i++)
        {
            fft_out_re[i] = real(X[i]);
            fft_out_im[i] = imag(X[i]);
        }
        delete[] X;

        /*** FFT DELAY ***/
        for (int i = 0; i != 5294; ++i)
            wait();

        /*** MULTIPLY EACH FREQUENCY RANGE WITH CORRESPONDING AMPLIFICATION ***/
        double k = p[0];
        for(int i=0; i<N; i++)
        {
            if(i == pr[0])
                k = p[1];
            else if(i == pr[1])
                k = p[2];
            else if(i == pr[2])
                k = p[3];
            else if(i == pr[3])
                k = p[4];
            else if(i == pr[4])
                k = p[5];
            else if(i == pr[5])
                k = p[6];
            else if(i == pr[6])
                k = p[7];
            else if(i == pr[7])
                k = p[8];
            else if(i == pr[8])
                k = p[9];
            else if(i == (N+1 - pr[8]))
                k = p[8];
            else if(i == (N+1 - pr[7]))
                k = p[7];
            else if(i == (N+1 - pr[6]))
                k = p[6];
            else if(i == (N+1 - pr[5]))
                k = p[5];
            else if(i == (N+1 - pr[4]))
                k = p[4];
            else if(i == (N+1 - pr[3]))
                k = p[3];
            else if(i == (N+1 - pr[2]))
                k = p[2];
            else if(i == (N+1 - pr[1]))
                k = p[1];
            else if(i == (N+1 - pr[0]))
                k = p[0];

            ip_out_re[i] = fft_out_re[i]*k;
            ip_out_im[i] = fft_out_im[i]*k;
        }
        delete[] fft_out_re;
        delete[] fft_out_im;

        for(int i = 0; i < N; i++)
            Y[i] = dcomp(ip_out_re[i], ip_out_im[i]);

        delete[] ip_out_re;
        delete[] ip_out_im;

        /*** IP DELAY ***/
        for (int i = 0; i != 3; ++i)
            wait();

        /*** INVERSE FAST FOURIER TRANSFORM (raddix 2 algorithm) ***/
        for(int i = 0; i < N/2; i++)
        {
            W3 = WI(N,i,1);
            for(int j =0; j < N/2;j++)
            {
                W4 = WI(N/2,i,j);
                Y1p[i]+=Y[2*j]*W4;
                Y1n[i]+=Y[2*j+1]*W4;
            }
            Y1[i] = Y1p[i] + W3*Y1n[i];
            Y1[i+N/2] = Y1p[i] - W3*Y1n[i];
        }
        delete[] Y;
        delete[] Y1p;
        delete[] Y1n;

        /*** OUTPUT AUDIO SAMPLES ***/
        for(int i =0; i< N; i++)
            y[i]= real(Y1[i])/N;

        delete[] Y1;

        /*** IFFT DELAY ***/
        for (int i = 0; i != 5294; ++i)
            wait();

		cout << "Cycle accurate core done sorting.\n";

		int i = 0;
		sc_fixed<24, 2> buff = y[0];
        unsigned int b = buff << 22;
        sc_uint<24> buf = b;
		sc_fixed<24, 2> buff1 = y[1];
		unsigned int b1 = buff1 << 22;
		sc_uint<24> buf1 = b1;

		/*** WRITE EQUALIZED AUDIO SAMPLES ON HARDWARE OUTPUT ***/
		while(i != N)
		{
			wait();
			m00_axis_tvalid.write(SC_LOGIC_1);
			m00_axis_tdata.write(buf);
			if (i == (arsize-1))
				m00_axis_tlast.write(SC_LOGIC_1);
			else
				m00_axis_tlast.write(SC_LOGIC_0);
			if (m00_axis_tready.read() == SC_LOGIC_1)
			{
				i++;
				buf = buf1;
				buff1 = y[i+1];
                b1 = buff1 << 22;
                buf1 = b1;
			}
		}
		delete[] y;

		cout << "Transaction sent from cycle accurate core.\n";
		wait();
	}
}
dcomp hardware_calculate::W(int N, int k, int n)
{
    std::complex<double> i(0 , 1);
    dcomp W;
    W = exp((-2*M_PI*k*n/N)*i);
    return W;
}
dcomp hardware_calculate::WI(int N, int k, int n)
{
    std::complex<double> i(0 , 1);
    dcomp W;
    W = exp((2*M_PI*k*n/N)*i);
    return W;
}
