# include "fbcunit.bi"

SUITE( fbc_tests.functions.return_non_trivial )

	'' UDTs can become non-trivial as a result of containing a non-trivial
	'' field. The compiler must be careful to take this into account when
	'' determining how to return an UDT from a function (in registers or
	'' on stack).

	dim shared dtors as integer

	type A
		i as integer
		declare destructor( )
	end type

	destructor A()
		dtors += 1
	end destructor

	type B
		a as A
	end type

	function f( ) as B
		function = type( (123) )
	end function

	TEST( nonTrivialDueToField )
		CU_ASSERT( dtors = 0 )
		CU_ASSERT( f().a.i = 123 )
		CU_ASSERT( dtors = 2 )
	END_TEST

END_SUITE
