#include "fbcunit.bi"

'' test constant index multiplier

SUITE( fbc_tests.optimizations.const_idx_2 )

	type T
		member as integer
		a as integer
		b as integer
		c as integer
		d as integer
		f as integer
		n as integer
	end type

type tudt
	a as integer
	b as integer
	useme as integer = 4
End Type

	dim shared as tudt udt

	dim shared as const zstring ptr A_ARRAY(0 to 4) = _
		{ @"A", @"B", @"C", @"D", @"E" }

	dim shared B_ARRAY( 0 to 3 ) as T = _
		{ _
			( 0, 0, 0, 0, 0, 0, 0 ), _
			( 1, 0, 0, 0, 0, 0, 0 ), _
			( 2, 0, 0, 0, 0, 0, 0 ), _
			( 3, 0, 0, 0, 0, 0, 0 ) _
		}

	private function IndexingTest( byval index as integer ) as string
		dim as string s
		select case index
		case -1,-2,-3
		case 0
			s = *A_ARRAY(B_ARRAY(iif((index and 1)=0,2,3)).member)
		case 4
			s = *A_ARRAY(udt.useme)
		case else
			s = *A_ARRAY(index)
		end select
		function = s
	end function

	TEST( IndexOfIndex )
		dim as string s
		s = IndexingTest( 0 )
		CU_ASSERT( s = "C" )

		s = IndexingTest( 1 )
		CU_ASSERT( s = "B" )

		s = IndexingTest( 2 )
		CU_ASSERT( s = "C" )

		s = IndexingTest( 3 )
		CU_ASSERT( s = "D" )

		s = IndexingTest( 4 )
		CU_ASSERT( s = "E" )

	END_TEST

END_SUITE
