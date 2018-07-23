# include "fbcunit.bi"

SUITE( fbc_tests.dim_.global_init )

	TEST_GROUP( addrofGlobal )
		'' -gen gcc regression test: This shouldn't trigger a gcc warning.
		dim shared a as integer
		dim shared b as integer = @a
		TEST( default )
			CU_ASSERT( b = @a )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dimTypeiniConstant )
		dim shared   b as     byte = type<    byte>( 1)
		dim shared  ub as    ubyte = type<   ubyte>( 2)
		dim shared  sh as    short = type<   short>( 3)
		dim shared ush as   ushort = type<  ushort>( 4)
		dim shared   l as     long = type<    long>( 5)
		dim shared  ul as    ulong = type<   ulong>( 6)
		dim shared  ll as  longint = type< longint>( 7)
		dim shared ull as ulongint = type<ulongint>( 8)
		dim shared   i as  integer = type< integer>( 9)
		dim shared  ui as uinteger = type<uinteger>(10)
		dim shared   f as   single = type<  single>(11)
		dim shared   d as   double = type<  double>(12)
		dim shared   z as zstring * 32 = type<string>( "13" )
		dim shared   w as wstring * 32 = type<string>( "14" )
		dim shared pany as any ptr = type<any ptr>( cptr( any ptr, 15 ) )
		TEST( default )
			CU_ASSERT(   b =  1 )
			CU_ASSERT(  ub =  2 )
			CU_ASSERT(  sh =  3 )
			CU_ASSERT( ush =  4 )
			CU_ASSERT(   l =  5 )
			CU_ASSERT(  ul =  6 )
			CU_ASSERT(  ll =  7 )
			CU_ASSERT( ull =  8 )
			CU_ASSERT(   i =  9 )
			CU_ASSERT(  ui = 10 )
			CU_ASSERT(   f = 11 )
			CU_ASSERT(   d = 12 )
			CU_ASSERT(   z = "13" )
			CU_ASSERT(   w = "14" )
			CU_ASSERT( pany = cptr( any ptr, 15 ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( autoTypeiniConstant )
		var shared   b = type<    byte>( 1)
		var shared  ub = type<   ubyte>( 2)
		var shared  sh = type<   short>( 3)
		var shared ush = type<  ushort>( 4)
		var shared   l = type<    long>( 5)
		var shared  ul = type<   ulong>( 6)
		var shared  ll = type< longint>( 7)
		var shared ull = type<ulongint>( 8)
		var shared   i = type< integer>( 9)
		var shared  ui = type<uinteger>(10)
		var shared   f = type<  single>(11)
		var shared   d = type<  double>(12)
		var shared pany = type<any ptr>( cptr( any ptr, 15 ) )
		TEST( default )
			CU_ASSERT(   b =  1 )
			CU_ASSERT(  ub =  2 )
			CU_ASSERT(  sh =  3 )
			CU_ASSERT( ush =  4 )
			CU_ASSERT(   l =  5 )
			CU_ASSERT(  ul =  6 )
			CU_ASSERT(  ll =  7 )
			CU_ASSERT( ull =  8 )
			CU_ASSERT(   i =  9 )
			CU_ASSERT(  ui = 10 )
			CU_ASSERT(   f = 11 )
			CU_ASSERT(   d = 12 )
			CU_ASSERT( pany = cptr( any ptr, 15 ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( typeiniOffset )
		dim shared i as integer
		dim shared a as integer ptr = @i
		#ifdef __FB_64BIT__
			dim shared b as longint = @i
		#else
			dim shared b as long = @i
		#endif
		TEST( default )
			CU_ASSERT( a = @i )
			CU_ASSERT( b = cint( @i ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( autoOffset )
		var shared i = 0
		var shared a = @i
		TEST( default )
			CU_ASSERT( a = @i )
		END_TEST
	END_TEST_GROUP

END_SUITE
