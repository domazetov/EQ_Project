#ifndef _SOFTWARE_HPP_
#define _SOFTWARE_HPP_

#include "communication.hpp"
#include <systemc>
#include <sndfile.h>
#include <fstream>
#include <math.h>
#include <sysc/datatypes/fx/sc_fixed.h>

#define package_length 1024

typedef std::vector< double > array_of_double;
typedef std::vector< sc_uint<24> > array_of_uint;

SC_MODULE(software)
{
public:
	SC_HAS_PROCESS(software);

	software(sc_core::sc_module_name);

	sc_core::sc_port< axil_master_if > wr_lite_port;
	sc_core::sc_port< axis_master_if > wr_port;
	sc_core::sc_port< axis_slave_if > rd_port;
	sc_core::sc_port< reset_if > reset;
protected:
    /*** MAIN METHOD ***/
	void aplication();

	/*** AUXILIARY FUNCTIONS ***/
    double* read_audio();
    int get_number_of_frames();
    double* read_txt();

    /*** AUXILIARY VARIABLES ***/
    array_of_double golden_vect, output;
    array_of_uint tran, res;
};

#endif
