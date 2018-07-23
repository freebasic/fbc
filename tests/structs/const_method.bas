#include "fbcunit.bi"

SUITE( fbc_tests.structs.const_method )
	
	type foo
		
		__ as integer
		
		declare const sub bar( )
		declare sub bar2( )
	
	end type
	
	sub foo.bar( )
	end sub
	sub foo.bar2( )
	end sub
	
	TEST( all )
		dim as foo baz
		
		baz.bar( )
		baz.bar2( )
		
		dim as const foo baz2 = (3)
		
		baz2.bar( )
	END_TEST
	
END_SUITE
