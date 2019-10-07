// Cycle accurate model of equalizer accelerator

#ifndef _HARDWARE_HPP_
#define _HARDWARE_HPP_

#include <systemc.h>
#include "communication.hpp"

using namespace sc_dt;

class hardware_calculate;

class hardware :
	public sc_core::sc_channel,
	public axil_master_if,
	public axis_master_if,
	public axis_slave_if,
	public reset_if
{
public:
	SC_HAS_PROCESS(hardware);

	hardware(sc_core::sc_module_name name);

	void axil_write(const sc_uint<32> &data,const unsigned int &address);
	void axis_write(const std::vector< sc_uint<24> >& data);
	void axis_read(std::vector< sc_uint<24> >& data);
	void reset_hardware();

	sc_core::sc_clock clk;
	sc_core::sc_signal< bool > rst;
    sc_core::sc_signal< sc_dt::sc_lv<7> > s00_axi_awaddr;
    sc_core::sc_signal< sc_dt::sc_logic >s00_axi_awvalid;
    sc_core::sc_signal< sc_dt::sc_logic > s00_axi_awready;
    sc_core::sc_signal< sc_dt::sc_lv<32> > s00_axi_wdata;
    sc_core::sc_signal< sc_dt::sc_logic > s00_axi_wvalid;
    sc_core::sc_signal< sc_dt::sc_logic > s00_axi_wready;
    sc_core::sc_signal< sc_dt::sc_logic > s00_axi_bvalid;
    sc_core::sc_signal< sc_dt::sc_logic > s00_axi_bready;
    sc_core::sc_signal< sc_dt::sc_logic > s00_axis_tready;
	sc_core::sc_signal< sc_dt::sc_lv<24> > s00_axis_tdata;
	sc_core::sc_signal< sc_dt::sc_logic > s00_axis_tlast;
	sc_core::sc_signal< sc_dt::sc_logic > s00_axis_tvalid;
	sc_core::sc_signal< sc_dt::sc_logic > m00_axis_tready;
	sc_core::sc_signal< sc_dt::sc_lv<24> > m00_axis_tdata;
	sc_core::sc_signal< sc_dt::sc_logic > m00_axis_tlast;
	sc_core::sc_signal< sc_dt::sc_logic > m00_axis_tvalid;

	friend void sc_trace(sc_core::sc_trace_file*, const hardware&, const std::string& name);
protected:
	hardware_calculate* core;
};

#endif
