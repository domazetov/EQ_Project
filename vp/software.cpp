#include "software.hpp"

using namespace std;
using namespace sc_dt;
using namespace sc_core;

software::software(sc_module_name name) :
	sc_module(name)
{
  cout << "Constructed\n";
  SC_THREAD(aplication);
}

void software::aplication()
{
    /*** RESET HARDWARE ***/
    reset->reset_hardware();

    /*** AUDIO VARIABLES ***/
    int N = get_number_of_frames();
    int number_of_packages = N/package_length;

    unsigned int pr[9] = {5, 10, 19, 35, 70, 117, 163, 232, 348}; //boundaries
    double p1[10] = {-10, -10, -10, -5, 0, 5, 10, 10, 10, 10}; //amplification[dB]
    unsigned int p_adress[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    unsigned int pr_adress[9] = {10, 11, 12, 13, 14, 15, 16, 17, 18};

    double p[10];
    for(int i = 0; i < 10; i ++)
        p[i] = pow(10, p1[i]/40);

    /*** READ WAV FILE ***/
    double* Input_array = read_audio();

    /*** READ EXPECTED RESULT ***/
    double* Golden_vector = read_txt();

    /*** SEND AMPLIFICATION ***/
    for(int i = 0; i < 10; i++)
    {
        cout << "Generate transaction of amplification [" << i << "].\n";
        sc_fixed<32, 10> pp = p[i];
        unsigned int ppp = pp << 22;
        cout << "Transaction sent.\n";
        wr_lite_port->axil_write((sc_uint<32>)ppp,p_adress[i]);
    }

    /*** SEND BOUNDARIES ***/
    for(int i = 0; i < 9; i++)
    {
        cout << "Transaction of boundary [" << i << "] sent.\n";
        wr_lite_port->axil_write((sc_uint<32>)pr[i],pr_adress[i]);
    }
    /*** EQUALSATION PROCESS FOR EACH PACKAGE OF THE SONG ***/
    for(int i = 0; i != number_of_packages; i++)
	{
        /*** READ PACKAGE ***/
        cout << "Generate transaction of " << package_length << " audio_frames.\n";
        for (int j=0; j != package_length; ++j)
        {
            sc_fixed<24, 2> numm = Input_array[package_length*i + j];
            unsigned int nummm = numm << 22;
            sc_uint<24> num = nummm;
            tran.push_back(num);
		}

        /*** WRITE PACKAGE, AMPLIFICATIONS AND BOUDARIES TO HARDWARE ***/
        cout << "Transaction sent.\n";
        wr_port->axis_write(tran);

        /*** READ PACKAGE FROM HARDWARE ***/
        rd_port->axis_read(res);

        for(size_t j = 0; j <res.size(); j++)
        {
            unsigned int numm = res[j];
            sc_fixed<24, 2> num = double(numm) / (1 << 22);
            output.push_back(num);
        }
        res.clear();
        cout << "Transaction received.\n";

        /*** READ GOLDEN VECTOR PACKAGE ***/
        for(int j = 0; j <package_length; j++)
        {
            double num = Golden_vector[package_length*i + j];
            golden_vect.push_back(num);
        }

        /*** CHECKING ***/
        if(tran.size() != output.size())
		{
            cout << "Test failed.\n";
            cout << "Expected size " << tran.size() << endl;
            cout << "Received size " << res.size() << endl;
            return;
		}
        tran.clear();
        for (size_t ii = 0; ii != golden_vect.size(); ++ii)
		{
            if(abs(golden_vect[ii] - output[ii]) > pow(10, -6))
			{
                cout << "Test " << i << " failed.\n";
                cout << "Elemnt with index " << ii << endl;
                cout << "Expected value " << golden_vect[ii] << endl;
                cout << "Received value " << output[ii] << endl;
                return;
			}
		}
		golden_vect.clear();
        output.clear();
        cout << "Test " << i << " passed.\n";
	}
}
double* software::read_audio()
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
    sf = sf_open("skracenapesma.wav",SFM_READ,&info);
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
int software::get_number_of_frames()
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
double* software::read_txt()
{
    static double NIZ[1024*2540];
    ifstream inputFile;
    inputFile.open("skracena.txt");

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
