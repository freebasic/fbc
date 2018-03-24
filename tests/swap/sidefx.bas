#include "fbcunit.bi"

SUITE( fbc_tests.swap_.sidefx )

	dim shared as integer f1_calls
	private function f1( ) as integer ptr
		static as integer i = 1
		f1_calls += 1
		return @i
	end function

	dim shared as integer f2_calls
	private function f2( ) as integer ptr
		static as integer i = 1
		f2_calls += 1
		return @i
	end function

	'' SWAP on *function()
	TEST( Derefs )
		dim as integer a = 0

		CU_ASSERT( f1_calls = 0 )
		swap a, *f1( )
		CU_ASSERT( f1_calls = 1 )
		CU_ASSERT( a = 1 )

		swap *f1( ), a
		CU_ASSERT( f1_calls = 2 )
		CU_ASSERT( a = 0 )

		swap *f1( ), *f2( )
		CU_ASSERT( f1_calls = 3 )
		CU_ASSERT( f2_calls = 1 )
	END_TEST

	dim shared as integer returnIndex_calls
	private function returnIndex() as integer
		returnIndex_calls += 1
		return 1
	end function

	'' SWAP on array(function())
	TEST( Arrays )
		dim as integer array(0 to 1)
		CU_ASSERT( returnIndex_calls = 0 )
		swap array(returnIndex( )), array(returnIndex( ))
		CU_ASSERT( returnIndex_calls = 2 )
	END_TEST

	type Udt
		as integer a, b, c, d, e, f
	end type

	dim shared as integer returnUdt_calls
	private function returnUdt( ) as Udt
		returnUdt_calls += 1
		return type( 1, 2, 3, 4, 5, 6 )
	end function

	'' SWAP on function().field
	TEST( ResultUdtField )
		'' Should this be allowed in the first place?
		'' SWAP on function results doesn't make sense,
		''   func() = foo
		'' is disallowed too...

		dim as integer a = 0

		CU_ASSERT( returnUdt_calls = 0 )
		swap returnUdt( ).a, a
		CU_ASSERT( returnUdt_calls = 1 )
		CU_ASSERT( a = 1 )

		swap a, returnUdt( ).b
		CU_ASSERT( returnUdt_calls = 2 )
		CU_ASSERT( a = 2 )
	END_TEST

	TEST_GROUP( bitfields )
		type UDT
			a : 1 as integer
			b : 1 as integer
		end type

		dim shared as integer f1calls, f2calls
		dim shared globalx as UDT

		function f1( byval i as integer ) as integer
			f1calls += 1
			function = i
		end function

		function f2( ) byref as UDT
			f2calls += 1
			function = globalx
		end function

		TEST( default )
			dim array(0 to 0) as UDT
			array(0).a = 1
			CU_ASSERT( f1calls = 0 )
			CU_ASSERT( array(0).a = 1 )
			CU_ASSERT( array(0).b = 0 )

			swap array(f1( 0 )).a, array(f1( 0 )).b
			CU_ASSERT( f1calls = 2 )
			CU_ASSERT( array(0).a = 0 )
			CU_ASSERT( array(0).b = 1 )

			globalx.a = 1
			CU_ASSERT( f2calls = 0 )
			CU_ASSERT( globalx.a = 1 )
			CU_ASSERT( globalx.b = 0 )

			swap f2( ).a, f2( ).b
			CU_ASSERT( f2calls = 2 )
			CU_ASSERT( globalx.a = 0 )
			CU_ASSERT( globalx.b = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( stringConcat )
		dim shared as integer fcalls
		dim shared as string a, b

		function f( byval i as integer, byref s as string ) as integer
			if( i = 0 ) then
				CU_ASSERT( s = a + b )
			else
				CU_ASSERT( s = b + a )
			end if
			fcalls += 1
			function = i
		end function

		TEST( default )
			a = "a"
			b = "b"
			dim array(0 to 1) as integer => { 1, 2 }

			CU_ASSERT( fcalls = 0 )
			CU_ASSERT( array(0) = 1 )
			CU_ASSERT( array(1) = 2 )
			swap array(f( 0, a + b )), array(f( 1, b + a ))
			CU_ASSERT( fcalls = 2 )
			CU_ASSERT( array(0) = 2 )
			CU_ASSERT( array(1) = 1 )
		END_TEST
	END_TEST_GROUP

END_SUITE
