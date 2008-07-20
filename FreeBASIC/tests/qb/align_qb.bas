' TEST_MODE : COMPILE_AND_RUN_OK

type foo

	as integer i
	
end type

type bar
    
    as foo f
	as integer s
	
end type

type baz
    
	as integer b
    as bar b3
	
end type

sub test_1 cdecl ( )
	__ASSERT( __sizeof( foo ) = 2 )
end sub

sub test_2 cdecl ( )
	__ASSERT( __sizeof( bar ) = 2+2 )
end sub

sub test_3 cdecl ( )
	__ASSERT( __sizeof( baz ) = 2+2+2 )
end sub

test_1( )
test_2( )
test_3( )

