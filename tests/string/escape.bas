#include "fbcunit.bi"

SUITE( fbc_tests.string_.escape )

	TEST( escape_ )
		#define d !"\64abc\65"

		const c = d
		dim v as string = d
		static s as zstring * 32 => d

		CU_ASSERT( d = !"\64abc\65" )
		CU_ASSERT( c = d )
		CU_ASSERT( v = d )
		CU_ASSERT( s = d )
	END_TEST

	TEST( noEscape )
		#define d $"\64abc\65"

		const c = d
		dim v as string = d
		static s as zstring * 32 => d

		CU_ASSERT( d = $"\64abc\65" )
		CU_ASSERT( c = d )
		CU_ASSERT( v = d )
		CU_ASSERT( s = d )
	END_TEST

	TEST( numBase )
		CU_ASSERT( !"\65\66\67" = "ABC" )
		CU_ASSERT( !"\&h41\&h42\&h43" = "ABC" )
		CU_ASSERT( !"\&o101\&o102\&o103" = "ABC" )
		CU_ASSERT( !"\&b1000001\&b1000010\&b1000011" = "ABC" )
	END_TEST

	'' The following are mostly tests for the code generation backends,
	'' to see whether string literals are emitted correctly. Both global and
	'' local variable initialization are being tested, since e.g. the C backend
	'' will emit global initializers differently from in-line literals.

	#macro checkAbc( s )
		CU_ASSERT( s[0] = 97 )
		CU_ASSERT( s[1] = 98 )
		CU_ASSERT( s[2] = 99 )
		CU_ASSERT( s[3] = 0 )
	#endmacro

	TEST_GROUP( tooShort1 )
		'' Initializer definitely too short
		dim shared as  string * 9   globalf = "abc"
		dim shared as zstring * 10  globalz = "abc"
		dim shared as wstring * 10  globalw = wstr( "abc" )

		TEST( default )
			checkAbc( globalf )
			checkAbc( globalz )
			checkAbc( globalw )

			dim as  string * 9   f = "abc"
			dim as zstring * 10  z = "abc"
			dim as wstring * 10  w = wstr( "abc" )

			checkAbc( f )
			checkAbc( z )
			checkAbc( w )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( tooShort2 )
		'' Initializer too short, by one char (the null terminator should be
		'' taken into account properly)
		dim shared as  string * 4  globalf = "abc"
		dim shared as zstring * 5  globalz = "abc"
		dim shared as wstring * 5  globalw = wstr( "abc" )

		TEST( default )
			checkAbc( globalf )
			checkAbc( globalz )
			checkAbc( globalw )

			dim as  string * 4  f = "abc"
			dim as zstring * 5  z = "abc"
			dim as wstring * 5  w = wstr( "abc" )

			checkAbc( f )
			checkAbc( z )
			checkAbc( w )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( exactFit )
		dim shared as  string * 3  globalf = "abc"
		dim shared as zstring * 4  globalz = "abc"
		dim shared as wstring * 4  globalw = wstr( "abc" )

		TEST( default )
			checkAbc( globalf )
			checkAbc( globalz )
			checkAbc( globalw )

			dim as  string * 3  f = "abc"
			dim as zstring * 4  z = "abc"
			dim as wstring * 4  w = wstr( "abc" )

			checkAbc( f )
			checkAbc( z )
			checkAbc( w )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( tooLong1 )
		'' Initializer definitely too long, must be truncated, possibly with
		'' a warning shown
		dim shared as  string * 3  globalf = "abcdefghij"
		dim shared as zstring * 4  globalz = "abcdefghij"
		dim shared as wstring * 4  globalw = wstr( "abcdefghij" )

		TEST( default )
			checkAbc( globalf )
			checkAbc( globalz )
			checkAbc( globalw )

			dim as  string * 3  f = "abcdefghij"
			dim as zstring * 4  z = "abcdefghij"
			dim as wstring * 4  w = wstr( "abcdefghij" )

			checkAbc( f )
			checkAbc( z )
			checkAbc( w )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( tooLong2 )
		'' Only room for one char + the null terminator
		dim shared as  string * 1  globalf = "abc"
		dim shared as zstring * 2  globalz = "abc"
		dim shared as wstring * 2  globalw = wstr( "abc" )

		TEST( default )
			CU_ASSERT( globalf[0] = 97 )
			CU_ASSERT( globalf[1] = 0 )
			CU_ASSERT( globalz[0] = 97 )
			CU_ASSERT( globalz[1] = 0 )
			CU_ASSERT( globalw[0] = 97 )
			CU_ASSERT( globalw[1] = 0 )

			dim as  string * 1  f = "abc"
			dim as zstring * 2  z = "abc"
			dim as wstring * 2  w = wstr( "abc" )

			CU_ASSERT( f[0] = 97 )
			CU_ASSERT( f[1] = 0 )
			CU_ASSERT( z[0] = 97 )
			CU_ASSERT( z[1] = 0 )
			CU_ASSERT( w[0] = 97 )
			CU_ASSERT( w[1] = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( tooLong3 )
		'' Only room for the null terminator... (Note: STRING * 0 isn't allowed)
		dim shared as zstring * 1  globalz = "abc"
		dim shared as wstring * 1  globalw = wstr( "abc" )

		TEST( default )
			CU_ASSERT( globalz[0] = 0 )
			CU_ASSERT( globalw[0] = 0 )

			dim as zstring * 1  z = "abc"
			dim as wstring * 1  w = wstr( "abc" )

			CU_ASSERT( z[0] = 0 )
			CU_ASSERT( w[0] = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( escapeNull )
		'' The rtlib or even the compiler already may only read up to
		'' the first null char when initializing fixed-length strings, so we
		'' cannot assume the remaining chars will be initialized,
		'' so this will mostly be a compile-time check then.

		dim shared as zstring * 2  globalz1 = !"\0"
		dim shared as zstring * 3  globalz2 = !"\0\0"
		dim shared as wstring * 2  globalw1 = wstr( !"\0" )
		dim shared as wstring * 3  globalw2 = wstr( !"\0\0" )

		TEST( default )
			CU_ASSERT( globalz1[0] = 0 )
			CU_ASSERT( globalz2[0] = 0 )
			CU_ASSERT( globalw1[0] = 0 )
			CU_ASSERT( globalw2[0] = 0 )

			dim as zstring * 2  z1 = !"\0"
			dim as zstring * 3  z2 = !"\0\0"
			dim as wstring * 2  w1 = wstr( !"\0" )
			dim as wstring * 3  w2 = wstr( !"\0\0" )

			CU_ASSERT( z1[0] = 0 )
			CU_ASSERT( z2[0] = 0 )
			CU_ASSERT( w1[0] = 0 )
			CU_ASSERT( w2[0] = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( escapeBackslashes )
		dim shared as zstring * 2  globalz1 = !"\\"
		dim shared as zstring * 3  globalz2 = !"\\\\"
		dim shared as zstring * 2  globalz3 = chr( 92 )
		dim shared as wstring * 2  globalw1 = wstr( !"\\" )
		dim shared as wstring * 3  globalw2 = wstr( !"\\\\" )
		dim shared as wstring * 2  globalw3 = wchr( 92 )

		TEST( default )
			CU_ASSERT( globalz1[0] = 92 )
			CU_ASSERT( globalz1[1] = 0 )

			CU_ASSERT( globalz2[0] = 92 )
			CU_ASSERT( globalz2[1] = 92 )
			CU_ASSERT( globalz2[2] = 0 )

			CU_ASSERT( globalz3[0] = 92 )
			CU_ASSERT( globalz3[1] = 0 )

			CU_ASSERT( globalw1[0] = 92 )
			CU_ASSERT( globalw1[1] = 0 )

			CU_ASSERT( globalw2[0] = 92 )
			CU_ASSERT( globalw2[1] = 92 )
			CU_ASSERT( globalw2[2] = 0 )

			CU_ASSERT( globalw3[0] = 92 )
			CU_ASSERT( globalw3[1] = 0 )

			dim as zstring * 2  z1 = !"\\"
			dim as zstring * 3  z2 = !"\\\\"
			dim as zstring * 2  z3 = chr( 92 )
			dim as wstring * 2  w1 = wstr( !"\\" )
			dim as wstring * 3  w2 = wstr( !"\\\\" )
			dim as wstring * 2  w3 = wchr( 92 )

			CU_ASSERT( z1[0] = 92 )
			CU_ASSERT( z1[1] = 0 )

			CU_ASSERT( z2[0] = 92 )
			CU_ASSERT( z2[1] = 92 )
			CU_ASSERT( z2[2] = 0 )

			CU_ASSERT( z3[0] = 92 )
			CU_ASSERT( z3[1] = 0 )

			CU_ASSERT( w1[0] = 92 )
			CU_ASSERT( w1[1] = 0 )

			CU_ASSERT( w2[0] = 92 )
			CU_ASSERT( w2[1] = 92 )
			CU_ASSERT( w2[2] = 0 )

			CU_ASSERT( w3[0] = 92 )
			CU_ASSERT( w3[1] = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( escapeQuotes )
		'' (Just testing single quotes in case the C backend emits 'x' char
		'' literals, in which single quotes must be escaped, like double quotes
		'' in normal string literals)

		dim shared as zstring * 2  globalz1 = """"
		dim shared as zstring * 2  globalz2 = !"\""
		dim shared as zstring * 2  globalz3 = "'"
		dim shared as zstring * 2  globalz4 = chr( 34 )
		dim shared as zstring * 2  globalz5 = chr( 39 )
		dim shared as wstring * 2  globalw1 = wstr( """" )
		dim shared as wstring * 2  globalw2 = wstr( !"\"" )
		dim shared as wstring * 2  globalw3 = wstr( "'" )
		dim shared as wstring * 2  globalw4 = wchr( 34 )
		dim shared as wstring * 2  globalw5 = wchr( 39 )

		TEST( default )
			CU_ASSERT( globalz1[0] = 34 ) : CU_ASSERT( globalz1[1] = 0 )
			CU_ASSERT( globalz2[0] = 34 ) : CU_ASSERT( globalz2[1] = 0 )
			CU_ASSERT( globalz3[0] = 39 ) : CU_ASSERT( globalz3[1] = 0 )
			CU_ASSERT( globalz4[0] = 34 ) : CU_ASSERT( globalz4[1] = 0 )
			CU_ASSERT( globalz5[0] = 39 ) : CU_ASSERT( globalz5[1] = 0 )

			CU_ASSERT( globalw1[0] = 34 ) : CU_ASSERT( globalw1[1] = 0 )
			CU_ASSERT( globalw2[0] = 34 ) : CU_ASSERT( globalw2[1] = 0 )
			CU_ASSERT( globalw3[0] = 39 ) : CU_ASSERT( globalw3[1] = 0 )
			CU_ASSERT( globalw4[0] = 34 ) : CU_ASSERT( globalw4[1] = 0 )
			CU_ASSERT( globalw5[0] = 39 ) : CU_ASSERT( globalw5[1] = 0 )

			dim as zstring * 2  z1 = """"
			dim as zstring * 2  z2 = !"\""
			dim as zstring * 2  z3 = "'"
			dim as zstring * 2  z4 = chr( 34 )
			dim as zstring * 2  z5 = chr( 39 )
			dim as wstring * 2  w1 = wstr( """" )
			dim as wstring * 2  w2 = wstr( !"\"" )
			dim as wstring * 2  w3 = wstr( "'" )
			dim as wstring * 2  w4 = wchr( 34 )
			dim as wstring * 2  w5 = wchr( 39 )

			CU_ASSERT( z1[0] = 34 ) : CU_ASSERT( z1[1] = 0 )
			CU_ASSERT( z2[0] = 34 ) : CU_ASSERT( z2[1] = 0 )
			CU_ASSERT( z3[0] = 39 ) : CU_ASSERT( z3[1] = 0 )
			CU_ASSERT( z4[0] = 34 ) : CU_ASSERT( z4[1] = 0 )
			CU_ASSERT( z5[0] = 39 ) : CU_ASSERT( z5[1] = 0 )

			CU_ASSERT( w1[0] = 34 ) : CU_ASSERT( w1[1] = 0 )
			CU_ASSERT( w2[0] = 34 ) : CU_ASSERT( w2[1] = 0 )
			CU_ASSERT( w3[0] = 39 ) : CU_ASSERT( w3[1] = 0 )
			CU_ASSERT( w4[0] = 34 ) : CU_ASSERT( w4[1] = 0 )
			CU_ASSERT( w5[0] = 39 ) : CU_ASSERT( w5[1] = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( escapeHex1 )
		dim shared as zstring * 2  globalz = !"\&hFF"
		dim shared as wstring * 2  globalw = wstr( !"\&hFF" )

		TEST( default )
			CU_ASSERT( globalz[0] = 255 ) : CU_ASSERT( globalz[1] = 0 )
			CU_ASSERT( globalw[0] = 255 ) : CU_ASSERT( globalw[1] = 0 )

			dim as zstring * 2  z = !"\&hFF"
			dim as wstring * 2  w = wstr( !"\&hFF" )

			CU_ASSERT( z[0] = 255 ) : CU_ASSERT( z[1] = 0 )
			CU_ASSERT( w[0] = 255 ) : CU_ASSERT( w[1] = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( digitBehindEscape )
		'' The backends must take special care when emitting escapes followed
		'' by chars that could be seen as part of that escape sequence.
		'' (it depends on the backend though, whether it emits octal or hex
		'' escapes, etc.)

		dim shared as zstring * 3  globalz1 = !"\1a"  '' hex digit
		dim shared as zstring * 3  globalz2 = !"\32a"
		dim shared as zstring * 3  globalz3 = !"\255a"
		dim shared as zstring * 3  globalz4 = !"\1" "1"  '' octal/decimal digit
		dim shared as zstring * 3  globalz5 = !"\32" "1"
		dim shared as zstring * 3  globalz6 = !"\255" "1"

		dim shared as wstring * 3  globalw1 = wstr( !"\1a" )
		dim shared as wstring * 3  globalw2 = wstr( !"\32a" )
		dim shared as wstring * 3  globalw3 = wstr( !"\255a" )
		dim shared as wstring * 3  globalw4 = wstr( !"\1" "1" )
		dim shared as wstring * 3  globalw5 = wstr( !"\32" "1" )
		dim shared as wstring * 3  globalw6 = wstr( !"\255" "1" )

		TEST( default )
			#macro check( s, c0, c1 )
				CU_ASSERT( s[0] = c0 )
				CU_ASSERT( s[1] = c1 )
				CU_ASSERT( s[2] = 0  )
			#endmacro

			check( globalz1, 1  , 97 )
			check( globalz2, 32 , 97 )
			check( globalz3, 255, 97 )
			check( globalz4, 1  , 49 )
			check( globalz5, 32 , 49 )
			check( globalz6, 255, 49 )

			check( globalw1, 1  , 97 )
			check( globalw2, 32 , 97 )
			check( globalw3, 255, 97 )
			check( globalw4, 1  , 49 )
			check( globalw5, 32 , 49 )
			check( globalw6, 255, 49 )

			dim as zstring * 3  z1 = !"\1a"  '' hex digit
			dim as zstring * 3  z2 = !"\32a"
			dim as zstring * 3  z3 = !"\255a"
			dim as zstring * 3  z4 = !"\1" "1"  '' octal/decimal digit
			dim as zstring * 3  z5 = !"\32" "1"
			dim as zstring * 3  z6 = !"\255" "1"

			dim as wstring * 3  w1 = wstr( !"\1a" )
			dim as wstring * 3  w2 = wstr( !"\32a" )
			dim as wstring * 3  w3 = wstr( !"\255a" )
			dim as wstring * 3  w4 = wstr( !"\1" "1" )
			dim as wstring * 3  w5 = wstr( !"\32" "1" )
			dim as wstring * 3  w6 = wstr( !"\255" "1" )

			check( z1, 1  , 97 )
			check( z2, 32 , 97 )
			check( z3, 255, 97 )
			check( z4, 1  , 49 )
			check( z5, 32 , 49 )
			check( z6, 255, 49 )

			check( w1, 1  , 97 )
			check( w2, 32 , 97 )
			check( w3, 255, 97 )
			check( w4, 1  , 49 )
			check( w5, 32 , 49 )
			check( w6, 255, 49 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( combination )
		dim shared as  string * 31  globalf1 = !"a\1\\\"b"
		dim shared as  string * 1   globalf2 = !"a\1\\\"b"
		dim shared as  string * 5   globalf3 = !"a\1\\\"b"

		dim shared as zstring * 32  globalz1 = !"a\1\\\"b"
		dim shared as zstring * 2   globalz2 = !"a\1\\\"b"
		dim shared as zstring * 6   globalz3 = !"a\1\\\"b"

		dim shared as wstring * 32  globalw1 = wstr( !"a\1\\\"b" )
		dim shared as wstring * 2   globalw2 = wstr( !"a\1\\\"b" )
		dim shared as wstring * 6   globalw3 = wstr( !"a\1\\\"b" )

		TEST( default )
			#macro check6( s )
				CU_ASSERT( s[0] = 97 )
				CU_ASSERT( s[1] = 1  )
				CU_ASSERT( s[2] = 92 )
				CU_ASSERT( s[3] = 34 )
				CU_ASSERT( s[4] = 98 )
				CU_ASSERT( s[5] = 0  )
			#endmacro

			#macro check2( s )
				CU_ASSERT( s[0] = 97 )
				CU_ASSERT( s[1] = 0  )
			#endmacro

			check6( globalf1 )
			check2( globalf2 )
			check6( globalf3 )

			check6( globalz1 )
			check2( globalz2 )
			check6( globalz3 )

			check6( globalw1 )
			check2( globalw2 )
			check6( globalw3 )

			dim as  string * 31  f1 = !"a\1\\\"b"
			dim as  string * 1   f2 = !"a\1\\\"b"
			dim as  string * 5   f3 = !"a\1\\\"b"

			dim as zstring * 32  z1 = !"a\1\\\"b"
			dim as zstring * 2   z2 = !"a\1\\\"b"
			dim as zstring * 6   z3 = !"a\1\\\"b"

			dim as wstring * 32  w1 = wstr( !"a\1\\\"b" )
			dim as wstring * 2   w2 = wstr( !"a\1\\\"b" )
			dim as wstring * 6   w3 = wstr( !"a\1\\\"b" )

			check6( f1 )
			check2( f2 )
			check6( f3 )

			check6( z1 )
			check2( z2 )
			check6( z3 )

			check6( w1 )
			check2( w2 )
			check6( w3 )
		END_TEST
	END_TEST_GROUP

END_SUITE
