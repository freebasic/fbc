' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = FALSE then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

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
	assert( len( foo ) = 2 )
end sub

sub test_2 cdecl ( )
	assert( len( bar ) = 2+2 )
end sub

sub test_3 cdecl ( )
	assert( len( baz ) = 2+2+2 )
end sub

test_1( )
test_2( )
test_3( )

