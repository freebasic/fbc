#include "fbcunit.bi"

SUITE( fbc_tests.numbers.casting )

	TEST( byte_ )
		dim as integer dst, src
		
		src = &hFF
		dst = cubyte( cuint( src ) )
		
		CU_ASSERT_EQUAL( dst, &hFF )
	END_TEST

	TEST( short_ )
		dim as integer dst, src
		
		src = &hFFFF
		dst = cushort( cuint( src ) )
		
		CU_ASSERT_EQUAL( dst, &hFFFF )
	END_TEST

	TEST( integer_ )
		dim as integer dst, src
		
		src = &hFFFFFFFF
		dst = cuint( src )
		
		CU_ASSERT_EQUAL( dst, &hFFFFFFFF )
	END_TEST

	TEST( float_to_int )
		'' Some float-to-int casting to ensure it compiles fine, including the
		'' regression test for bug #3310595.
		dim as single f = 123
		CU_ASSERT( cbyte( f ) = 123 )
		CU_ASSERT( cubyte( f ) = 123 )
		CU_ASSERT( cshort( f ) = 123 )
		CU_ASSERT( cushort( f ) = 123 )
		CU_ASSERT( cint( f ) = 123 )
		CU_ASSERT( cuint( f ) = 123 )
		CU_ASSERT( clng( f ) = 123 )
		CU_ASSERT( culng( f ) = 123 )
		CU_ASSERT( clngint( f ) = 123 )
		CU_ASSERT( culngint( f ) = 123 )

		dim as double d = 123
		CU_ASSERT( cbyte( d ) = 123 )
		CU_ASSERT( cubyte( d ) = 123 )
		CU_ASSERT( cshort( d ) = 123 )
		CU_ASSERT( cushort( d ) = 123 )
		CU_ASSERT( cint( d ) = 123 )
		CU_ASSERT( cuint( d ) = 123 )
		CU_ASSERT( clng( d ) = 123 )
		CU_ASSERT( culng( d ) = 123 )
		CU_ASSERT( clngint( d ) = 123 )
		CU_ASSERT( culngint( d ) = 123 )
	END_TEST

	#macro check_int( typ, s_value, u_value )
		scope
			dim s as typ = s_value
			dim u as unsigned typ = u_value

			'' Sizes match?
			CU_ASSERT( sizeof( s ) = sizeof( u ) )
			CU_ASSERT( sizeof( csign( s ) ) = sizeof( s ) )
			CU_ASSERT( sizeof( cunsg( s ) ) = sizeof( s ) )
			CU_ASSERT( sizeof( csign( u ) ) = sizeof( u ) )
			CU_ASSERT( sizeof( cunsg( u ) ) = sizeof( u ) )

			'' values match?
			CU_ASSERT( csign( s ) = s )
			CU_ASSERT( csign( u ) = s )
			CU_ASSERT( cunsg( s ) = u )
			CU_ASSERT( cunsg( u ) = u )

			'' types match?
			#assert typeof( csign( s ) ) = typeof( typ )
			#assert typeof( cunsg( s ) ) = typeof( unsigned typ )
			#assert typeof( csign( u ) ) = typeof( typ )
			#assert typeof( cunsg( u ) ) = typeof( unsigned typ )

			'' same value when convert back to original type?
			dim s2 as typ = csign( u )
			dim u2 as unsigned typ = cunsg( s )
			CU_ASSERT( s2 = s )
			CU_ASSERT( u2 = u )

		end scope
	#endmacro

	TEST( sign_ints )
		check_int( byte,    0,   0 )
		check_int( byte,  127, 127 )
		check_int( byte, -128, 128 )
		check_int( byte,   -1, 255 )

		check_int( short,      0,     0 )
		check_int( short,  32767, 32767 )
		check_int( short, -32768, 32768 )
		check_int( short,     -1, 65535 )

		check_int( long,           0ll,          0ull )
		check_int( long,  2147483647ll, 2147483647ull )
		check_int( long, -2147483648ll, 2147483648ull )
		check_int( long,          -1ll, 4294967295ull )

		#ifndef __FB_64BIT__
			check_int( integer,           0ll,          0ull )
			check_int( integer,  2147483647ll, 2147483647ull )
			check_int( integer, -2147483648ll, 2147483648ull )
			check_int( integer,          -1ll, 4294967295ull )
		#else
			check_int( integer,                    0ll,                    0ull )
			check_int( integer,  9223372036854775807ll,  9223372036854775807ull )
			check_int( integer, -9223372036854775808ll,  9223372036854775808ull )
			check_int( integer,                   -1ll, 18446744073709551615ull )
		#endif

		check_int( longint,                    0ll,                    0ull )
		check_int( longint,  9223372036854775807ll,  9223372036854775807ull )
		check_int( longint, -9223372036854775808ll,  9223372036854775808ull )
		check_int( longint,                   -1ll, 18446744073709551615ull )

	END_TEST

	TEST( sign_ptrs )

		union T
			p as any ptr
			i as integer
		end union

		dim x as T

		#ifndef __FB_64BIT__
			x.i = &h800000001
		#else
			x.i = &h80000000000000001
		#endif

		CU_ASSERT( sizeof( x.p ) = sizeof( x.i ) )
		CU_ASSERT( sizeof( csign( x.p ) ) = sizeof( x.p ) )
		CU_ASSERT( sizeof( cunsg( x.p ) ) = sizeof( x.p ) )

		scope
			var ni = csign( x.i )
			var np = csign( x.p )
			CU_ASSERT( np = ni )
			var p = cast( any ptr, np )
			CU_ASSERT( p = x.p )
		end scope

		scope
			var ni = cunsg( x.i )
			var np = cunsg( x.p )
			CU_ASSERT( np = ni )
			var p = cast( any ptr, np )
			CU_ASSERT( p = x.p )
		end scope

	END_TEST

END_SUITE
