#include "fbcunit.bi"

SUITE( fbc_tests.string_.rtrim_ )

	dim shared result as integer
	dim shared str_ret as string

	TEST( test1 )

		str_ret = rtrim("asd", "")
		CU_ASSERT( len(str_ret) = 3 )
		CU_ASSERT( str_ret = "asd" )

		str_ret = rtrim("asd ", "")
		CU_ASSERT( len(str_ret) = 4 )
		CU_ASSERT( str_ret = "asd " )

		str_ret = rtrim("asd  ", "")
		CU_ASSERT( len(str_ret) = 5 )
		CU_ASSERT( str_ret = "asd  " )

	END_TEST

	TEST( test2 )

		str_ret = rtrim("asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim("asd ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim("asd  ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test3 )

		str_ret = rtrim("asd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim("asdx", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim("asdxx", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test4 )

		str_ret = rtrim("asd", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim("asdx", "xy")
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "asdx"
		CU_ASSERT( result )

		str_ret = rtrim("asdxy", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim("asdxy", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "asdxy"
		CU_ASSERT( result )

		str_ret = rtrim("asdyy", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "asdyy"
		CU_ASSERT( result )

	END_TEST

	TEST( test5 )

		str_ret = rtrim("asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim("asd ", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim("asd  ", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test6 )

		str_ret = rtrim("asd", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = rtrim("asd ", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = rtrim("asd  ", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

	END_TEST

	TEST( test7 )

		str_ret = rtrim("asd", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = rtrim("asd ", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = rtrim("asd  ", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

	END_TEST

	TEST( test8 )

		str_ret = rtrim("asd", any "")
		CU_ASSERT( len(str_ret) = 3 )
		CU_ASSERT( str_ret = "asd" )

		str_ret = rtrim("asd ", any "")
		CU_ASSERT( len(str_ret) = 4 )
		CU_ASSERT( str_ret = "asd " )

		str_ret = rtrim("asd  ", any "")
		CU_ASSERT( len(str_ret) = 5 )
		CU_ASSERT( str_ret = "asd  " )

	END_TEST

	TEST( rtrim_var_len )

		#macro chk_rtrimDef( expr, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = rtrim( expr )
				CU_ASSERT_EQUAL( r, expected )
			end scope
		#endmacro

		#macro chk_rtrimPat( expr, pattern, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = rtrim( expr, pattern )
				CU_ASSERT_EQUAL( r, expected )
			end scope
		#endmacro

		#macro chk_rtrimAny( expr, filter, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = rtrim( expr, any filter )
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
		chk_rtrimDef( n    , n )

		''
		chk_rtrimDef( t    , t )

		chk_rtrimDef( t+z  , t   )        '' !!!INFO!!! - default is to trim chr(0) and chr(32)
		chk_rtrimDef( t+s  , t   )
		chk_rtrimDef( t+d  , t+d )

		chk_rtrimDef( t+z+z, t     )      '' !!!INFO!!! - default is to trim chr(0) and chr(32)
		chk_rtrimDef( t+s+z, t     )      '' !!!INFO!!! - default is to trim chr(0) and chr(32)
		chk_rtrimDef( t+d+z, t+d   )      '' !!!INFO!!! - default is to trim chr(0) and chr(32)

		chk_rtrimDef( t+z+s, t     )      '' !!!INFO!!! - default is to trim chr(0) and chr(32)
		chk_rtrimDef( t+s+s, t     )
		chk_rtrimDef( t+d+s, t+d   )

		chk_rtrimDef( t+z+d, t+z+d )
		chk_rtrimDef( t+s+d, t+s+d )
		chk_rtrimDef( t+d+d, t+d+d )

		''
		chk_rtrimPat( n, n, n )
		chk_rtrimPat( n, z, n )
		chk_rtrimPat( n, s, n )
		chk_rtrimPat( n, d, n )
		chk_rtrimPat( n, t, n )

		chk_rtrimPat( t, n, t )
		chk_rtrimPat( t, z, t )
		chk_rtrimPat( t, s, t )
		chk_rtrimPat( t, d, t )
		chk_rtrimPat( t, t, n )

		chk_rtrimPat( t+z, n, t+z )
		chk_rtrimPat( t+s, n, t+s )
		chk_rtrimPat( t+d, n, t+d )

		chk_rtrimPat( t+z, z, t   )
		chk_rtrimPat( t+s, z, t+s )
		chk_rtrimPat( t+d, z, t+d )

		chk_rtrimPat( t+z, s, t   )       '' !!!FIXME!!! - expected 't+z', pattern is chr(32) only
		chk_rtrimPat( t+s, s, t   )
		chk_rtrimPat( t+d, s, t+d )

		chk_rtrimPat( t+z, d, t   )       '' !!!FIXME!!! - expected 't+z', pattern is "d" only
		chk_rtrimPat( t+s, d, t+s )
		chk_rtrimPat( t+d, d, t   )

		chk_rtrimPat( t+z+z, n, t+z+z )
		chk_rtrimPat( t+z+s, n, t+z+s )
		chk_rtrimPat( t+z+d, n, t+z+d )
		chk_rtrimPat( t+s+z, n, t+s+z )
		chk_rtrimPat( t+s+s, n, t+s+s )
		chk_rtrimPat( t+s+d, n, t+s+d )
		chk_rtrimPat( t+d+z, n, t+d+z )
		chk_rtrimPat( t+d+s, n, t+d+s )
		chk_rtrimPat( t+d+d, n, t+d+d )

		chk_rtrimPat( t+z+z, z, t     )
		chk_rtrimPat( t+z+s, z, t+z+s )
		chk_rtrimPat( t+z+d, z, t+z+d )
		chk_rtrimPat( t+s+z, z, t+s   )
		chk_rtrimPat( t+s+s, z, t+s+s )
		chk_rtrimPat( t+s+d, z, t+s+d )
		chk_rtrimPat( t+d+z, z, t+d   )
		chk_rtrimPat( t+d+s, z, t+d+s )
		chk_rtrimPat( t+d+d, z, t+d+d )

		chk_rtrimPat( t+z+z, s, t     )   '' !!!FIXME!!! - expected 't+z+z', pattern is chr(32) only
		chk_rtrimPat( t+z+s, s, t     )   '' !!!FIXME!!! - expected 't+z', pattern is chr(32) only
		chk_rtrimPat( t+z+d, s, t+z+d )
		chk_rtrimPat( t+s+z, s, t     )   '' !!!FIXME!!! - expected 't+s+z', pattern is chr(32) only
		chk_rtrimPat( t+s+s, s, t     )
		chk_rtrimPat( t+s+d, s, t+s+d )
		chk_rtrimPat( t+d+z, s, t+d   )   '' !!!FIXME!!! - expected 't+d+z', pattern is chr(32) only
		chk_rtrimPat( t+d+s, s, t+d   )
		chk_rtrimPat( t+d+d, s, t+d+d )

		chk_rtrimPat( t+z+z, d, t     )   '' !!!FIXME!!! - expected 't+z+z', pattern is "d" only
		chk_rtrimPat( t+z+s, d, t+z+s )
		chk_rtrimPat( t+z+d, d, t     )   '' !!!FIXME!!! - expected 't+z', pattern is "d" only
		chk_rtrimPat( t+s+z, d, t+s   )   '' !!!FIXME!!! - expected 't+s+z', pattern is "d" only
		chk_rtrimPat( t+s+s, d, t+s+s )
		chk_rtrimPat( t+s+d, d, t+s   )
		chk_rtrimPat( t+d+z, d, t     )   '' !!!FIXME!!! - expected 't+d+z', pattern is "d" only
		chk_rtrimPat( t+d+s, d, t+d+s )
		chk_rtrimPat( t+d+d, d, t     )

		''
		chk_rtrimAny( n, n, n )
		chk_rtrimAny( n, z, n )
		chk_rtrimAny( n, s, n )
		chk_rtrimAny( n, d, n )
		chk_rtrimAny( n, t, n )

		chk_rtrimAny( t, n, t )
		chk_rtrimAny( t, z, t )
		chk_rtrimAny( t, s, t )
		chk_rtrimAny( t, d, t )
		chk_rtrimAny( t, t, n )

		chk_rtrimAny( t+z, n, t+z )
		chk_rtrimAny( t+s, n, t+s )
		chk_rtrimAny( t+d, n, t+d )

		chk_rtrimAny( t+z, z, t   )
		chk_rtrimAny( t+s, z, t+s )
		chk_rtrimAny( t+d, z, t+d )

		chk_rtrimAny( t+z, s, t+z )
		chk_rtrimAny( t+s, s, t   )
		chk_rtrimAny( t+d, s, t+d )

		chk_rtrimAny( t+z, d, t+z )
		chk_rtrimAny( t+s, d, t+s )
		chk_rtrimAny( t+d, d, t   )

		chk_rtrimAny( t+z+z, n, t+z+z )
		chk_rtrimAny( t+z+s, n, t+z+s )
		chk_rtrimAny( t+z+d, n, t+z+d )
		chk_rtrimAny( t+s+z, n, t+s+z )
		chk_rtrimAny( t+s+s, n, t+s+s )
		chk_rtrimAny( t+s+d, n, t+s+d )
		chk_rtrimAny( t+d+z, n, t+d+z )
		chk_rtrimAny( t+d+s, n, t+d+s )
		chk_rtrimAny( t+d+d, n, t+d+d )

		chk_rtrimAny( t+z+z, z, t     )
		chk_rtrimAny( t+z+s, z, t+z+s )
		chk_rtrimAny( t+z+d, z, t+z+d )
		chk_rtrimAny( t+s+z, z, t+s   )
		chk_rtrimAny( t+s+s, z, t+s+s )
		chk_rtrimAny( t+s+d, z, t+s+d )
		chk_rtrimAny( t+d+z, z, t+d   )
		chk_rtrimAny( t+d+s, z, t+d+s )
		chk_rtrimAny( t+d+d, z, t+d+d )

		chk_rtrimAny( t+z+z, s, t+z+z )
		chk_rtrimAny( t+z+s, s, t+z   )
		chk_rtrimAny( t+z+d, s, t+z+d )
		chk_rtrimAny( t+s+z, s, t+s+z )
		chk_rtrimAny( t+s+s, s, t     )
		chk_rtrimAny( t+s+d, s, t+s+d )
		chk_rtrimAny( t+d+z, s, t+d+z )
		chk_rtrimAny( t+d+s, s, t+d   )
		chk_rtrimAny( t+d+d, s, t+d+d )

		chk_rtrimAny( t+z+z, d, t+z+z )
		chk_rtrimAny( t+z+s, d, t+z+s )
		chk_rtrimAny( t+z+d, d, t+z   )
		chk_rtrimAny( t+s+z, d, t+s+z )
		chk_rtrimAny( t+s+s, d, t+s+s )
		chk_rtrimAny( t+s+d, d, t+s   )
		chk_rtrimAny( t+d+z, d, t+d+z )
		chk_rtrimAny( t+d+s, d, t+d+s )
		chk_rtrimAny( t+d+d, d, t     )
	END_TEST

END_SUITE
