# include "fbcunit.bi"

#define SB1 -128
#define SB2 127

#define UB1 0
#define UB2 255

#define SS1 -32768
#define SS2 32767

#define US1 0
#define US2 65535

#define SL1 -2147483648
#define SL2 2147483647

#define UL1 0
#define UL2 4294967295

#define SLL1 (-9223372036854775807ll-1ll)
#define SLL2 9223372036854775807ll

#define ULL1 0
#define ULl2 18446744073709551615ull

#if sizeof(integer) = 4
	#define UI1 UL1
	#define UI2 UL2
	#define SI1 SL1
	#define SI2 SL2
#else
	#define UI1 ULL1
	#define UI2 ULL2
	#define SI1 SLL1
	#define SI2 SLL2
#endif


SUITE( fbc_tests.functions.va_cva_api )

	'' cva_start(), cva_arg(), cva_end()

	sub f_test_start cdecl( byval n as integer, ... )
		
		dim as cva_list x = any

		cva_start( x, n )

		for i as integer = 1 to n
			dim a as integer = cva_arg( x, integer )
			CU_ASSERT( a = i * 100 )
		next i

		cva_end( x )

	end sub

	TEST( start )
		f_test_start( 10, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 )
	END_TEST

	'' cva_start(), cva_arg(), cva_copy(), cva_end()

	sub f_test_copy cdecl( byval n as integer, ... )
		
		dim as cva_list x1 = any, x2 = any, y1 = any, y2 = any

		cva_start( x1, n )
		cva_copy( x2, x1 )
		cva_copy( y1, x1 )
		cva_copy( y2, x1 )

		for i as integer = 1 to n
			
			dim a1 as integer = cva_arg( x1, integer )
			dim a2 as integer = cva_arg( x2, integer )

			CU_ASSERT( a1 = i * 100 )
			CU_ASSERT( a2 = i * 100 )

		next

		cva_end( x1 )
		cva_end( x2 )

		for i as integer = 1 to n
			
			dim a1 as integer = cva_arg( y1, integer )
			dim a2 as integer = cva_arg( y2, integer )

			CU_ASSERT( a1 = i * 100 )
			CU_ASSERT( a2 = i * 100 )

		next

		cva_end( y1 )
		cva_end( y2 )

	end sub

	TEST( copy )
		f_test_copy( 10, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 )
	END_TEST

	sub f_test_list2 cdecl( byval n as integer, byval args as cva_list )
		
		dim as cva_list x = any

		cva_copy( x, args )

		for i as integer = 1 to n
			dim a as integer = cva_arg( x, integer )
			CU_ASSERT( a = i * 100 )
		next i

		cva_end( x )

	end sub

	sub f_test_list cdecl( byval n as integer, ... )
		
		dim as cva_list x = any

		cva_start( x, n )

		f_test_list2( n, x )

		for i as integer = 1 to n
			dim a as integer = cva_arg( x, integer )
			CU_ASSERT( a = i * 100 )
		next i

		cva_end( x )

	end sub

	TEST( list )
		f_test_list( 10, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 )
	END_TEST

	
	'' cva_arg()
	''
	'' depending on the platform, up to 6 arguments will be passed in registers
	'' to make sure we are looking at both registers and stack, we pass 10
	'' arguments of each type

	#macro DEFN_BASICTYPE( T, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8, ARG9, ARG10 )

		sub f_test_arg_##t cdecl( byval n as integer, ... )
			
			dim as cva_list x = any

			cva_start( x, n )

			'' ignore n, there is always 10 arguments

			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG1 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG2 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG3 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG4 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG5 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG6 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG7 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG8 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG9 )
			CU_ASSERT_EQUAL( cva_arg( x, T ), ARG10 )

			cva_end( x )

		end sub
	#endmacro

	DEFN_BASICTYPE( ubyte , 1,   0, SB2, UB1, UB2, 0,   0, SB2, UB1, UB2 )
	DEFN_BASICTYPE( byte  , 2, SB1, SB2, UB1,   0, 0, SB1, SB2, UB1,   0 )

	DEFN_BASICTYPE( ushort, 3,   0, SS2, US1, US2, 0,   0, SS2, US1, US2 )
	DEFN_BASICTYPE( short , 4, SS1, SS2, US1,   0, 0, SS1, SS2, US1,   0 )

	DEFN_BASICTYPE( ulong , 5,   0, SL2, UL1, UL2, 0,   0, SL2, UL1, UL2 )
	DEFN_BASICTYPE( long  , 6, SL1, SL2, UL1,   0, 0, SL1, SL2, UL1,   0 )

	DEFN_BASICTYPE( uinteger ,  7,    0,  SI2,  UI1,  UI2, 0,    0,  SI2,  UI1,  UI2 )
	DEFN_BASICTYPE( integer  ,  8,  SI1,  SI2,  UI1,    0, 0,  SI1,  SI2,  UI1,    0 )

	DEFN_BASICTYPE( ulongint ,  9,    0, SLL2, ULL1, ULL2, 0,    0, SLL2, ULL1, ULL2 )
	DEFN_BASICTYPE( longint  , 10, SLL1, SLL2, ULL1,    0, 0, SLL1, SLL2, ULL1,    0 )

	#macro TEST_BASICTYPE( T, CV, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8, ARG9, ARG10 )
		f_test_arg_##T ( 10, CV(ARG1), CV(ARG2), CV(ARG3), CV(ARG4), CV(ARG5), CV(ARG6), CV(ARG7), CV(ARG8), CV(ARG9), CV(ARG10) )
	#endmacro


	TEST( basic_types )
		TEST_BASICTYPE ( ubyte, cubyte, 1,   0, SB2, UB1, UB2, 0,   0, SB2, UB1, UB2 )
		TEST_BASICTYPE ( byte , cbyte , 2, SB1, SB2, UB1,   0, 0, SB1, SB2, UB1,   0 )

		TEST_BASICTYPE ( ushort, cushort, 3,   0, SS2, US1, US2, 0,   0, SS2, US1, US2 )
		TEST_BASICTYPE ( short , cshort , 4, SS1, SS2, US1,   0, 0, SS1, SS2, US1,   0 )

		TEST_BASICTYPE ( ulong, culng, 5,   0, SL2, UL1, UL2, 0,   0, SL2, UL1, UL2 )
		TEST_BASICTYPE  ( long , clng, 6, SL1, SL2, UL1,   0, 0, SL1, SL2, UL1,   0 )

		TEST_BASICTYPE ( uinteger, cuint, 7,    0,  SI2,  UI1,  UI2, 0,    0,  SI2,  UI1,  UI2 )
		TEST_BASICTYPE ( integer , cint , 8,  SI1,  SI2,  UI1,    0, 0,  SI1,  SI2,  UI1,    0 )

		TEST_BASICTYPE ( ulongint, culngint, 9,    0, SLL2, ULL1, ULL2, 0,    0, SLL2, ULL1, ULL2 )
		TEST_BASICTYPE ( longint , clngint , 10, SLL1, SLL2, ULL1,    0, 0, SLL1, SLL2, ULL1,    0 )
	END_TEST


	'' byval/byref/ptr arguments

	#macro sum_cva_list_args( expr )

		'' iterate using a copy
		dim x as cva_list
		cva_copy( x, expr )
		dim d as integer = 0
		for i as integer = 1 to n
			d += cva_arg( x, integer )
		next
		cva_end( x )

		'' iterate using argument passed
		dim c as integer = 0
		for i as integer = 1 to n
			c += cva_arg( expr, integer )
		next
		CU_ASSERT( c = d )

	#endmacro

	function f_arg_byval ( total as integer, byval n as integer, byval args as cva_list ) as integer
		sum_cva_list_args( args )
		function = c
	end function

	function f_arg_byref ( total as integer, byval n as integer, byref args as cva_list ) as integer
		sum_cva_list_args( args )
		function = c
	end function

	function f_arg_byref_ptr ( total as integer, byval n as integer, byref args as cva_list ptr ) as integer
		sum_cva_list_args( *args )
		function = c
	end function

	function f_arg_ptr ( total as integer, byval n as integer, byval args as cva_list ptr ) as integer
		sum_cva_list_args( *args )
		function = c
	end function

	function f_arg_ptr_ptr ( total as integer, byval n as integer, byval args as cva_list ptr ptr ) as integer
		sum_cva_list_args( **args )
		function = c
	end function

	sub argument_tests cdecl( total as integer, byval n as integer, ... )
		
		dim as cva_list args

		'' var passed byval
		scope
			cva_start( args, n )
			CU_ASSERT( f_arg_byval( total, n, args ) = total )
			cva_end( args )
		end scope

		'' byref var passed byval
		scope
			dim byref as cva_list r_args = args
			cva_start( r_args, n )
			CU_ASSERT( f_arg_byval( total, n, r_args ) = total )
			cva_end( r_args )
		end scope
		
		'' var passed byref
		scope
			cva_start( args, n )
			CU_ASSERT( f_arg_byref( total, n, args ) = total )
			cva_end( args )
		end scope

		'' byref var passed byref
		scope
			dim byref as cva_list r_args = args
			cva_start( r_args, n )
			CU_ASSERT( f_arg_byref( total, n, r_args ) = total )
			cva_end( r_args )
		end scope

		'' pointer var passed byref
		scope
			dim as cva_list ptr pargs = @args
			cva_start( *pargs, n )
			CU_ASSERT( f_arg_byref_ptr( total, n, pargs ) = total )
			cva_end( *pargs )
		end scope

		'' pointer var passed byval
		scope
			dim as cva_list ptr pargs = @args
			cva_start( *pargs, n )
			CU_ASSERT( f_arg_ptr( total, n, pargs ) = total )
			cva_end( *pargs )
		end scope

		'' var passed by pointer
		scope
			cva_start( args, n )
			CU_ASSERT( f_arg_ptr( total, n, @args ) = total )
			cva_end( args )
		end scope

		'' multi indirection pointer
		scope
			dim as cva_list ptr pargs = @args
			dim as cva_list ptr ptr ppargs = @pargs
			cva_start( **ppargs, n )
			CU_ASSERT( f_arg_ptr( total, n, *ppargs ) = total )
			cva_end( **ppargs )
		end scope

		'' multi indirection pointer
		scope
			dim as cva_list ptr pargs = @args
			cva_start( *pargs, n )
			CU_ASSERT( f_arg_ptr_ptr( total, n, @pargs ) = total )
			cva_end( *pargs )
		end scope

		'' multi indirection pointer
		scope
			dim as cva_list ptr pargs = @args
			dim as cva_list ptr ptr ppargs = @pargs
			cva_start( **ppargs, n )
			CU_ASSERT( f_arg_ptr_ptr( total, n, ppargs ) = total )
			cva_end( **ppargs )
		end scope

	end sub

	TEST( arguments )
		argument_tests( 4321, 4, 4000, 300, 20, 1 )
	END_TEST

	type udt_vararg
		f1 as cva_list
		f2 as cva_list
	end type

	sub complex_tests cdecl( total as integer, byval n as integer, ... )
		dim u as udt_vararg

		'' cva_list is udt field
		scope
			cva_start( u.f1, n )
			sum_cva_list_args( u.f1 )
			cva_end( u.f1 )
		end scope

		scope
			cva_start( u.f2, n )
			sum_cva_list_args( u.f2 )
			cva_end( u.f2 )
		end scope

		'' cva_list is array element
		dim a(1 to 2) as cva_list

		scope
			cva_start( a(1), n )
			sum_cva_list_args( a(1) )
			cva_end( a(1) )
		end scope

		scope
			cva_start( a(2), n )
			sum_cva_list_args( a(2) )
			cva_end( a(2) )
		end scope

		'' cva_list is allocated on heap with new/delete
		dim p as cva_list ptr = new cva_list
		scope
			cva_start( *p, n )
			sum_cva_list_args( *p )
			cva_end( *p )
		end scope
		delete p

	end sub

	TEST( complex )
		complex_tests( 1234, 4, 1000, 200, 30, 4 )
	END_TEST

