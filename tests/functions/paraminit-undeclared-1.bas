' TEST_MODE : COMPILE_ONLY_FAIL

type DtorUdt
	i as integer
	declare destructor( )
end type

'' DtorUdt() can't be used as CTORCALL expression since there is no ctor
sub test( byval x as DtorUdt = DtorUdt( ) )
end sub

test( )
