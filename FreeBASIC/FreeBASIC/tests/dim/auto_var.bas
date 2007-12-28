# include "fbcu.bi"

namespace fbc_tests.dim_.auto_var

sub test_signed cdecl

	var sb = cbyte( -123 )
	var ss = cshort( -1234 )
	var si = cint( -123456 )
	var sl = clng( -1234567 )
	var sll = clngint( -123456789012345LL )
	var sf = csng( -1234.5 )
	var sd = cdbl( -12345678.9 )
	
	CU_ASSERT_EQUAL( sb, -123 )
	CU_ASSERT_EQUAL( ss, -1234 )
	CU_ASSERT_EQUAL( si, -123456 )
	CU_ASSERT_EQUAL( sl, -1234567 )
	CU_ASSERT_EQUAL( sll, -123456789012345LL )
	CU_ASSERT_EQUAL( sf, -1234.5 )
	CU_ASSERT_EQUAL( sd, -12345678.9 )
	
end sub

sub test_unsigned cdecl

	var ub = cubyte( 123 )
	var us = cushort( 1234 )
	var ui = cuint( 123456 )
	var ul = culng( 1234567 )
	var ull = culngint( 123456789012345ULL )
	
	CU_ASSERT_EQUAL( ub, 123 )
	CU_ASSERT_EQUAL( us, 1234 )
	CU_ASSERT_EQUAL( ui, 123456 )
	CU_ASSERT_EQUAL( ul, 1234567 )
	CU_ASSERT_EQUAL( ull, 123456789012345ULL )
	
end sub

sub test_str cdecl
	var s1 = "fOObAR"
	
	dim as string ts = "fOObAR"
	var s2 = ts
	
	dim as zstring * 6+1 tz = "fOObAR"
	var s3 = tz

	dim as zstring ptr tpz = @"fOObAR"
	var s4 = *tpz
	
	CU_ASSERT_EQUAL( s1, "fOObAR" )
	CU_ASSERT_EQUAL( s2, "fOObAR" )
	CU_ASSERT_EQUAL( s3, "fOObAR" )
	CU_ASSERT_EQUAL( s4, "fOObAR" )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.auto_var")
	fbcu.add_test("signed", @test_signed)
	fbcu.add_test("unsigned", @test_unsigned)
	fbcu.add_test("string", @test_str)

end sub

end namespace
	