#if (defined(__FB_UNIX__) and defined(__FB_64BIT__)) or defined(__FB_ARM__)
	'' Returning an array not allowed in some versions of gcc
	'' depending on the implementation and of va_list. 
	'' Some tests will fail to compile in gcc on linux x86_64.
	'' To handle returning a byval cva_list, would need to 
	'' pass it in a hidden argument and make the function 
	'' void, or possibly wrap the va_list type in another 
	'' structure.  Generally, the copy assignment/passing
	'' of va_list[0] in gcc is different from what fbc can
	'' currently handle and should be avoided anyway.
	'' Some tests will fail to compile in gcc on on ARM targets.
	#if ENABLE_CHECK_BUGS
		#define VALIST_CAN_RETURN_BYVAL 1
	#else
		#define VALIST_CAN_RETURN_BYVAL 0
	#endif
#else
	'' otherwise, assume it's OK for the platform (needs
	'' testing on all target/arch, though).
	#define VALIST_CAN_RETURN_BYVAL 1
#endif

	function ret_valist_ptr( byval args as cva_list ptr ) as cva_list ptr
		function = args
	end function

	sub proc_cva_list_ptr cdecl( byval n as integer, ... )
		dim args as cva_list
		dim x as cva_list ptr = @args
		dim i as integer

		cva_start( args, n )
		dim arg1 as integer = cva_arg( args, integer )
		dim arg2 as integer = cva_arg( args, integer )
		dim arg3 as integer = cva_arg( args, integer )
		dim arg4 as integer = cva_arg( args, integer )
		cva_end( args )

		cva_start( args, n )
		x = ret_valist_ptr( @args )
		CU_ASSERT( cva_arg( *x, integer ) = arg1 )
		CU_ASSERT( cva_arg( *x, integer ) = arg2 )
		CU_ASSERT( cva_arg( *x, integer ) = arg3 )
		CU_ASSERT( cva_arg( *x, integer ) = arg4 )
		cva_end( args )
	end sub

