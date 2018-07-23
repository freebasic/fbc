#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_concat )

	type foo
		as integer value
		declare operator cast() as string
	end type

	operator foo.cast( ) as string
		return str( value )
	end operator

	operator & ( byref l as foo, byref r as foo ) as string
		return str( l ) & "|" & str( r )
	end operator

	TEST( fooConcat )
		dim as foo l = ( 1 ) , r = ( 2 ) 
		
		CU_ASSERT_EQUAL( l & r, "1|2" )
	END_TEST

	type bar
		as string strdata
		declare constructor( byval s as zstring ptr )
		declare operator cast() as string
		declare operator &= ( byref r as bar )
	end type

	constructor bar( byval s as zstring ptr )
		strdata = *s
	end constructor

	operator bar.cast( ) as string
		return strdata
	end operator

	operator bar.&= ( byref r as bar )
		strdata &= "|" & r.strdata
	end operator

	TEST( barConcat )
		dim as bar l = bar( "abc" ), r = bar( "def" )
		
		l &= r

		CU_ASSERT_EQUAL( l, "abc|def" )
	END_TEST

END_SUITE
