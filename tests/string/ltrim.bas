#include "fbcunit.bi"

SUITE( fbc_tests.string_.ltrim_ )

	dim shared result as integer
	dim shared str_ret as string

	TEST( test1 )

		str_ret = ltrim("asd", "")
		CU_ASSERT( len(str_ret) = 3 )
		CU_ASSERT( str_ret = "asd" )

		str_ret = ltrim(" asd", "")
		CU_ASSERT( len(str_ret) = 4 )
		CU_ASSERT( str_ret = " asd" )

		str_ret = ltrim("  asd", "")
		CU_ASSERT( len(str_ret) = 5 )
		CU_ASSERT( str_ret = "  asd" )

	END_TEST

	TEST( test2 )

		str_ret = ltrim("asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(" asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("  asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test3 )

		str_ret = ltrim("asd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("xasd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("xxasd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test4 )

		str_ret = ltrim("asd", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("xasd", "xy")
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "xasd"
		CU_ASSERT( result )

		str_ret = ltrim("xyasd", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("xyasd", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "xyasd"
		CU_ASSERT( result )

		str_ret = ltrim("yyasd", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "yyasd"
		CU_ASSERT( result )

	END_TEST

	TEST( test5 )

		str_ret = ltrim("asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(" asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("  asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test6 )

		str_ret = ltrim("asd", any " a")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim(" asd", any " a")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim("  asd", any " a")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

	END_TEST

	TEST( test7 )

		str_ret = ltrim("asd", any "a ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim(" asd", any "a ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim("  asd", any "a ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

	END_TEST

	TEST( test8 )

		str_ret = ltrim("asd", any "")
		CU_ASSERT( len(str_ret) = 3 )
		CU_ASSERT( str_ret = "asd" )

		str_ret = ltrim(" asd", any "")
		CU_ASSERT( len(str_ret) = 4 )
		CU_ASSERT( str_ret = " asd" )

		str_ret = ltrim("  asd", any "")
		CU_ASSERT( len(str_ret) = 5 )
		CU_ASSERT( str_ret = "  asd" )

	END_TEST

	TEST( ltrim_var_len )

		#macro chk_ltrimDef( expr, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = ltrim( expr )
				CU_ASSERT_EQUAL( r, expected )
			end scope
		#endmacro

		#macro chk_ltrimPat( expr, pattern, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = ltrim( expr, pattern )
				CU_ASSERT_EQUAL( r, expected )
			end scope
		#endmacro

		#macro chk_ltrimAny( expr, filter, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = ltrim( expr, any filter )
				CU_ASSERT_EQUAL( r, expected )
			end scope
		#endmacro

		dim as const string n = ""
		dim as const string z = chr( 0 )
		dim as const string s = chr( 32 )
		dim as const string c = "c"
		dim as const string d = "d"
		dim as const string t = "abc"

		'' sanity checks on strings
		CU_ASSERT( len(n) = 0 )
		CU_ASSERT( len(z) = 1 )
		CU_ASSERT( len(s) = 1 )
		CU_ASSERT( len(c) = 1 )
		CU_ASSERT( len(d) = 1 )
		CU_ASSERT( len(t) = 3 )
		CU_ASSERT( len(z+z) = 2 )
		CU_ASSERT( len(z+z+t+z+z) = 7 )

		''
		chk_ltrimDef( n    , n )

		''
		chk_ltrimDef( t    , t )

		chk_ltrimDef( z+t  , z+t )
		chk_ltrimDef( s+t  , t   )
		chk_ltrimDef( d+t  , d+t )

		chk_ltrimDef( z+z+t, z+z+t )
		chk_ltrimDef( s+z+t, z+t   )
		chk_ltrimDef( d+z+t, d+z+t )

		chk_ltrimDef( z+s+t, z+s+t )
		chk_ltrimDef( s+s+t, t )
		chk_ltrimDef( d+s+t, d+s+t )

		chk_ltrimDef( z+d+t, z+d+t )
		chk_ltrimDef( s+d+t, d+t )
		chk_ltrimDef( d+d+t, d+d+t )

		''
		chk_ltrimPat( n, n, n )
		chk_ltrimPat( n, z, n )
		chk_ltrimPat( n, s, n )
		chk_ltrimPat( n, d, n )
		chk_ltrimPat( n, t, n )

		chk_ltrimPat( t, n, t )
		chk_ltrimPat( t, z, t )
		chk_ltrimPat( t, s, t )
		chk_ltrimPat( t, d, t )
		chk_ltrimPat( t, t, n )

		chk_ltrimPat( z+t, n, z+t )
		chk_ltrimPat( s+t, n, s+t )
		chk_ltrimPat( d+t, n, d+t )

		chk_ltrimPat( z+t, z, t   )
		chk_ltrimPat( s+t, z, s+t )
		chk_ltrimPat( d+t, z, d+t )

		chk_ltrimPat( z+t, s, z+t )
		chk_ltrimPat( s+t, s, t   )
		chk_ltrimPat( d+t, s, d+t )

		chk_ltrimPat( z+t, d, z+t )
		chk_ltrimPat( s+t, d, s+t )
		chk_ltrimPat( d+t, d, t   )

		chk_ltrimPat( z+z+t, n, z+z+t )
		chk_ltrimPat( z+s+t, n, z+s+t )
		chk_ltrimPat( z+d+t, n, z+d+t )
		chk_ltrimPat( s+z+t, n, s+z+t )
		chk_ltrimPat( s+s+t, n, s+s+t )
		chk_ltrimPat( s+d+t, n, s+d+t )
		chk_ltrimPat( d+z+t, n, d+z+t )
		chk_ltrimPat( d+s+t, n, d+s+t )
		chk_ltrimPat( d+d+t, n, d+d+t )

		chk_ltrimPat( z+z+t, z, t     )
		chk_ltrimPat( z+s+t, z, s+t   )
		chk_ltrimPat( z+d+t, z, d+t   )
		chk_ltrimPat( s+z+t, z, s+z+t )
		chk_ltrimPat( s+s+t, z, s+s+t )
		chk_ltrimPat( s+d+t, z, s+d+t )
		chk_ltrimPat( d+z+t, z, d+z+t )
		chk_ltrimPat( d+s+t, z, d+s+t )
		chk_ltrimPat( d+d+t, z, d+d+t )

		chk_ltrimPat( z+z+t, s, z+z+t )
		chk_ltrimPat( z+s+t, s, z+s+t )
		chk_ltrimPat( z+d+t, s, z+d+t )
		chk_ltrimPat( s+z+t, s, z+t   )
		chk_ltrimPat( s+s+t, s, t     )
		chk_ltrimPat( s+d+t, s, d+t   )
		chk_ltrimPat( d+z+t, s, d+z+t )
		chk_ltrimPat( d+s+t, s, d+s+t )
		chk_ltrimPat( d+d+t, s, d+d+t )

		chk_ltrimPat( z+z+t, d, z+z+t )
		chk_ltrimPat( z+s+t, d, z+s+t )
		chk_ltrimPat( z+d+t, d, z+d+t )
		chk_ltrimPat( s+z+t, d, s+z+t )
		chk_ltrimPat( s+s+t, d, s+s+t )
		chk_ltrimPat( s+d+t, d, s+d+t )
		chk_ltrimPat( d+z+t, d, z+t   )
		chk_ltrimPat( d+s+t, d, s+t   )
		chk_ltrimPat( d+d+t, d, t     )

		''
		chk_ltrimAny( n, n, n )
		chk_ltrimAny( n, z, n )
		chk_ltrimAny( n, s, n )
		chk_ltrimAny( n, d, n )
		chk_ltrimAny( n, t, n )

		chk_ltrimAny( t, n, t )
		chk_ltrimAny( t, z, t )
		chk_ltrimAny( t, s, t )
		chk_ltrimAny( t, d, t )
		chk_ltrimAny( t, t, n )

		chk_ltrimAny( z+t, n, z+t )
		chk_ltrimAny( s+t, n, s+t )
		chk_ltrimAny( d+t, n, d+t )

		chk_ltrimAny( z+t, z, t   )
		chk_ltrimAny( s+t, z, s+t )
		chk_ltrimAny( d+t, z, d+t )

		chk_ltrimAny( z+t, s, z+t )
		chk_ltrimAny( s+t, s, t   )
		chk_ltrimAny( d+t, s, d+t )

		chk_ltrimAny( z+t, d, z+t )
		chk_ltrimAny( s+t, d, s+t )
		chk_ltrimAny( d+t, d, t   )

		chk_ltrimAny( z+z+t, n, z+z+t )
		chk_ltrimAny( z+s+t, n, z+s+t )
		chk_ltrimAny( z+d+t, n, z+d+t )
		chk_ltrimAny( s+z+t, n, s+z+t )
		chk_ltrimAny( s+s+t, n, s+s+t )
		chk_ltrimAny( s+d+t, n, s+d+t )
		chk_ltrimAny( d+z+t, n, d+z+t )
		chk_ltrimAny( d+s+t, n, d+s+t )
		chk_ltrimAny( d+d+t, n, d+d+t )

		chk_ltrimAny( z+z+t, z, t     )
		chk_ltrimAny( z+s+t, z, s+t   )
		chk_ltrimAny( z+d+t, z, d+t   )
		chk_ltrimAny( s+z+t, z, s+z+t )
		chk_ltrimAny( s+s+t, z, s+s+t )
		chk_ltrimAny( s+d+t, z, s+d+t )
		chk_ltrimAny( d+z+t, z, d+z+t )
		chk_ltrimAny( d+s+t, z, d+s+t )
		chk_ltrimAny( d+d+t, z, d+d+t )

		chk_ltrimAny( z+z+t, s, z+z+t )
		chk_ltrimAny( z+s+t, s, z+s+t )
		chk_ltrimAny( z+d+t, s, z+d+t )
		chk_ltrimAny( s+z+t, s, z+t   )
		chk_ltrimAny( s+s+t, s, t     )
		chk_ltrimAny( s+d+t, s, d+t   )
		chk_ltrimAny( d+z+t, s, d+z+t )
		chk_ltrimAny( d+s+t, s, d+s+t )
		chk_ltrimAny( d+d+t, s, d+d+t )

		chk_ltrimAny( z+z+t, d, z+z+t )
		chk_ltrimAny( z+s+t, d, z+s+t )
		chk_ltrimAny( z+d+t, d, z+d+t )
		chk_ltrimAny( s+z+t, d, s+z+t )
		chk_ltrimAny( s+s+t, d, s+s+t )
		chk_ltrimAny( s+d+t, d, s+d+t )
		chk_ltrimAny( d+z+t, d, z+t   )
		chk_ltrimAny( d+s+t, d, s+t   )
		chk_ltrimAny( d+d+t, d, t     )
	END_TEST

END_SUITE
