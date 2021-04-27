# include "fbcunit.bi"

'' originally these tests were included in select_const.bas
'' but due the nested macro expansion, the test as written
'' in the gcc backend would generate a C listing 250K+ in length 
'' and is very taxing on gcc especially when optimizations and
'' debug information is enabled.  In some cases:
'' - gcc (cc1) can run out of memory allocting debug symbols
'' - gcc -O2 is really (really!) slow due that most of the
''   test uses constant symbols and gcc chews away on optimizing
''   for quite some time

'' split the test so we can modify test generation here separately   

SUITE( fbc_tests.compound.select_const2 )

	const FALSE = 0
	const TRUE = not FALSE

	#macro TEST_RANGE( T, a, b, c_, d_, p, f )
		#if DEFINITION = TRUE
			__fb_uniqueid_push__( callstack )
			sub __fb_uniqueid__( callstack )
				dim as integer ok, nok
				ok = 0
				nok = 0
				dim v as T
				#if LITERAL
					#define c c_
					#define d d_
				#else
					const c as T = c_
					const d as T = d_
				#endif
				v = a
				do
					select case as const v
					case (c) to (d)
						CU_ASSERT( (v>=(c)) and (v<=(d)) )
						ok += 1
					case else
						CU_ASSERT( not ((v>=(c)) and (v<=(d))) )
						nok += 1
					end select
					if( v = b ) then
						exit do
					end if
					v += 1
				loop
				CU_ASSERT_EQUAL( p, ok )
				CU_ASSERT_EQUAL( f, nok )
			end sub
		#else
			'' call the test - the order doesn't matter 
			__fb_uniqueid__( callstack )()
			__fb_uniqueid_pop__( callstack )
		#endif
	#endmacro

	#macro TEST_RANGE_EDGES( T, a, b ) 
			TEST_RANGE( T, a+0, a+10, a+0, a+0, 1, 10 )
			TEST_RANGE( T, a+0, a+10, a+0, a+1, 2,  9 )
			TEST_RANGE( T, a+0, a+10, a+1, a+1, 1, 10 )
			TEST_RANGE( T, a+0, a+10, a+1, a+2, 2,  9 )
			TEST_RANGE( T, a+0, a+10, a+2, a+2, 1, 10 )

			TEST_RANGE( T, a+0, a+10, a+0, a+3, 4,  7 )
			TEST_RANGE( T, a+0, a+10, a+1, a+4, 4,  7 )
			TEST_RANGE( T, a+0, a+10, a+2, a+5, 4,  7 )

			TEST_RANGE( T, a+1, a+10, a+0, a+0, 0, 10 )
			TEST_RANGE( T, a+1, a+10, a+0, a+1, 1,  9 )
			TEST_RANGE( T, a+1, a+10, a+1, a+1, 1,  9 )
			TEST_RANGE( T, a+1, a+10, a+1, a+2, 2,  8 )
			TEST_RANGE( T, a+1, a+10, a+2, a+2, 1,  9 )

			TEST_RANGE( T, b-10, b-0, b-0, b-0, 1, 10 )
			TEST_RANGE( T, b-10, b-0, b-1, b-0, 2,  9 )
			TEST_RANGE( T, b-10, b-0, b-1, b-1, 1, 10 )
			TEST_RANGE( T, b-10, b-0, b-2, b-1, 2,  9 )
			TEST_RANGE( T, b-10, b-0, b-2, b-2, 1, 10 )

			TEST_RANGE( T, b-10, b-0, b-3, b-0, 4,  7 )
			TEST_RANGE( T, b-10, b-0, b-4, b-1, 4,  7 )
			TEST_RANGE( T, b-10, b-0, b-5, b-2, 4,  7 )

			TEST_RANGE( T, b-10, b-1, b-0, b-0, 0, 10 )
			TEST_RANGE( T, b-10, b-1, b-1, b-0, 1,  9 )
			TEST_RANGE( T, b-10, b-1, b-1, b-1, 1,  9 )
			TEST_RANGE( T, b-10, b-1, b-2, b-1, 2,  8 )
			TEST_RANGE( T, b-10, b-1, b-2, b-2, 1,  9 )
	#endmacro

	#macro TEST_RANGES()
			'' byte range edges and near zero
			TEST_RANGE_EDGES( byte, -128, 127 )
			TEST_RANGE_EDGES( byte, -2, 2 )
			TEST_RANGE_EDGES( ubyte, 0, 255 )

			TEST_RANGE_EDGES( short, -129, 128 )
			TEST_RANGE_EDGES( short, -1, 256 )
			TEST_RANGE_EDGES( long, -129, 128 )
			TEST_RANGE_EDGES( long, -1, 256 )
			TEST_RANGE_EDGES( integer, -129, 128 )
			TEST_RANGE_EDGES( integer, -1, 256 )
			TEST_RANGE_EDGES( longint, -129, 128 )
			TEST_RANGE_EDGES( longint, -1, 256 )

			'' short range edges and near zero
			TEST_RANGE_EDGES( short, -32768, 32767 )
			TEST_RANGE_EDGES( short, -2, 2 )
			TEST_RANGE_EDGES( ushort, 0, 65535 )

			TEST_RANGE_EDGES( long, -32769, 32768 )
			TEST_RANGE_EDGES( long, 0, 65536 )
			TEST_RANGE_EDGES( integer, -32769, 32768 )
			TEST_RANGE_EDGES( integer, 0, 65536 )
			TEST_RANGE_EDGES( longint, -32769, 32768 )
			TEST_RANGE_EDGES( longint, 0, 65536 )

			'' long range edges and near zero
			TEST_RANGE_EDGES( long, -2147483648, 2147483647 )
			TEST_RANGE_EDGES( long, -2, 2 )
			TEST_RANGE_EDGES( ulong, 0, 4294967295 )

			TEST_RANGE_EDGES( longint, -2147483649ll, 2147483648ll )
			TEST_RANGE_EDGES( longint, 0, 4294967296ll )

			#ifdef __FB_64BIT__
				TEST_RANGE_EDGES( integer, -9223372036854775807ll-1ll, 9223372036854775807ll  )
				TEST_RANGE_EDGES( integer, -2ll, 2ll )
				TEST_RANGE_EDGES( uinteger, 0, 18446744073709551615ull )
			#else
				TEST_RANGE_EDGES( integer, -2147483648, 2147483647 )
				TEST_RANGE_EDGES( integer, -2, 2 )
				TEST_RANGE_EDGES( uinteger, 0, 4294967295 )

				TEST_RANGE_EDGES( longint, -2147483649ll, 2147483648ll )
				TEST_RANGE_EDGES( longint, 0, 4294967296ll )
			#endif

			'' longint range edges and near zero
			TEST_RANGE_EDGES( longint, -9223372036854775807ll-1ll, 9223372036854775807ll  )
			TEST_RANGE_EDGES( longint, -2ll, 2ll )
			TEST_RANGE_EDGES( ulongint, 0, 18446744073709551615ull )
	#endmacro

	'' generate tests for Test Ranges using literal values
	#define LITERAL TRUE
	#undef DEFINITION
	#define DEFINITION TRUE
	TEST_RANGES()

	'' call the tests - the order doesn't matter, only that we use & call
	'' the correct number of calls from the callstack
	#undef DEFINITION
	#define DEFINITION FALSE
	TEST( RangeEdges_literal )
		TEST_RANGES()
	END_TEST

	'' generate tests for Test Ranges using a CONST symbol
	#undef LITERAL
	#define LITERAL FALSE
	#undef DEFINITION
	#define DEFINITION TRUE
	TEST_RANGES()
	
	'' call the tests - the order doesn't matter, only that we use & call
	'' the correct number of calls from the callstack
	#undef DEFINITION
	#define DEFINITION FALSE
	TEST( RangeEdges_const )
		TEST_RANGES()
	END_TEST

END_SUITE
