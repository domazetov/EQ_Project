#ifndef _HARDWARE_CALCULATE_HPP_
#define _HARDWARE_HPP_

#include <systemc>
#include <sysc/datatypes/fx/sc_fixed.h>
#include <complex>
#include "math.h"

#define package_length 1024
#define number_of_amplifications 10
#define number_of_boundaries 9
#define NN 1024

using namespace std;
using namespace sc_dt;
typedef complex<double> dcomp;

SC_MODULE(hardware_calculate)
{
public:
	SC_HAS_PROCESS(hardware_calculate);

	hardware_calculate(sc_core::sc_module_name);

	sc_core::sc_in< bool > clk;
	sc_core::sc_in< bool > rst;
	sc_core::sc_in<sc_lv<7>> 	s00_axi_awaddr	;
	sc_core::sc_in<sc_logic>	s00_axi_awvalid	;
	sc_core::sc_out<sc_logic>	s00_axi_awready	;
	sc_core::sc_in<sc_lv<32>> 	s00_axi_wdata	;
	sc_core::sc_in<sc_logic> 	s00_axi_wvalid	;
	sc_core::sc_out<sc_logic> 	s00_axi_wready	;
	sc_core::sc_out<sc_logic> 	s00_axi_bvalid	;
	sc_core::sc_in<sc_logic> 	s00_axi_bready	;
	sc_core::sc_out< sc_dt::sc_logic > s00_axis_tready;
	sc_core::sc_in< sc_dt::sc_lv<24> >s00_axis_tdata;
	sc_core::sc_in< sc_dt::sc_logic > s00_axis_tlast;
	sc_core::sc_in< sc_dt::sc_logic > s00_axis_tvalid;
	sc_core::sc_in< sc_dt::sc_logic > m00_axis_tready;
	sc_core::sc_out< sc_dt::sc_lv<24> > m00_axis_tdata;
	sc_core::sc_out< sc_dt::sc_logic > m00_axis_tlast;
	sc_core::sc_out< sc_dt::sc_logic > m00_axis_tvalid;

protected:
    /*** MAIN METHOD ***/
	void hardware_function();

    /*** AUXILIARY FUNCTIONS ***/
    dcomp W(int N, int k, int n);
    dcomp WI(int N, int k, int n);

    /*** AUXILIARY VARIABLES ***/
	int arsize, N;
	typedef sc_dt::sc_fixed<24,2> num_t;
	num_t nums [2000];
	sc_uint<32> data_p[number_of_amplifications];
    sc_uint<7> adress_p[number_of_amplifications];
    int pp[number_of_amplifications];
    double p[number_of_amplifications];
    sc_uint<32> data_pr[number_of_boundaries];
    sc_uint<7> adress_pr[number_of_boundaries];
    int pr[number_of_boundaries];
};

#endif
