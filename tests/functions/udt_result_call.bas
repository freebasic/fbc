# include "fbcunit.bi"

SUITE( fbc_tests.functions.udt_result_call )

	const TEST_B = 123
	const TEST_S = 12345
	const TEST_I = 12345678
	const TEST_L = 12345678901234
	const TEST_F = 1234.5
	const TEST_D = 1234567890.1

	type b_x
		x as byte
	end type 

	type s_x
		x as short
	end type 

	type i_x
		x as integer
	end type 

	type l_x
		x as longint
	end type 

	type f_x
		x as single
	end type 

	type d_x
		x as double
	end type 

	#macro gen_retproc( tp )
		function ret_##tp ( ) as tp##_x
			function = type( TEST_##tp )
		end function 
	#endmacro

	gen_retproc( b )
	gen_retproc( s )
	gen_retproc( i )
	gen_retproc( l )
	gen_retproc( f )
	gen_retproc( d )

	#macro gen_passproc( tp )
		sub pass_##tp ( byval v as tp##_x )
			CU_ASSERT_EQUAL( v.x, TEST_##tp )
		end sub
	#endmacro

	gen_passproc( b )
	gen_passproc( s )
	gen_passproc( i )
	gen_passproc( l )
	gen_passproc( f )
	gen_passproc( d )

	#macro do_test( tp )
		pass_##tp( ret_##tp( ) )
	#endmacro

	TEST( allTypes )
		do_test( b )
		do_test( s )
		do_test( i )
		do_test( l )
		do_test( f )
		do_test( d )
	END_TEST


END_SUITE
