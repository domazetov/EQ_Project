#include "tb.hpp"
#include "software.hpp"
#include "hardware.hpp"

using namespace std;
using namespace sc_core;

tb::tb(sc_module_name name) :
  sc_module(name), soft(NULL), hard(NULL)
{
    soft = new software("software");
    hard = new hardware("m_sort_acc");
    soft->wr_port(*hard);
    soft->rd_port(*hard);
    soft->wr_lite_port(*hard);
    soft->reset(*hard);
}
void sc_trace(sc_core::sc_trace_file* tf, const tb& obj, const std::string& name)
{
  if (obj.hard != NULL)
	sc_trace(tf, *(obj.hard), name);
}
