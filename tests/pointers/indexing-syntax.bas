#include "fbcunit.bi"

SUITE( fbc_tests.pointers.indexing_syntax )

	type UDT
		as integer a, b, c
	end type

	private function f1( i as integer ) as integer
		function = i + 1
	end function

	TEST( varPtrIndexing )
		dim i as integer = 123, s as string = "abc"
		dim x as UDT = ( 4, 5, 6 )

		CU_ASSERT( varptr( i )[0] = 123 )
		CU_ASSERT( varptr( x )->a = 4 )
		CU_ASSERT( varptr( x )->b = 5 )
		CU_ASSERT( varptr( x )->c = 6 )
		CU_ASSERT( procptr( f1 )( 2 ) = 3 )
		CU_ASSERT( strptr( s )[0] = "abc" )
		CU_ASSERT( sadd( s )[1] = "bc" )

		dim idata(0 to 1) as integer = { &hAABBCCDD, &h11223344 }
		dim pi as integer ptr = @idata(0)

		'' @pi[1] should still be @(pi[1]) (address of second pointed-to element),
		'' instead of (@pi)[1] (take address of pointer itself, then index that).
		CU_ASSERT( @pi[0] = @(pi[0]) )
		CU_ASSERT( @pi[1] = @(pi[1]) )
		CU_ASSERT( *( @pi[0] ) = &hAABBCCDD )
		CU_ASSERT( *( @pi[1] ) = &h11223344 )
	END_TEST

END_SUITE
