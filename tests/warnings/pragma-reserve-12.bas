'' This test should be moved to ../pp, and use #cmdline "-w error" 
'' however, even though fbc returns a non-zero exit code to the shell,
'' the make file / test suite doesn't seem to get it

'' #cmdline "-w error"

#pragma reserve (extern) symbol

sub symbol
end sub
