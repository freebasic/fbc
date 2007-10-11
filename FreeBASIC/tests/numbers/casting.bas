# include "fbcu.bi"




namespace fbc_tests.numbers.casting

sub test1 cdecl ()
	dim as integer dst, src
	
	src = &hFF
	dst = cubyte( cuint( src ) )
	
	CU_ASSERT_EQUAL( dst, &hFF )
end sub

sub test2 cdecl ()
	dim as integer dst, src
	
	src = &hFFFF
	dst = cushort( cuint( src ) )
	
	CU_ASSERT_EQUAL( dst, &hFFFF )
end sub

sub test3 cdecl ()
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cuint( src )
	
	CU_ASSERT_EQUAL( dst, &hFFFFFFFF )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.casting")
	fbcu.add_test("test1", @test1)
	fbcu.add_test("test2", @test2)
	fbcu.add_test("test3", @test3)

end sub

end namespace