#if VALIST_CAN_RETURN_BYVAL
	function ret_valist_byval( byval args as cva_list ) as cva_list
		function = args
	end function

	sub proc_cva_list_byval cdecl( byval n as integer, ... )
		dim args as cva_list
		dim x as cva_list
		dim i as integer

		cva_start( args, n )
		dim arg1 as integer = cva_arg( args, integer )
		dim arg2 as integer = cva_arg( args, integer )
		dim arg3 as integer = cva_arg( args, integer )
		dim arg4 as integer = cva_arg( args, integer )
		cva_end( args )

		cva_start( args, n )
		x = ret_valist_byval( args )
		CU_ASSERT( cva_arg( x, integer ) = arg1 )
		CU_ASSERT( cva_arg( x, integer ) = arg2 )
		CU_ASSERT( cva_arg( x, integer ) = arg3 )
		CU_ASSERT( cva_arg( x, integer ) = arg4 )
		cva_end( args )
	end sub
#else
	sub proc_cva_list_byval cdecl( byval n as integer, ... )
	end sub
#endif

	function ret_valist_byref( byref args as cva_list ) byref as cva_list
		function = args
	end function

	sub proc_cva_list_byref cdecl( byval n as integer, ... )
		dim args as cva_list
		dim byref x as cva_list = args
		dim i as integer

		cva_start( args, n )
		dim arg1 as integer = cva_arg( args, integer )
		dim arg2 as integer = cva_arg( args, integer )
		dim arg3 as integer = cva_arg( args, integer )
		dim arg4 as integer = cva_arg( args, integer )
		cva_end( args )

		cva_start( args, n )
		x = ret_valist_byref( args )
		CU_ASSERT( cva_arg( x, integer ) = arg1 )
		CU_ASSERT( cva_arg( x, integer ) = arg2 )
		CU_ASSERT( cva_arg( x, integer ) = arg3 )
		CU_ASSERT( cva_arg( x, integer ) = arg4 )
		cva_end( args )
	end sub

	TEST( cva_list_return_byval )
		proc_cva_list_byval( 4, 4000, 300, 200, 1 )
		proc_cva_list_byref( 4, 4000, 300, 200, 1 )
		proc_cva_list_ptr( 4, 4000, 300, 200, 1 )
	END_TEST

