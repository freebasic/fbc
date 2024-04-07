' TEST_MODE : COMPILE_ONLY_FAIL

'' https://sourceforge.net/p/fbc/bugs/817/

type UDT1
	__ as integer
end type

type UDT2
	__ as integer
end type

sub proc( a() as UDT1 )
end sub

dim x(1 to 10) as UDT2

proc( x() )

