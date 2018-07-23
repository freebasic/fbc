# include "fbcunit.bi"

SUITE( fbc_tests.functions.udt_result_access4 )

	dim shared as integer dtor_cnt = 0

	type tbar
		declare destructor
		int1 as integer = 1234
		int2 as integer = -1234
	end type

	destructor tbar
		dtor_cnt += 1
	end destructor

	type tfoo
		declare constructor ( )
		declare constructor ( byref as tbar ) 
		declare function bar ( ) as tbar
	private:	
		p_bar as tbar
	end type

	constructor tfoo ( )
		CU_ASSERT_EQUAL( dtor_cnt, 0 )
	end constructor

	constructor tfoo ( byref rhs as tbar )
		CU_ASSERT_EQUAL( dtor_cnt, 0 )
		p_bar = rhs
	end constructor

	function tfoo.bar ( ) as tbar
		return p_bar
	end function

	TEST( testproc )
		dim as tfoo f1
		dim as tfoo f2 = ( f1.bar() )
	END_TEST

END_SUITE
