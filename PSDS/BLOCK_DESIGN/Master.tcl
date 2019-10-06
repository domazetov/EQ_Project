variable dispScriptFile [file normalize [info script]]
proc getScriptDirectory {} {
    variable dispScriptFile
    set scriptFolder [file dirname $dispScriptFile]
    return $scriptFolder
}


cd [getScriptDirectory]
set ip_repo_path [getScriptDirectory]

source $ip_repo_path\/IPs\/design_1.tcl
