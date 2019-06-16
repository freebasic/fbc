#include "fbcunit.bi"
#include once "chk-wstring.bi"

SUITE( fbc_tests.wstring_.ltrim_ )

	#macro check( text, length, expected )
		scope
			dim wr as wstring * 50 = ltrim( wstr(text) )
			dim we as wstring * 50 = wstr( expected )

			CU_ASSERT( len(wr) = length )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope

		scope
			dim wt as wstring * 50 = wstr( text )
			dim we as wstring * 50 = wstr( expected )
			dim wr as wstring * 50 = ltrim( wt )

			CU_ASSERT( len(wr) = length )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope
	#endmacro

	#macro check_filter( text, pattern, length, expected )
		scope
			dim wr as wstring * 50 = ltrim( wstr(text), wstr(pattern) )
			dim we as wstring * 50 = wstr( expected )

			CU_ASSERT( len(wr) = length )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope

		scope
			dim wt as wstring * 50 = wstr( text )
			dim wf as wstring * 50 = wstr( pattern )
			dim wr as wstring * 50 = ltrim( wt, wf )
			dim we as wstring * 50 = wstr( expected )

			CU_ASSERT( len(wr) = length )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope
	#endmacro

	#macro check_filter_any( text, pattern, length, expected )
		scope
			dim wr as wstring * 50 = ltrim( wstr(text), any wstr(pattern) )
			dim we as wstring * 50 = wstr( expected )

			CU_ASSERT( len(wr) = length )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope

		scope
			dim wt as wstring * 50 = wstr( text )
			dim wf as wstring * 50 = wstr( pattern )
			dim wr as wstring * 50 = ltrim( wt, any wf )
			dim we as wstring * 50 = wstr( expected )

			CU_ASSERT( len(wr) = length )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope
	#endmacro

	TEST( default )
		check( ""       , 0, "" )
		check( " "      , 0, "" )
		check( "  "     , 0, "" )
		check( "asd"    , 3, "asd" )
		check( "asd "   , 4, "asd " )
		check( "asd  "  , 5, "asd  " )
		check( " asd"   , 3, "asd" )
		check( "  asd"  , 3, "asd" )
		check( " asd "  , 4, "asd " )
		check( "  asd  ", 5, "asd  " )
	END_TEST

	TEST( filter )
		check_filter( ""       , ""  , 0, "" )
		check_filter( ""       , " " , 0, "" )
		check_filter( ""       , "  ", 0, "" )
		check_filter( " "      , ""  , 1, " " )
		check_filter( " "      , " " , 0, "" )
		check_filter( " "      , "  ", 1, " " )
		check_filter( "  "     , ""  , 2, "  " )
		check_filter( "  "     , " " , 0, "" )
		check_filter( "  "     , "  ", 0, "" )

		check_filter( "asd"    , " ", 3, "asd" )
		check_filter( "asd "   , " ", 4, "asd " )
		check_filter( "asd  "  , " ", 5, "asd  " )
		check_filter( " asd"   , " ", 3, "asd" )
		check_filter( "  asd"  , " ", 3, "asd" )
		check_filter( " asd "  , " ", 4, "asd " )
		check_filter( "  asd  ", " ", 5, "asd  " )
		
		check_filter( ""       , "x", 0, "" )
		check_filter( " "      , "x", 1, " " )
		check_filter( "x"      , "x", 0, "" )
		check_filter( "xx"     , "x", 0, "" )
		check_filter( "asd"    , "x", 3, "asd" )
		check_filter( "asdx"   , "x", 4, "asdx" )
		check_filter( "asdxx"  , "x", 5, "asdxx" )
		check_filter( "xasd"   , "x", 3, "asd" )
		check_filter( "xxasd"  , "x", 3, "asd" )
		check_filter( "xasdx"  , "x", 4, "asdx" )
		check_filter( "xxasdxx", "x", 5, "asdxx" )

		check_filter( ""       , "xy", 0, "" )
		check_filter( "xy"     , "xy", 0, "" )
		check_filter( "xyxy"   , "xy", 0, "" )
		check_filter( "xyxyx"  , "xy", 1, "x" )
		check_filter( "yxyxy"  , "xy", 5, "yxyxy" )

		check_filter( "asd"    , "xy", 3, "asd" )
		check_filter( "asdx"   , "xy", 4, "asdx" )
		check_filter( "asdxy"  , "xy", 5, "asdxy" )
		check_filter( "asdxy"  , "yx", 5, "asdxy" )
		check_filter( "asdyy"  , "yx", 5, "asdyy" )

		check_filter( "xasd"   , "xy", 4, "xasd" )
		check_filter( "xyasd"  , "xy", 3, "asd" )
		check_filter( "xyasd"  , "yx", 5, "xyasd" )
		check_filter( "yyasd"  , "yx", 5, "yyasd" )

		check_filter( "xasdx"  , "xy", 5, "xasdx" )
		check_filter( "xyasdxy", "xy", 5, "asdxy" )
		check_filter( "xyasdxy", "yx", 7, "xyasdxy" )
		check_filter( "yyasdyy", "yx", 7, "yyasdyy" )
	END_TEST


	TEST( filter_any )
		check_filter_any( ""       , ""  , 0, "" )
		check_filter_any( ""       , " " , 0, "" )
		check_filter_any( ""       , "  ", 0, "" )
		check_filter_any( " "      , ""  , 1, " " )
		check_filter_any( " "      , " " , 0, "" )
		check_filter_any( " "      , "  ", 0, "" )
		check_filter_any( "  "     , ""  , 2, "  " )
		check_filter_any( "  "     , " " , 0, "" )
		check_filter_any( "  "     , "  ", 0, "" )


		check_filter_any( "asd"    , " ", 3, "asd" )
		check_filter_any( "asd "   , " ", 4, "asd " )
		check_filter_any( "asd  "  , " ", 5, "asd  " )
		check_filter_any( " asd"   , " ", 3, "asd" )
		check_filter_any( "  asd"  , " ", 3, "asd" )
		check_filter_any( " asd "  , " ", 4, "asd " )
		check_filter_any( "  asd  ", " ", 5, "asd  " )
		
		check_filter_any( ""       , "x", 0, "" )
		check_filter_any( " "      , "x", 1, " " )
		check_filter_any( "x"      , "x", 0, "" )
		check_filter_any( "xx"     , "x", 0, "" )
		check_filter_any( "asd"    , "x", 3, "asd" )
		check_filter_any( "asdx"   , "x", 4, "asdx" )
		check_filter_any( "asdxx"  , "x", 5, "asdxx" )
		check_filter_any( "xasd"   , "x", 3, "asd" )
		check_filter_any( "xxasd"  , "x", 3, "asd" )
		check_filter_any( "xasdx"  , "x", 4, "asdx" )
		check_filter_any( "xxasdxx", "x", 5, "asdxx" )

		check_filter_any( ""       , "xy", 0, "" )
		check_filter_any( "x"      , "xy", 0, "" )
		check_filter_any( "y"      , "xy", 0, "" )
		check_filter_any( "xy"     , "xy", 0, "" )
		check_filter_any( "xyxy"   , "xy", 0, "" )
		check_filter_any( "xyxyx"  , "xy", 0, "" )
		check_filter_any( "yxyxy"  , "xy", 0, "" )

		check_filter_any( "asd"    , "xy", 3, "asd" )
		check_filter_any( "asdx"   , "xy", 4, "asdx" )
		check_filter_any( "asdxy"  , "xy", 5, "asdxy" )
		check_filter_any( "asdxy"  , "yx", 5, "asdxy" )
		check_filter_any( "asdyy"  , "yx", 5, "asdyy" )

		check_filter_any( "xasd"   , ""  , 4, "xasd" )
		check_filter_any( "xyasd"  , "xy", 3, "asd" )
		check_filter_any( "xyasd"  , "yx", 3, "asd" )
		check_filter_any( "yyasd"  , "yx", 3, "asd" )

		check_filter_any( "xasdx"  , "xy", 4, "asdx" )
		check_filter_any( "xyasdxy", "xy", 5, "asdxy" )
		check_filter_any( "xyasdxy", "yx", 5, "asdxy" )
		check_filter_any( "yyasdyy", "yx", 5, "asdyy" )

		check_filter_any( "asd"     , " d", 3, "asd" )
		check_filter_any( "asd "    , " d", 4, "asd " )
		check_filter_any( "asd  "   , " d", 5, "asd  " )
		check_filter_any( "das"     , " d", 2, "as" )
		check_filter_any( " das"    , " d", 2, "as" )
		check_filter_any( "  das"   , " d", 2, "as" )
		check_filter_any( "dasd"    , " d", 3, "asd" )
		check_filter_any( " dasd "  , " d", 4, "asd " )
		check_filter_any( "  dasd  ", " d", 5, "asd  " )
		check_filter_any( "asd"     , "d ", 3, "asd" )
		check_filter_any( "asd "    , "d ", 4, "asd " )
		check_filter_any( "asd  "   , "d ", 5, "asd  " )
		check_filter_any( "das"     , "d ", 2, "as" )
		check_filter_any( " das"    , "d ", 2, "as" )
		check_filter_any( "  das"   , "d ", 2, "as" )
		check_filter_any( "dasd"    , "d ", 3, "asd" )
		check_filter_any( " dasd "  , "d ", 4, "asd " )
		check_filter_any( "  dasd  ", "d ", 5, "asd  " )
	END_TEST

	TEST( escaped )
		check( !"\u3041\u3043\u3045\u3047\u3049"    , 5, !"\u3041\u3043\u3045\u3047\u3049" )
		check( !"  \u3041\u3043\u3045\u3047\u3049"  , 5, !"\u3041\u3043\u3045\u3047\u3049" )
		check( !"\u3041\u3043\u3045\u3047\u3049  "  , 7, !"\u3041\u3043\u3045\u3047\u3049  " )
		check( !"  \u3041\u3043\u3045\u3047\u3049  ", 7, !"\u3041\u3043\u3045\u3047\u3049  " )

		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041", _
						4, !"\u3043\u3045\u3047\u3049" )

		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043", _
						3, !"\u3045\u3047\u3049" )

		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3041", _
						5, !"\u3041\u3043\u3045\u3047\u3049" )

		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3049", _
						5, !"\u3041\u3043\u3045\u3047\u3049" )

		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049", _
						5, !"\u3041\u3043\u3045\u3047\u3049" )

		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3049\u3047", _
						5, !"\u3041\u3043\u3045\u3047\u3049" )

		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3049", _
						5, !"\u3041\u3043\u3045\u3047\u3049" )

		check_filter_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041", _
						4, !"\u3043\u3045\u3047\u3049" )

		check_filter_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043", _
						3, !"\u3045\u3047\u3049" )

		check_filter_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3041", _
						3, !"\u3045\u3047\u3049" )

		check_filter_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3049", _
						5, !"\u3041\u3043\u3045\u3047\u3049" )

		check_filter_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049", _
						5, !"\u3041\u3043\u3045\u3047\u3049" )

		check_filter_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3049\u3047", _
						5, !"\u3041\u3043\u3045\u3047\u3049" )

		check_filter_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3049", _
						4, !"\u3043\u3045\u3047\u3049" )
	END_TEST

END_SUITE
