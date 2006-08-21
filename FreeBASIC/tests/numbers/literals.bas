# include "fbcu.bi"




namespace fbc_tests.numbers.literals

sub test1 cdecl ()

	CU_ASSERT_EQUAL( 4294967295UL + 10UL, 9UL )
		
	CU_ASSERT( 4294967295UL > 2147483648UL )
	
	CU_ASSERT_EQUAL( 18446744073709551615ULL + 10ULL, 9ULL )
	
	CU_ASSERT( 9223372036854775808ULL < 18446744073709551615ULL )
	
	CU_ASSERT_EQUAL( (csng(1) or csng(2)), 3 )
		
	CU_ASSERT_EQUAL( (csng(1) shl csng(2)), 4 )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.literals")
	fbcu.add_test("test1", @test1)

end sub

end namespace
