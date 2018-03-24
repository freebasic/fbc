#include "fbcunit.bi"

SUITE( fbc_tests.dim_.typeof_ )

	'' typeof() with dim
	TEST( typeof_dim )
	    
		var foo = cast(integer, 0)
		
		dim bar as typeof(foo)
		dim baz as typeof(foo) ptr = @bar
		
		*baz = &Hbaddf00d
		
		CU_ASSERT( bar = &Hbaddf00d )

	END_TEST
	
END_SUITE
