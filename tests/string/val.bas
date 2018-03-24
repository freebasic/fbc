#include "fbcunit.bi"

#macro TestVal(s_, t_)
	scope
		dim s as string = s_
		dim w as wstring * 256 => wstr(s_)
		dim t as double = t_
		CU_ASSERT_DOUBLE_EQUAL( val(s), t, 65536 )
		CU_ASSERT_DOUBLE_EQUAL( val(w), t, 65536 )
	end scope
#endmacro

#macro TestValInt(s_, ts_, tu_)
	scope
		dim s as string = s_
		dim w as wstring * 256 => wstr(s_)
		dim ts as integer = cint(ts_)
		dim tu as uinteger = cuint(tu_)
		CU_ASSERT_EQUAL(  valint(s), ts )
		CU_ASSERT_EQUAL(  valint(w), ts )
		CU_ASSERT_EQUAL( valuint(s), tu )
		CU_ASSERT_EQUAL( valuint(w), tu )
	end scope
#endmacro

#macro TestValLng(s_, ts_, tu_)
	scope
		dim s as string = s_
		dim w as wstring * 256 => wstr(s_)
		dim ts as longint = clngint(ts_)
		dim tu as ulongint = culngint(tu_)
		CU_ASSERT_EQUAL(  vallng(s), ts )
		CU_ASSERT_EQUAL(  vallng(w), ts )
		CU_ASSERT_EQUAL( valulng(s), tu )
		CU_ASSERT_EQUAL( valulng(w), tu )
	end scope
#endmacro

