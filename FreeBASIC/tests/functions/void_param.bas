# include "fbcu.bi"

namespace fbc_tests.functions.void_param

declare  sub test_const( byref p as any )
declare  sub test_byval( byref p as any )
declare  sub test_str( byref p as any )
	
sub test_1 cdecl ()

	test_const 1234
	test_const byval 1234
	
	dim i as integer = 5678
	test_byval byval i
	
	test_str "abcd"

end sub

sub test_const( byref p as integer )
	CU_ASSERT_EQUAL( @p, 1234 )
end sub

sub test_byval( byref p as integer )
	CU_ASSERT_EQUAL( @p, 5678 )
end sub

sub test_str( byref p as zstring ptr )
	CU_ASSERT_EQUAL( @p, @"abcd" )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.void_param")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
