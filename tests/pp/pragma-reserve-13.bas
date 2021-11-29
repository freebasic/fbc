' TEST_MODE : COMPILE_ONLY_OK

'' !!!FIXME!!! to return an error
'' This test should be test mode = compile only fail
''
'' fbc returns a non-zero exit code to the shell
'' but the make file / test suite doesn't seem to get it
''
'' #cmdline "-w error"
''

#pragma reserve (extern) symbol

dim shared symbol as integer
