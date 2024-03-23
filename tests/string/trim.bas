#include "fbcunit.bi"

SUITE( fbc_tests.string_.trim_ )

	dim shared result as integer
	dim shared str_ret as string

	TEST( trimDefaultChar )

		str_ret = trim("asd", "")
		CU_ASSERT( len(str_ret) = 3 )
		CU_ASSERT( str_ret = "asd" )

		str_ret = trim("asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("asd ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("asd  ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(" asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("  asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(" asd ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("  asd  ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( trimChar )

		str_ret = trim("asd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("asdx", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("asdxx", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("xasd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("xxasd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("xasdx", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("xxasdxx", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( trimStringTest )

		str_ret = trim("asd", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("asdx", "xy")
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "asdx"
		CU_ASSERT( result )

		str_ret = trim("asdxy", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("asdxy", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "asdxy"
		CU_ASSERT( result )

		str_ret = trim("asdyy", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "asdyy"
		CU_ASSERT( result )

		str_ret = trim("xasd", "xy")
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "xasd"
		CU_ASSERT( result )

		str_ret = trim("xyasd", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("xyasd", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "xyasd"
		CU_ASSERT( result )

		str_ret = trim("yyasd", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "yyasd"
		CU_ASSERT( result )

		str_ret = trim("xasdx", "xy")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "xasdx"
		CU_ASSERT( result )

		str_ret = trim("xyasdxy", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("xyasdxy", "yx")
		CU_ASSERT( len(str_ret) = 7 )
		result = str_ret = "xyasdxy"
		CU_ASSERT( result )

		str_ret = trim("yyasdyy", "yx")
		CU_ASSERT( len(str_ret) = 7 )
		result = str_ret = "yyasdyy"
		CU_ASSERT( result )

	END_TEST

	TEST( trimAnyCharTest )

		str_ret = trim("asd", any "")
		CU_ASSERT( len(str_ret) = 3 )
		CU_ASSERT( str_ret = "asd" )

		str_ret = trim("asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("asd ", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("asd  ", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(" asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("  asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(" asd ", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim("  asd  ", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( trimAnyString )

		str_ret = trim("asd", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("asd ", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("asd  ", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("das", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(" das", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("  das", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("dasd", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(" dasd ", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("  dasd  ", any " d")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

	END_TEST

	TEST( trimAnyStringInverted )

		str_ret = trim("asd", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("asd ", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("asd  ", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("das", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(" das", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("  das", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("dasd", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(" dasd ", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim("  dasd  ", any "d ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

	END_TEST

	TEST( trim_var_len )

		#macro chk_trimDef( expr, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = trim( expr )
				CU_ASSERT_EQUAL( r, expected )
			end scope
		#endmacro

		#macro chk_trimPat( expr, pattern, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = trim( expr, pattern )
				CU_ASSERT_EQUAL( r, expected )
			end scope
		#endmacro

		#macro chk_trimAny( expr, filter, expected )
			scope
				dim as string a = expr
				dim as string e = expected
				dim as string r = trim( expr, any filter )
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
		chk_trimDef( n    , n )

		''
		chk_trimDef( t    , t )

		chk_trimDef( z+t+z  , z+t   )       '' !!!INFO!!! - default is to trim chr(32) from left and right and chr(0) only from right
		chk_trimDef( s+t+s  , t     )
		chk_trimDef( d+t+d  , d+t+d )

		chk_trimDef( z+z+t+z+z, z+z+t     ) '' !!!INFO!!! - default is to trim chr(32) from left and right and chr(0) only from right
		chk_trimDef( s+z+t+z+s, z+t       ) '' !!!INFO!!! - default is to trim chr(32) from left and right and chr(0) only from right
		chk_trimDef( d+z+t+z+d, d+z+t+z+d )

		chk_trimDef( z+s+t+s+z, z+s+t     ) '' !!!INFO!!! - default is to trim chr(32) from left and right and chr(0) only from right
		chk_trimDef( s+s+t+s+s, t         )
		chk_trimDef( d+s+t+s+d, d+s+t+s+d )

		chk_trimDef( z+d+t+d+z, z+d+t+d   ) '' !!!INFO!!! - default is to trim chr(32) from left and right and chr(0) only from right
		chk_trimDef( s+d+t+d+s, d+t+d )
		chk_trimDef( d+d+t+d+d, d+d+t+d+d )

		''
		chk_trimPat( n, n, n )
		chk_trimPat( n, z, n )
		chk_trimPat( n, s, n )
		chk_trimPat( n, d, n )
		chk_trimPat( n, t, n )

		chk_trimPat( t, n, t )
		chk_trimPat( t, z, t )
		chk_trimPat( t, s, t )
		chk_trimPat( t, d, t )
		chk_trimPat( t, t, n )

		chk_trimPat( z+t+z, n, z+t+z )
		chk_trimPat( s+t+s, n, s+t+s )
		chk_trimPat( d+t+d, n, d+t+d )

		chk_trimPat( z+t+z, z, t   )
		chk_trimPat( s+t+s, z, s+t+s )
		chk_trimPat( d+t+d, z, d+t+d )

		chk_trimPat( z+t+z, s, z+t   )   '' !!!FIXME!!! - expected z+t+z, pattern is chr(32) only
		chk_trimPat( s+t+s, s, t     )
		chk_trimPat( d+t+d, s, d+t+d )

		chk_trimPat( z+t+z, d, z+t   )   '' !!!FIXME!!! - expected z+t+z, pattern is "d" only
		chk_trimPat( s+t+s, d, s+t+s )
		chk_trimPat( d+t+d, d, t     )

		chk_trimPat( z+z+t+z+z, n, z+z+t+z+z )
		chk_trimPat( z+s+t+s+z, n, z+s+t+s+z )
		chk_trimPat( z+d+t+d+z, n, z+d+t+d+z )
		chk_trimPat( s+z+t+z+s, n, s+z+t+z+s )
		chk_trimPat( s+s+t+s+s, n, s+s+t+s+s )
		chk_trimPat( s+d+t+d+s, n, s+d+t+d+s )
		chk_trimPat( d+z+t+z+d, n, d+z+t+z+d )
		chk_trimPat( d+s+t+s+d, n, d+s+t+s+d )
		chk_trimPat( d+d+t+d+d, n, d+d+t+d+d )

		chk_trimPat( z+z+t+z+z, z, t         )
		chk_trimPat( z+s+t+s+z, z, s+t+s     )
		chk_trimPat( z+d+t+d+z, z, d+t+d     )
		chk_trimPat( s+z+t+z+s, z, s+z+t+z+s )
		chk_trimPat( s+s+t+s+s, z, s+s+t+s+s )
		chk_trimPat( s+d+t+d+s, z, s+d+t+d+s )
		chk_trimPat( d+z+t+z+d, z, d+z+t+z+d )
		chk_trimPat( d+s+t+s+d, z, d+s+t+s+d )
		chk_trimPat( d+d+t+d+d, z, d+d+t+d+d )

		chk_trimPat( z+z+t+z+z, s, z+z+t     )   '' !!!FIXME!!! - expected z+z+t+z+z, pattern is chr(32) only
		chk_trimPat( z+s+t+s+z, s, z+s+t     )   '' !!!FIXME!!! - expected z+s+t+s+z, pattern is chr(32) only
		chk_trimPat( z+d+t+d+z, s, z+d+t+d   )   '' !!!FIXME!!! - expected z+d+t+d+z, pattern is chr(32) only
		chk_trimPat( s+z+t+z+s, s, z+t       )   '' !!!FIXME!!! - expected z+t+z, pattern is chr(32) only
		chk_trimPat( s+s+t+s+s, s, t         )
		chk_trimPat( s+d+t+d+s, s, d+t+d     )
		chk_trimPat( d+z+t+z+d, s, d+z+t+z+d )
		chk_trimPat( d+s+t+s+d, s, d+s+t+s+d )
		chk_trimPat( d+d+t+d+d, s, d+d+t+d+d )

		chk_trimPat( z+z+t+z+z, d, z+z+t     )   '' !!!FIXME!!! - expected z+z+t+z+z, pattern is 'd" only
		chk_trimPat( z+s+t+s+z, d, z+s+t+s   )   '' !!!FIXME!!! - expected z+s+t+s+z, pattern is 'd" only
		chk_trimPat( z+d+t+d+z, d, z+d+t     )   '' !!!FIXME!!! - expected z+d+t+d+z, pattern is 'd" only
		chk_trimPat( s+z+t+z+s, d, s+z+t+z+s )
		chk_trimPat( s+s+t+s+s, d, s+s+t+s+s )
		chk_trimPat( s+d+t+d+s, d, s+d+t+d+s )
		chk_trimPat( d+z+t+z+d, d, z+t       )   '' !!!FIXME!!! - expected z+t+z, pattern is 'd" only
		chk_trimPat( d+s+t+s+d, d, s+t+s     )
		chk_trimPat( d+d+t+d+d, d, t         )

		''
		chk_trimAny( n, n, n )
		chk_trimAny( n, z, n )
		chk_trimAny( n, s, n )
		chk_trimAny( n, d, n )
		chk_trimAny( n, t, n )

		chk_trimAny( t, n, t )
		chk_trimAny( t, z, t )
		chk_trimAny( t, s, t )
		chk_trimAny( t, d, t )
		chk_trimAny( t, t, n )

		chk_trimAny( z+t+z, n, z+t+z )
		chk_trimAny( s+t+s, n, s+t+s )
		chk_trimAny( d+t+d, n, d+t+d )

		chk_trimAny( z+t+z, z, t     )
		chk_trimAny( s+t+s, z, s+t+s )
		chk_trimAny( d+t+d, z, d+t+d )

		chk_trimAny( z+t+z, s, z+t+z )
		chk_trimAny( s+t+s, s, t     )
		chk_trimAny( d+t+d, s, d+t+d )

		chk_trimAny( z+t+z, d, z+t+z )
		chk_trimAny( s+t+s, d, s+t+s )
		chk_trimAny( d+t+d, d, t     )

		chk_trimAny( z+z+t+z+z, n, z+z+t+z+z )
		chk_trimAny( z+s+t+s+z, n, z+s+t+s+z )
		chk_trimAny( z+d+t+d+z, n, z+d+t+d+z )
		chk_trimAny( s+z+t+z+s, n, s+z+t+z+s )
		chk_trimAny( s+s+t+s+s, n, s+s+t+s+s )
		chk_trimAny( s+d+t+d+s, n, s+d+t+d+s )
		chk_trimAny( d+z+t+z+d, n, d+z+t+z+d )
		chk_trimAny( d+s+t+s+d, n, d+s+t+s+d )
		chk_trimAny( d+d+t+d+d, n, d+d+t+d+d )

		chk_trimAny( z+z+t+z+z, z, t         )
		chk_trimAny( z+s+t+s+z, z, s+t+s     )
		chk_trimAny( z+d+t+d+z, z, d+t+d     )
		chk_trimAny( s+z+t+z+s, z, s+z+t+z+s )
		chk_trimAny( s+s+t+s+s, z, s+s+t+s+s )
		chk_trimAny( s+d+t+d+s, z, s+d+t+d+s )
		chk_trimAny( d+z+t+z+d, z, d+z+t+z+d )
		chk_trimAny( d+s+t+s+d, z, d+s+t+s+d )
		chk_trimAny( d+d+t+d+d, z, d+d+t+d+d )

		chk_trimAny( z+z+t+z+z, s, z+z+t+z+z )
		chk_trimAny( z+s+t+s+z, s, z+s+t+s+z )
		chk_trimAny( z+d+t+d+z, s, z+d+t+d+z )
		chk_trimAny( s+z+t+z+s, s, z+t+z     )
		chk_trimAny( s+s+t+s+s, s, t         )
		chk_trimAny( s+d+t+d+s, s, d+t+d     )
		chk_trimAny( d+z+t+z+d, s, d+z+t+z+d )
		chk_trimAny( d+s+t+s+d, s, d+s+t+s+d )
		chk_trimAny( d+d+t+d+d, s, d+d+t+d+d )

		chk_trimAny( z+z+t+z+z, d, z+z+t+z+z )
		chk_trimAny( z+s+t+s+z, d, z+s+t+s+z )
		chk_trimAny( z+d+t+d+z, d, z+d+t+d+z )
		chk_trimAny( s+z+t+z+s, d, s+z+t+z+s )
		chk_trimAny( s+s+t+s+s, d, s+s+t+s+s )
		chk_trimAny( s+d+t+d+s, d, s+d+t+d+s )
		chk_trimAny( d+z+t+z+d, d, z+t+z     )
		chk_trimAny( d+s+t+s+d, d, s+t+s     )
		chk_trimAny( d+d+t+d+d, d, t         )
	END_TEST

END_SUITE
