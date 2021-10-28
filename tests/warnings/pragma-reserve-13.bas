'' This test should be moved to ../pp, with 
'' however, even though fbc returns a non-zero exit code to the shell,
'' the make file / test suite doesn't seem to get it

#cmdline "-w error"

#pragma reserve (extern) symbol

dim shared symbol as integer
