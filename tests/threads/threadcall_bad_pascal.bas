' TEST_MODE : COMPILE_ONLY_FAIL

dim shared Bad_Result as integer = 0

sub BadPascal pascal( )
    Bad_Result = 1
end sub

Dim t1 As Any Ptr
t1 = threadcall BadPascal( )
threadwait t1
