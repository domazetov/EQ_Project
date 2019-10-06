variable dispScriptFile [file normalize [info script]]
proc getScriptDirectory {} {
    variable dispScriptFile
    set scriptFolder [file dirname $dispScriptFile]
    return $scriptFolder
}


cd [getScriptDirectory]
set ip_repo_path [getScriptDirectory]

source $ip_repo_path\/project_1.srcs\/project.tcl
