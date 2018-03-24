# include "fbcunit.bi"

SUITE( fbc_tests.functions.str_paramrecursion )

	'':::::
	function toupperz( byval s as string ) as string

		return ucase( s )

	end function

	'':::::
	function tolowerz( byval s as string ) as string

		return lcase( s )

	end function

	'':::::
	function touppers( byref s as string ) as string

		return ucase( s )

	end function

	'':::::
	function tolowers( byref s as string ) as string

		return lcase( s )

	end function

	'':::::
	function concatz( byval s1 as string, byval s2 as string ) as string

		return s1 + s2

	end function

	TEST( default )

		dim s as string
		dim z as zstring * 3+1
		dim r as string
		
		s = "AbC"
		
		z = "dEf"
			
		r = toupperz( tolowerz( toupperz( tolowerz( s ) ) ) )
		CU_ASSERT( r = "ABC" )
		
		r = tolowers( touppers( tolowers( touppers( s ) ) ) )
		CU_ASSERT( r = "abc" )
		
		r = concatz( toupperz( s ), tolowers( z ) )
		CU_ASSERT( r = "ABCdef" )

	END_TEST

END_SUITE
