# include "fbcu.bi"




namespace fbc_tests.numbers.cast_unsigned

sub test1 cdecl ()
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cubyte( src )
	
	CU_ASSERT_EQUAL( dst, &hFF )
end sub

sub test2 cdecl ()
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cushort( src )
	
	CU_ASSERT_EQUAL( dst, &hFFFF )
end sub

sub test3 cdecl ()
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cuint( src )
	
	CU_ASSERT_EQUAL( dst, &hFFFFFFFF )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.cast_unsigned")
	fbcu.add_test("test1", @test1)
	fbcu.add_test("test2", @test2)
	fbcu.add_test("test3", @test3)

end sub

end namespace
