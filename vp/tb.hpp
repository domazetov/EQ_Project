#ifndef _TB_HPP_
#define _TB_HPP_

#include <systemc>

class software;
class hardware;

SC_MODULE(tb)
{
public:
	tb(sc_core::sc_module_name);

	friend void sc_trace(sc_core::sc_trace_file*, const tb&, const std::string& name);

protected:
	software* soft;
	hardware* hard;
};

#endif