#if VALIST_CAN_RETURN_BYVAL
	function sidefx_byval( byval args as cva_list ) as cva_list
		function = args
	end function
#endif

	function sidefx_ptr( byval args as cva_list ptr ) as cva_list ptr
		function = args
	end function

	function sidefx_byref( byref args as cva_list ) byref as cva_list
		function = args
	end function

	sub proc_sidefx cdecl( byval n as integer, ... )
		dim args as cva_list

		cva_start( args, n )
		dim arg1 as integer = cva_arg( args, integer )
		dim arg2 as integer = cva_arg( args, integer )
		dim arg3 as integer = cva_arg( args, integer )
		dim arg4 as integer = cva_arg( args, integer )
		dim arg5 as integer = cva_arg( args, integer )
		dim arg6 as integer = cva_arg( args, integer )
		cva_end( args )

		cva_start( args, n )
#if VALIST_CAN_RETURN_BYVAL
		CU_ASSERT_EQUAL( cva_arg( sidefx_byval( args ), integer ), arg1 )
		CU_ASSERT_EQUAL( cva_arg( sidefx_byval( args ), integer ), arg1 )
#endif
		CU_ASSERT_EQUAL( cva_arg( sidefx_byref( args ), integer ), arg1 )
		CU_ASSERT_EQUAL( cva_arg( sidefx_byref( args ), integer ), arg2 )
		CU_ASSERT_EQUAL( cva_arg( sidefx_byref( args ), integer ), arg3 )
		CU_ASSERT_EQUAL( cva_arg( *sidefx_ptr( @args ), integer ), arg4 )
		CU_ASSERT_EQUAL( cva_arg( *sidefx_ptr( @args ), integer ), arg5 )
		CU_ASSERT_EQUAL( cva_arg( *sidefx_ptr( @args ), integer ), arg6 )
		cva_end( args )
	end sub

	TEST( side_effects )
		proc_sidefx( 6, 600000, 50000, 4000, 300, 20, 1 )
	END_TEST

END_SUITE
