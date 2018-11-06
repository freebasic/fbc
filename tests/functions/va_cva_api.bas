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

		cva_end( x1 )
		cva_end( x2 )

	end sub

	TEST( copy )
		f_test_copy( 10, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 )
	END_TEST

	sub f_test_list2 cdecl( byval n as integer, args as cva_list )
		
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


END_SUITE
