' TEST_MODE : COMPILE_ONLY_OK

'' see bug https://sourceforge.net/p/fbc/bugs/944/
'' #944 Array descriptors are defined more than once (gcc backend)

/'
fbc       gas32    gas64    gcc32    gcc64
-------  -------  -------  -------  -------
1.10.1     ok       ok       ok       ok
1.10.0     ok       ok       ok       ok
1.09.0     ok       ok       ok       ok
1.08.1     ok       ok      fail     fail
1.07.3     ok       ok      fail     fail
1.06.0     ok       n/a     fail     fail
1.05.0     ok       n/a     fail     fail
'/

'' test the bug fix in the global scope

dim shared A(0 to ...) as zstring ptr => { @"" }
dim shared B(0 to ...) as zstring ptr => { @"" }

sub proc( arrray() as zstring ptr )
end sub

proc( A() )
proc( B() )
