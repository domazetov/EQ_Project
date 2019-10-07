#include <systemc>
#include "tb.hpp"

using namespace sc_core;

int sc_main(int argc, char* argv[])
{
	tb tb("TB");

	sc_trace_file *wf = sc_create_vcd_trace_file("equalize");
	sc_trace(wf, tb, "clk");
	sc_start(40, SC_SEC);
	sc_close_vcd_trace_file(wf);

    return 0;
}
