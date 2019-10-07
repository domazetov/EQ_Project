#include "hardware.hpp"
#ifdef COSIM
#include "hardware_rtl.hpp"
#else
#include "hardware_calculate.hpp"
#endif

using namespace sc_core;
using namespace sc_dt;
using namespace std;

hardware::hardware(sc_module_name name) :
	sc_module(name),
	clk("m_clk", 100, SC_NS, 0.4, 5, SC_NS, true),
	rst("rst"),
	s00_axi_awaddr("s00_axi_awaddr"),
	s00_axi_awvalid("s00_axi_awvalid"),
	s00_axi_awready("s00_axi_awready"),
	s00_axi_wdata("s00_axi_wdata"),
	s00_axi_wvalid("s00_axi_wvalid"),
	s00_axi_wready("s00_axi_wready"),
	s00_axi_bvalid("s00_axi_bvalid"),
	s00_axi_bready("s00_axi_bready"),
	s00_axis_tready("s00_axis_tready"),
	s00_axis_tdata("s00_axis_tdata"),
	s00_axis_tlast("s00_axis_tlast"),
	s00_axis_tvalid("s00_axis_tvalid"),
	m00_axis_tready("m00_axis_tready"),
	m00_axis_tdata("m00_axis_tdata"),
	m00_axis_tlast("m00_axis_tlast"),
	m00_axis_tvalid("m00_axis_tvalid")
{
#ifndef COSIM
	core = new hardware_calculate("core");
	core->clk(clk);
	core->s00_axi_awaddr(s00_axi_awaddr);
	core->s00_axi_awvalid(s00_axi_awvalid);
	core->s00_axi_awready(s00_axi_awready);
	core->s00_axi_wdata(s00_axi_wdata);
	core->s00_axi_wvalid(s00_axi_wvalid);
	core->s00_axi_wready(s00_axi_wready);
	core->s00_axi_bvalid(s00_axi_bvalid);
	core->s00_axi_bready(s00_axi_bready);
	core->s00_axis_tready(s00_axis_tready);
	core->s00_axis_tdata(s00_axis_tdata);
	core->s00_axis_tlast(s00_axis_tlast);
	core->s00_axis_tvalid(s00_axis_tvalid);
	core->m00_axis_tready(m00_axis_tready);
	core->m00_axis_tdata(m00_axis_tdata);
	core->m00_axis_tlast(m00_axis_tlast);
	core->m00_axis_tvalid(m00_axis_tvalid);
    core->rst(rst);
#endif
}
void hardware::axil_write(const sc_uint<32> &data,const unsigned int &address)
{
	wait(clk.posedge_event());
	s00_axi_awaddr  = address*4;
	s00_axi_awvalid = SC_LOGIC_1;
	s00_axi_wdata   = data;
	s00_axi_wvalid  = SC_LOGIC_1;
	s00_axi_bready  = SC_LOGIC_1;

	while(1)
	{
		wait(clk.posedge_event());
		if(s00_axi_awready == SC_LOGIC_1)
			break;
	}

	s00_axi_awvalid = SC_LOGIC_0;
	s00_axi_awaddr	= 0;

	while(1)
	{
		wait(clk.posedge_event());
		if(s00_axi_wready == SC_LOGIC_1)
			break;
	}

	s00_axi_wdata = 0;
	s00_axi_wvalid = SC_LOGIC_0;

	while(1)
	{
		wait(clk.posedge_event());
		if(s00_axi_bvalid == SC_LOGIC_1)
			break;
	}

	s00_axi_bready = SC_LOGIC_0;
	cout<<"AXIL WRITE Transaction translated. \n";
}

void hardware::axis_write(const std::vector< sc_uint<24> > &data)
{
	m00_axis_tready.write(SC_LOGIC_0);
	s00_axis_tvalid.write(SC_LOGIC_0);
	s00_axis_tlast.write(SC_LOGIC_0);

	for (int i = 0; i != 10; ++i)
		wait(clk.negedge_event());

	for (size_t i = 0; i != data.size(); ++i)
	{
		s00_axis_tdata = (sc_lv<24>)data[i];
		s00_axis_tvalid = SC_LOGIC_1;
		if (i == (data.size()-1))
			s00_axis_tlast = SC_LOGIC_1;
		else
			s00_axis_tlast = SC_LOGIC_0;
		while(true)
		{
			wait(clk.negedge_event());

			if (s00_axis_tready == SC_LOGIC_1)
                break;
		}
	}

	cout << "Transaction translated.\n";
	s00_axis_tvalid = SC_LOGIC_0;
	s00_axis_tlast = SC_LOGIC_0;
}

void hardware::axis_read(std::vector< sc_uint<24> > &data)
{
    data.clear();
	wait(clk.negedge_event());
	m00_axis_tready = SC_LOGIC_1;

	while(1)
	{
		wait(clk.negedge_event());
		if (m00_axis_tvalid == SC_LOGIC_1)
		{
			data.push_back((sc_uint<24>)m00_axis_tdata);
			if (m00_axis_tlast == SC_LOGIC_1)
				break;
		}
	}

	wait(clk.negedge_event());
	m00_axis_tready = SC_LOGIC_0;
}

void hardware::reset_hardware()
{
    rst.write(false);

    for (int i = 0; i != 10; ++i)
        wait(clk.negedge_event());

    rst.write(true);

}

void sc_trace(sc_core::sc_trace_file* tf, const hardware& obj, const std::string& name)
{
	sc_trace(tf, obj.clk, name + ".clk");
	sc_trace(tf, obj.s00_axis_tready, name + ".s00_axis_tready");
	sc_trace(tf, obj.s00_axis_tdata, name + ".s00_axis_tdata");
	sc_trace(tf, obj.s00_axis_tlast, name + ".s00_axis_tlast");
	sc_trace(tf, obj.s00_axis_tvalid, name + ".s00_axis_tvalid");
	sc_trace(tf, obj.m00_axis_tready, name + ".m00_axis_tready");
	sc_trace(tf, obj.m00_axis_tdata, name + ".m00_axis_tdata");
	sc_trace(tf, obj.m00_axis_tlast, name + ".m00_axis_tlast");
	sc_trace(tf, obj.m00_axis_tvalid, name + ".m00_axis_tvalid");
    sc_trace(tf, obj.s00_axi_awaddr, name + ".s00_axi_awaddr");
    sc_trace(tf, obj.s00_axi_awvalid, name + ".s00_axi_awvalid");
    sc_trace(tf, obj.s00_axi_awready, name + ".s00_axi_awready");
    sc_trace(tf, obj.s00_axi_wdata, name + ".s00_axi_wdata");
    sc_trace(tf, obj.s00_axi_wvalid, name + ".s00_axi_wvalid");
    sc_trace(tf, obj.s00_axi_wready, name + ".s00_axi_wready");
    sc_trace(tf, obj.s00_axi_bvalid, name + ".s00_axi_bvalid");
    sc_trace(tf, obj.s00_axi_bready, name + ".s00_axi_bready");
}
