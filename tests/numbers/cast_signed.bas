# include "fbcu.bi"




namespace fbc_tests.numbers.cast_signed

sub test1 cdecl ()
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cbyte( src )
	
	CU_ASSERT_EQUAL( dst, -1 )
end sub

sub test2 cdecl ()
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cshort( src )
	
	CU_ASSERT_EQUAL( dst, -1 )
end sub

sub test3 cdecl ()
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cint( src )
	
	CU_ASSERT_EQUAL( dst, -1 )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.cast_signed")
	fbcu.add_test("test1", @test1)
	fbcu.add_test("test2", @test2)
	fbcu.add_test("test3", @test3)

end sub

end namespace
