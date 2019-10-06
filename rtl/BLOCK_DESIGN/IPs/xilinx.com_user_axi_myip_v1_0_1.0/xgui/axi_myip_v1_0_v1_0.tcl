# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AMPLIFICATION_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BOUNDARIES_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXIL_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXIL_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PACKAGE_LENGTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.AMPLIFICATION_WIDTH { PARAM_VALUE.AMPLIFICATION_WIDTH } {
	# Procedure called to update AMPLIFICATION_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AMPLIFICATION_WIDTH { PARAM_VALUE.AMPLIFICATION_WIDTH } {
	# Procedure called to validate AMPLIFICATION_WIDTH
	return true
}

proc update_PARAM_VALUE.BOUNDARIES_WIDTH { PARAM_VALUE.BOUNDARIES_WIDTH } {
	# Procedure called to update BOUNDARIES_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BOUNDARIES_WIDTH { PARAM_VALUE.BOUNDARIES_WIDTH } {
	# Procedure called to validate BOUNDARIES_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXIL_ADDR_WIDTH { PARAM_VALUE.C_S00_AXIL_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXIL_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXIL_ADDR_WIDTH { PARAM_VALUE.C_S00_AXIL_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXIL_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXIL_DATA_WIDTH { PARAM_VALUE.C_S00_AXIL_DATA_WIDTH } {
	# Procedure called to update C_S00_AXIL_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXIL_DATA_WIDTH { PARAM_VALUE.C_S00_AXIL_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXIL_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.PACKAGE_LENGTH { PARAM_VALUE.PACKAGE_LENGTH } {
	# Procedure called to update PACKAGE_LENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PACKAGE_LENGTH { PARAM_VALUE.PACKAGE_LENGTH } {
	# Procedure called to validate PACKAGE_LENGTH
	return true
}


proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.AMPLIFICATION_WIDTH { MODELPARAM_VALUE.AMPLIFICATION_WIDTH PARAM_VALUE.AMPLIFICATION_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AMPLIFICATION_WIDTH}] ${MODELPARAM_VALUE.AMPLIFICATION_WIDTH}
}

proc update_MODELPARAM_VALUE.BOUNDARIES_WIDTH { MODELPARAM_VALUE.BOUNDARIES_WIDTH PARAM_VALUE.BOUNDARIES_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BOUNDARIES_WIDTH}] ${MODELPARAM_VALUE.BOUNDARIES_WIDTH}
}

proc update_MODELPARAM_VALUE.PACKAGE_LENGTH { MODELPARAM_VALUE.PACKAGE_LENGTH PARAM_VALUE.PACKAGE_LENGTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PACKAGE_LENGTH}] ${MODELPARAM_VALUE.PACKAGE_LENGTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXIL_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXIL_DATA_WIDTH PARAM_VALUE.C_S00_AXIL_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXIL_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXIL_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXIL_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXIL_ADDR_WIDTH PARAM_VALUE.C_S00_AXIL_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXIL_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXIL_ADDR_WIDTH}
}

