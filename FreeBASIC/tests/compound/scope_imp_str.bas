# include "fbcu.bi"




namespace fbc_tests.compound.scope_imp_str.bas

const TEST_STR1 = "foobar"
const TEST_STR2 = "1234"

sub test_zstring cdecl ()

	dim zs1 as zstring ptr = @TEST_STR1
	dim zs2 as zstring ptr = @TEST_STR2
	dim as string res
	
	'' implicit scope with a hidden var allocated
	if( 1 ) then
		res = *zs1 + *zs2
	end if
	
	CU_ASSERT( res = TEST_STR1 + TEST_STR2 )
	
end sub

sub test_string cdecl ()

	dim s1 as string = TEST_STR1
	dim s2 as string = TEST_STR2
	dim as string res
	
	'' implicit scope with no hidden var allocated
	if( 1 ) then
		res = s1 + s2
	end if
	
	CU_ASSERT( res = TEST_STR1 + TEST_STR2 )
	
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests-compound:scope_imp_str")
	fbcu.add_test("test zstring", @test_zstring)
	fbcu.add_test("test string", @test_string)

end sub

end namespace
