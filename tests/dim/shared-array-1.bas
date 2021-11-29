' TEST_MODE : COMPILE_ONLY_OK

'' see bug https://sourceforge.net/p/fbc/bugs/944/
'' #944 Array descriptors are defined more than once (gcc backend)

'' test the bug fix in the global scope

dim shared A(0 to ...) as zstring ptr => { @"" }
dim shared B(0 to ...) as zstring ptr => { @"" }

sub proc( arrray() as zstring ptr )
end sub

proc( A() )
proc( B() )
