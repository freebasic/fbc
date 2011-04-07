# include once "fbcu.bi"

namespace fbc_tests.expressions.dbl_to_unsigned

sub test cdecl ()
	dim as unsigned integer i
	dim as unsigned longint l
	dim as double d
	
	d = 1234.49
	i = d
	l = d
	
	CU_ASSERT_EQUAL( i, 1234 )
	CU_ASSERT_EQUAL( l, 1234 )
	
	d = 1234.5
	i = d
	l = d
	
	CU_ASSERT_EQUAL( i, 1234 )
	CU_ASSERT_EQUAL( l, 1234 )

	d = 1234.51
	i = d
	l = d
	
	CU_ASSERT_EQUAL( i, 1235 )
	CU_ASSERT_EQUAL( l, 1235 )
	
	i = 4.2e9
	CU_ASSERT_EQUAL( i, 4.2e9 )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc-tests-expressions-dbl-to-unsigned")
	fbcu.add_test("test", @test)

end sub

end namespace 
