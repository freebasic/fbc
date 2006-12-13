' TEST_MODE : COMPILE_AND_RUN_OK

type foo

	as uinteger i
	as ubyte b
	
end type

type bar
    
    as foo f
	as ushort s
	as ubyte b
	
end type

type baz
    
	as ubyte b
	as ubyte b2
    as bar b3
	
end type

sub test_1 cdecl ( )
	assert( len( foo ) = 5 )
end sub

sub test_2 cdecl ( )
	assert( len( bar ) = 8 )
end sub

sub test_3 cdecl ( )
	assert( len( baz ) = 10 )
end sub

test_1( )
test_2( )
test_3( )

