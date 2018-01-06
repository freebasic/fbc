#include once "fbcunit.bi"

'' test using a macro to create tests

SUITE( many_tests )

#macro create1( name_ )
	TEST( name_ )
		CU_ASSERT( true )
	END_TEST
#endmacro

#macro create10( prefix )

	create1( prefix##0 )
	create1( prefix##1 )
	create1( prefix##2 )
	create1( prefix##3 )
	create1( prefix##4 )
	create1( prefix##5 )
	create1( prefix##6 )
	create1( prefix##7 )
	create1( prefix##8 )
	create1( prefix##9 )

#endmacro

#macro create_30_tests( prefix_ )

	create10( prefix_##1 )
	create10( prefix_##2 )
	create10( prefix_##3 )

#endmacro

create_30_tests( many )

END_SUITE
