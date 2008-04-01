# include "fbcu.bi"

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

namespace fbc_tests.string_.val_

	sub test1 cdecl ()

		TestVal(    "&haxxxxf", 10     )
		TestValInt( "&haxxxxf", 10, 10 )
		TestValLng( "&haxxxxf", 10, 10 )

		TestVal(    "&o179",   15     )
		TestValInt( "&o179",   15, 15 )
		TestValLng( "&o179",   15, 15 )

		TestVal(    "&b10114", 11     )
		TestValInt( "&b10114", 11, 11 )
		TestValLng( "&b10114", 11, 11 )

	end sub

	sub test2 cdecl ()

		TestVal(    "9007199254740991",  9007199254740991                   ) '' 2^53-1
		TestValLng( "9007199254740991",  9007199254740991, 9007199254740991 )

		TestVal(            "9.007d15", 9007000000000000 )
		TestVal(            "9.007D15", 9007000000000000 )
		TestVal(            "9.007e15", 9007000000000000 )
		TestVal(            "9.007E15", 9007000000000000 )


		TestVal(    "4294967295",   4294967295             ) '' 2^32-1
		TestValInt( "4294967295",           -1, 4294967295 )
		TestValLng( "4294967295",   4294967295, 4294967295 )

		TestVal(    "-4294967295", -4294967295#                        )
		TestValInt( "-4294967295",             1,                    1 )
		TestValLng( "-4294967295", -4294967295ll, 18446744069414584321 )

		TestVal(    "2147483647",   2147483647             ) '' 2^31-1
		TestValInt( "2147483647",   2147483647, 2147483647 )
		TestValLng( "2147483647",   2147483647, 2147483647 )

		TestVal(    "-2147483648", -2147483648                      ) '' -2^31
		TestValInt( "-2147483648", -2147483648,           2147483648 )
		TestValLng( "-2147483648", -2147483648, 18446744071562067968 )


		TestVal(    "18446744073709551616", 1.8446744073709551616e+19 ) '' 2^64

		TestVal(    "18446744073709551615",    1.8446744073709551615e+19 ) '' 2^64-1
		TestValLng( "18446744073709551615", -1, 18446744073709551615     )

		TestVal(    "-18446744073709551616",  -1.8446744073709551616e+19 ) '' -2^64

		TestValLng( "-18446744073709551615", 1, 1 ) '' 1-2^64

		TestVal(     "9223372036854775807", 9.223372036854775807e+18                  ) '' 2^63-1
		TestValLng(  "9223372036854775807",  9223372036854775807, 9223372036854775807 )

		TestVal(    "-9223372036854775808", -9.223372036854775808e+18                 ) '' -2^63
		TestValLng( "-9223372036854775808", -9223372036854775808, 9223372036854775808 )


		TestVal(    "&HFFFFFFFF", 4294967295             )
		TestValInt( "&HFFFFFFFF", 4294967295,         -1 )
		TestValLng( "&HFFFFFFFF", 4294967295, 4294967295 )

		TestVal(    "&O37777777777", 4294967295             )
		TestValInt( "&O37777777777", 4294967295,         -1 )
		TestValLng( "&O37777777777", 4294967295, 4294967295 )

		TestVal(    "&B11111111111111111111111111111111", 4294967295             )
		TestValInt( "&B11111111111111111111111111111111", 4294967295,         -1 )
		TestValLng( "&B11111111111111111111111111111111", 4294967295, 4294967295 )


		TestVal(    "&HFFFFFFFFFFFFFFFF", -1                       )
		TestValLng( "&HFFFFFFFFFFFFFFFF", -1, 18446744073709551615 )

		TestVal(    "&O1777777777777777777777", -1                       )
		TestValLng( "&O1777777777777777777777", -1, 18446744073709551615 )

		TestVal(    "&B1111111111111111111111111111111111111111111111111111111111111111", -1                       )
		TestValLng( "&B1111111111111111111111111111111111111111111111111111111111111111", -1, 18446744073709551615 )

	end sub
	sub ctor () constructor

		fbcu.add_suite("fbc_tests.string.val")
		fbcu.add_test("test1", @test1)
		fbcu.add_test("test2", @test2)

	end sub

end namespace