SUITE( fbc_tests.string_.val_ )

	TEST( test1 )

		TestVal(    "&haxxxxf", 10     )
		TestValInt( "&haxxxxf", 10, 10 )
		TestValLng( "&haxxxxf", 10, 10 )

		TestVal(    "&o179",   15     )
		TestValInt( "&o179",   15, 15 )
		TestValLng( "&o179",   15, 15 )

		TestVal(    " &179",   15     )
		TestValInt( " &179",   15, 15 )
		TestValLng( " &179",   15, 15 )

		TestVal(    "&b10114", 11     )
		TestValInt( "&b10114", 11, 11 )
		TestValLng( "&b10114", 11, 11 )

	END_TEST

	TEST( test2 )

		'' 2^53-1
		TestVal(    "9007199254740991",  9007199254740991                   )
		TestValLng( "9007199254740991",  9007199254740991, 9007199254740991 )

		TestVal(            "9.007d15", 9007000000000000 )
		TestVal(            "9.007D15", 9007000000000000 )
		TestVal(            "9.007e15", 9007000000000000 )
		TestVal(            "9.007E15", 9007000000000000 )


		'' 2^32-1
		TestVal(    "4294967295",   4294967295             )
		TestValInt( "4294967295",           -1, 4294967295 )
		TestValLng( "4294967295",   4294967295, 4294967295 )

		'' 1-2^32
		TestVal(    "-4294967295", -4294967295#                        )
		TestValInt( "-4294967295",             1,                    1 )
		TestValLng( "-4294967295", -4294967295ll, 18446744069414584321 )

		'' 2^31-1
		TestVal(    "2147483647",   2147483647             )
		TestValInt( "2147483647",   2147483647, 2147483647 )
		TestValLng( "2147483647",   2147483647, 2147483647 )

		'' -2^31
		TestVal(    "-2147483648", -2147483648                      )
		TestValInt( "-2147483648", -2147483648,           2147483648 )
		TestValLng( "-2147483648", -2147483648, 18446744071562067968 )


		'' 2^64
		TestVal(    "18446744073709551616", 1.8446744073709551616e+19 )

		'' 2^64-1
		TestVal(    "18446744073709551615",    1.8446744073709551615e+19 )
		TestValLng( "18446744073709551615", -1, 18446744073709551615     )

		'' -2^64
		TestVal(    "-18446744073709551616",  -1.8446744073709551616e+19 )

		'' 1-2^64
		TestValLng( "-18446744073709551615", 1, 1 )

		'' 2^63-1
		TestVal(     "9223372036854775807", 9.223372036854775807e+18                  )
		TestValLng(  "9223372036854775807",  9223372036854775807, 9223372036854775807 )

		'' -2^63
		TestVal(    "-9223372036854775808", -9.223372036854775808e+18                 )
		TestValLng( "-9223372036854775808", -9223372036854775808, 9223372036854775808 )

	END_TEST

	TEST( test3 )

		'' 2^31
		TestVal(    "&H80000000",  2147483648            )
		TestValInt( "&H80000000", -2147483648, 2147483648 )
		TestValLng( "&H80000000",  2147483648, 2147483648 )

		TestVal(    "&O20000000000",  2147483648           )
		TestValInt( "&O20000000000", -2147483648, 2147483648 )
		TestValLng( "&O20000000000",  2147483648, 2147483648 )

		TestVal(     "&20000000000",  2147483648             )
		TestValInt(  "&20000000000", -2147483648, 2147483648 )
		TestValLng(  "&20000000000",  2147483648, 2147483648 )

		TestVal(    "&B10000000000000000000000000000000",  2147483648             )
		TestValInt( "&B10000000000000000000000000000000", -2147483648, 2147483648 )
		TestValLng( "&B10000000000000000000000000000000",  2147483648, 2147483648 )


		'' 2^32-1
		TestVal(    "&HFFFFFFFF", 4294967295             )
		TestValInt( "&HFFFFFFFF",         -1, 4294967295 )
		TestValLng( "&HFFFFFFFF", 4294967295, 4294967295 )

		TestVal(    "&O37777777777", 4294967295             )
		TestValInt( "&O37777777777",         -1, 4294967295 )
		TestValLng( "&O37777777777", 4294967295, 4294967295 )

		TestVal(     "&37777777777", 4294967295             )
		TestValInt(  "&37777777777",         -1, 4294967295 )
		TestValLng(  "&37777777777", 4294967295, 4294967295 )

		TestVal(    "&B11111111111111111111111111111111", 4294967295             )
		TestValInt( "&B11111111111111111111111111111111",         -1, 4294967295 )
		TestValLng( "&B11111111111111111111111111111111", 4294967295, 4294967295 )


		''2^63
		TestVal(    "&H8000000000000000", -9.223372036854775807e+18                 )
		TestValLng( "&H8000000000000000", -9223372036854775808, 9223372036854775808 )

		TestVal(    "&O1000000000000000000000", -9.223372036854775807e+18                 )
		TestValLng( "&O1000000000000000000000", -9223372036854775808, 9223372036854775808 )

		TestVal(    " &1000000000000000000000", -9.223372036854775807e+18                 )
		TestValLng( " &1000000000000000000000", -9223372036854775808, 9223372036854775808 )

		TestVal(    "&B1000000000000000000000000000000000000000000000000000000000000000", -9.223372036854775807e+18                 )
		TestValLng( "&B1000000000000000000000000000000000000000000000000000000000000000", -9223372036854775808, 9223372036854775808 )

		''2^64-1
		TestVal(    "&HFFFFFFFFFFFFFFFF", -1                       )
		TestValLng( "&HFFFFFFFFFFFFFFFF", -1, 18446744073709551615 )

		TestVal(    "&O1777777777777777777777", -1                       )
		TestValLng( "&O1777777777777777777777", -1, 18446744073709551615 )

		TestVal(    " &1777777777777777777777", -1                       )
		TestValLng( " &1777777777777777777777", -1, 18446744073709551615 )

		TestVal(    "&B1111111111111111111111111111111111111111111111111111111111111111", -1                       )
		TestValLng( "&B1111111111111111111111111111111111111111111111111111111111111111", -1, 18446744073709551615 )

	END_TEST

	TEST( test0x )
		'' FB val() is typically implemented via CRT strtod() which
		'' recognizes the 0x or 0X prefix for hexadecimal numbers.
		'' FB val() shouldn't recognize the 0x/0X prefix though.
		CU_ASSERT( val( "0"   ) = 0.0 )
		CU_ASSERT( val( "0x"  ) = 0.0 )
		CU_ASSERT( val( "0X"  ) = 0.0 )
		CU_ASSERT( val( "0x0" ) = 0.0 )
		CU_ASSERT( val( "0X0" ) = 0.0 )
		CU_ASSERT( val( "0xF" ) = 0.0 )
		CU_ASSERT( val( "0XF" ) = 0.0 )

		CU_ASSERT( val( "&hF" ) = 15.0 )
		CU_ASSERT( val( "&HF" ) = 15.0 )
	END_TEST

END_SUITE
