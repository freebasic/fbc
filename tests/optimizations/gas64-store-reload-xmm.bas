#include "fbcunit.bi"

'' gas64: a float variable which is stored from an xmm register and loaded
'' right after into another xmm register is copied from register to register
'' by the peephole optimizer. For SINGLE that emitted 'movd xmm, xmm', which
'' does not exist: the assembler failed with "operand type mismatch for `movd'"

SUITE( fbc_tests.optimizations.gas64_store_reload_xmm )

	private function addOneS( byval a as single ) as single
		function = a + 1
	end function

	private function addOneD( byval a as double ) as double
		function = a + 1
	end function

	TEST( singleStoredThenCompared )
		dim as single x, y

		x = addOneS( 1 ) * 1.5
		if( x > y ) then
			y = x
		end if
		CU_ASSERT( x = 3 )
		CU_ASSERT( y = 3 )

		x = addOneS( 0 ) * 1.5
		if( x < y ) then
			y = x
		end if
		CU_ASSERT( x = 1.5 )
		CU_ASSERT( y = 1.5 )
	END_TEST

	TEST( doubleStoredThenCompared )
		dim as double x, y

		x = addOneD( 1 ) * 1.5
		if( x > y ) then
			y = x
		end if
		CU_ASSERT( x = 3 )
		CU_ASSERT( y = 3 )

		x = addOneD( 0 ) * 1.5
		if( x < y ) then
			y = x
		end if
		CU_ASSERT( x = 1.5 )
		CU_ASSERT( y = 1.5 )
	END_TEST

END_SUITE
