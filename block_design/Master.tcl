#process for getting script file directory
variable dispScriptFile [file normalize [info script]]
proc getScriptDirectory {} {
    variable dispScriptFile
    set scriptFolder [file dirname $dispScriptFile]
    return $scriptFolder
}

#change working directory to script file directory
cd [getScriptDirectory]
#set ip_repo_path to script dir
set ip_repo_path [getScriptDirectory]

# PACKAGE Conv32to48
source $ip_repo_path\/Conv32to48\/src\/script\/conv32to48.tcl

# PACKAGE Conv48to32
source $ip_repo_path\/Conv48to32\/src\/script\/conv48to32.tcl

# PACKAGE Data_helper
source $ip_repo_path\/Data_helper\/src\/script\/data_helper.tcl

# PACKAGE Data_mover_const
source $ip_repo_path\/Data_mover_const\/src\/script\/data_mover_const.tcl

# PACKAGE FFT_init
source $ip_repo_path\/FFT_init\/src\/script\/fft_init.tcl

# PACKAGE Equalizer
source $ip_repo_path\/Equalizer\/src\/script\/Equalizer.tcl

# PACKAGE TOP
source $ip_repo_path\/Top\/Top.tcl
