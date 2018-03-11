#include "fbcunit.bi"

SUITE( fbc_tests.dim_.extern_redeclarations )

	'' Duplicate EXTERNs like this should be allowed,
	'' as long as there is no conflict. (just like #defines or typedefs)

	extern a as integer
	extern a as integer
	dim a as integer

	extern b() as integer
	extern b() as integer
	dim b() as integer

	extern c(1 to 2) as integer
	extern c(1 to 2) as integer
	dim c(1 to 2) as integer

	TEST( testproc )
		CU_ASSERT( a = 0 )
		CU_ASSERT( (ubound( b ) - lbound( b ) + 1) = 0 )
		CU_ASSERT( lbound( c ) = 1 )
		CU_ASSERT( ubound( c ) = 2 )
	END_TEST

END_SUITE
