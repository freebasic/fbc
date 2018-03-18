#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.float_bop_cast_rhs )

	private sub code_generation_proc
		'' -gen gas should generate good code for all of these

		#macro check( TL, TR, rhsexpr )
			scope
				dim l as TL = 10, r as TR = 5
				l += rhsexpr
				CU_ASSERT( l = 15 )
			end scope
			scope
				dim l as TL = 10, r as TR = 5
				l -= rhsexpr
				CU_ASSERT( l = 5 )
			end scope
			scope
				dim l as TL = 10, r as TR = 5
				l /= rhsexpr
				CU_ASSERT( l = 2 )
			end scope
		#endmacro

		check( single,  byte, r )
		check( single,  byte, cdbl( r ) )
		check( single,  byte, csng( r ) )
		check( single, ubyte, r )
		check( single, ubyte, cdbl( r ) )
		check( single, ubyte, csng( r ) )

		check( single,  short, r )
		check( single,  short, cdbl( r ) )
		check( single,  short, csng( r ) )
		check( single, ushort, r )
		check( single, ushort, cdbl( r ) )
		check( single, ushort, csng( r ) )

		check( single,  long, r )
		check( single,  long, cdbl( r ) )
		check( single,  long, csng( r ) )
		check( single, ulong, r )
		check( single, ulong, cdbl( r ) )
		check( single, ulong, csng( r ) )

		check( single,  integer, r )
		check( single,  integer, cdbl( r ) )
		check( single,  integer, csng( r ) )
		check( single, uinteger, r )
		check( single, uinteger, cdbl( r ) )
		check( single, uinteger, csng( r ) )

		check( single,  longint, r )
		check( single,  longint, cdbl( r ) )
		check( single,  longint, csng( r ) )
		check( single, ulongint, r )
		check( single, ulongint, cdbl( r ) )
		check( single, ulongint, csng( r ) )

		check( single, single, r )
		check( single, single, cdbl( r ) )
		check( single, single, csng( r ) )
		check( single, double, r )
		check( single, double, cdbl( r ) )
		check( single, double, csng( r ) )

		check( double,  byte, r )
		check( double,  byte, cdbl( r ) )
		check( double,  byte, csng( r ) )
		check( double, ubyte, r )
		check( double, ubyte, cdbl( r ) )
		check( double, ubyte, csng( r ) )

		check( double,  short, r )
		check( double,  short, cdbl( r ) )
		check( double,  short, csng( r ) )
		check( double, ushort, r )
		check( double, ushort, cdbl( r ) )
		check( double, ushort, csng( r ) )

		check( double,  long, r )
		check( double,  long, cdbl( r ) )
		check( double,  long, csng( r ) )
		check( double, ulong, r )
		check( double, ulong, cdbl( r ) )
		check( double, ulong, csng( r ) )

		check( double,  integer, r )
		check( double,  integer, cdbl( r ) )
		check( double,  integer, csng( r ) )
		check( double, uinteger, r )
		check( double, uinteger, cdbl( r ) )
		check( double, uinteger, csng( r ) )

		check( double,  longint, r )
		check( double,  longint, cdbl( r ) )
		check( double,  longint, csng( r ) )
		check( double, ulongint, r )
		check( double, ulongint, cdbl( r ) )
		check( double, ulongint, csng( r ) )

		check( double, single, r )
		check( double, single, cdbl( r ) )
		check( double, single, csng( r ) )
		check( double, double, r )
		check( double, double, cdbl( r ) )
		check( double, double, csng( r ) )
	end sub

	private sub noconv_casts_proc
		dim d as double, i as integer = -1, u as uinteger = -1

		CU_ASSERT(     cint(i) = -1 )
		CU_ASSERT( d + cint(i) = -1 )

	#ifdef __FB_64BIT__
		CU_ASSERT(     cuint(i) = 18446744073709551615u )
		'' The + BOP result is DOUBLE, but that can't fully represent &hFFFFFFFFFFFFFFFFull,
		'' and even an epsilon check is difficult because DOUBLE has bad precision at this high value
		'CU_ASSERT( d + cuint(i) = 18446744073709551615u )
	#else
		CU_ASSERT(     cuint(i) = 4294967295u )
		CU_ASSERT( d + cuint(i) = 4294967295u )
	#endif

		CU_ASSERT(     cint(u) = -1 )
		CU_ASSERT( d + cint(u) = -1 )

	#ifdef __FB_64BIT__
		CU_ASSERT(     cuint(u) = 18446744073709551615u )
		'' ditto
		'CU_ASSERT( d + cuint(u) = 18446744073709551615u )
	#else
		CU_ASSERT(     cuint(u) = 4294967295u )
		CU_ASSERT( d + cuint(u) = 4294967295u )
	#endif
	end sub

	TEST( code_generation )
		code_generation_proc
	END_TEST

	TEST( noconv_casts )
		noconv_casts_proc
	END_TEST

END_SUITE
