# include "fbcunit.bi"

SUITE( fbc_tests.dim_.static_const_init )

	sub s() 
	end sub

	function f1() as any ptr
		static f as any ptr = @s
		return f
	end function

	function f2() as any ptr
		static f as any ptr = procptr( s )
		return f
	end function

	function f3() as any ptr
		static f as any ptr = cptr( any ptr, @s )
		return f
	end function

	function f4() as any ptr
		static f as any ptr = cptr( sub() ptr, @s )
		return f
	end function

	function f5() as uinteger
		'' must be same size as sizeof(any ptr)
		static f as uinteger = cptr( uinteger, @s )
		return f
	end function

	TEST( PROCPTR_ )
		var f = @s

		'' CUNSG() returns a uinteger and will preserve size of pointers

		CU_ASSERT( cunsg( f ) = cunsg( f1() ) )
		CU_ASSERT( cunsg( f ) = cunsg( f2() ) )
		CU_ASSERT( cunsg( f ) = cunsg( f3() ) )
		CU_ASSERT( cunsg( f ) = cunsg( f4() ) )
		CU_ASSERT( cunsg( f ) = cunsg( f5() ) )

	END_TEST

END_SUITE
