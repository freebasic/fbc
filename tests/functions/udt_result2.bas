# include "fbcunit.bi"

SUITE( fbc_tests.functions.udt_result2 )

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

	#macro do_arraytest( tp )
		tp##_array(0) = ret_##tp( )
		CU_ASSERT( tp##_array(0).x = TEST_##tp )
	#endmacro

	TEST( array_ )
		dim as b_x b_array( 0 to 1 ) = any
		dim as s_x s_array( 0 to 1 ) = any
		dim as i_x i_array( 0 to 1 ) = any
		dim as l_x l_array( 0 to 1 ) = any
		dim as f_x f_array( 0 to 1 ) = any
		dim as d_x d_array( 0 to 1 ) = any

		do_arraytest( b )
		do_arraytest( s )
		do_arraytest( i )
		do_arraytest( l )
		do_arraytest( f )
		do_arraytest( d )
		
	END_TEST

	#macro do_scalartest( tp )
		tp = ret_##tp( )
		CU_ASSERT( tp.x = TEST_##tp )
	#endmacro

	TEST( scalar )
		dim as b_x b = any
		dim as s_x s = any
		dim as i_x i = any
		dim as l_x l = any
		dim as f_x f = any
		dim as d_x d = any

		do_scalartest( b )
		do_scalartest( s )
		do_scalartest( i )
		do_scalartest( l )
		do_scalartest( f )
		do_scalartest( d )
		
	END_TEST

END_SUITE
